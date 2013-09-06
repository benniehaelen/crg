using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;

namespace DownloadRepoData.app
{
    internal class DataDownloader
    {

        #region private fields

        // We get this cookie from the site, we need to make sure that we pass this each time
        private Cookie _sessionCookie;

        // These are the command line arguments passed by the user
        private Arguments _arguments;

        #endregion private fields


        #region public methods

        /// <summary>
        /// This method connects to the site
        /// </summary>
        /// <param name="arguments"></param>
        public void Connect(Arguments arguments)
        {
            // Save the arguments
            _arguments = arguments;

            Console.WriteLine(String.Format("Starting Connect to Site: {0}", Constants.BaseUrl));

            // Get the session cookie first, then log in 
            getSessonCookie();
            login();

            Console.WriteLine(String.Format("Connect to Site: {0} successfull!", Constants.BaseUrl));

        } // method Connect

        public void DownloadData()
        {
            Console.WriteLine("Starting Download of Data...");

            // First make sure that we have it set so that we get all columns
            postColumns();

            // Get the report
            performReportGet();

            // Export the report
            performExport();

            Console.WriteLine(string.Format("Download of Data Complete, FileName: {0} ....", _arguments.FileName));

        } // method DownloadData

        #endregion public methods

        private void getSessonCookie()
        {
            //
            //  Create the WebRequest
            //
            var request = Utils.CreateGetWebRequest(Constants.BaseUrl);

            //
            //  Get the Response
            //
            using (var firstResponse = (HttpWebResponse)request.GetResponse())
            {
                _sessionCookie = firstResponse.Cookies[0];
            }

            Console.WriteLine(String.Format("\tRetrieved Session Cookie: Name {0}, Value: {1}...", _sessionCookie.Name, _sessionCookie.Value));

        } // method getSessonCookie

        private void login()
        {
            var request = Utils.CreatePostWebRequest(Constants.LoginUrl);

            // Write the login parameters to the request stream
            string connectString =
                String.Format(
                    "username={0}&password={1}&companyID={2}&secure=on",
                    _arguments.UserName, _arguments.Password, _arguments.CompanyId);
            byte[] postBytes = Encoding.ASCII.GetBytes(connectString);

            request.ContentType = Constants.StandardContentType;
            request.ContentLength = postBytes.Length;
            request.CookieContainer = new CookieContainer();
            request.CookieContainer.Add(_sessionCookie);
            using (var requestStream = request.GetRequestStream())
            {
                requestStream.Write(postBytes, 0, postBytes.Length);
                requestStream.Close();
            }

            var response = (HttpWebResponse)request.GetResponse();
            response.Close();

        } // method login

        private void postColumns()
        {
            var request = Utils.CreatePostWebRequest(Constants.columnsUrl);

            byte[] postBytes = Encoding.ASCII.GetBytes(Constants.AllColumns);
            request.ContentType = Constants.StandardContentType;
            request.ContentLength = postBytes.Length;
            request.CookieContainer = new CookieContainer();
            request.CookieContainer.Add(_sessionCookie);

            using (var requestStream = request.GetRequestStream())
            {
                requestStream.Write(postBytes, 0, postBytes.Length);
                requestStream.Close();
            }

            var response = (HttpWebResponse)request.GetResponse();
            response.Close();

            Console.WriteLine("\tPosted the column names...");

        } // method postColumns

        private void performReportGet()
        {
            var request = Utils.CreateGetWebRequest(Constants.InitialReportUrl);
            request.CookieContainer.Add(_sessionCookie);

            var response = (HttpWebResponse)request.GetResponse();
            response.Close();

            Console.WriteLine("\tPerformed Report Get...");

        } // method performReportGet

        private void performExport()
        {
            var request = Utils.CreateGetWebRequest(Constants.ExportUrl);
            request.CookieContainer.Add(_sessionCookie);
            request.AutomaticDecompression = DecompressionMethods.Deflate | DecompressionMethods.GZip;

            using (var file = File.Create(_arguments.FileName))
            {
                using (var response = (HttpWebResponse)request.GetResponse())
                {
                    using (var responseStream = response.GetResponseStream())
                    {
                        Utils.CopyStream(responseStream, file);
                    }
                }
            }

            Console.WriteLine("\tPerformed Report Export...");

        } // method performExport


    } // clas DataDownloader
}
