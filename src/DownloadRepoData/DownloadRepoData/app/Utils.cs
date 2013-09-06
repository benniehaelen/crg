using System.IO;
using System.Net;

namespace DownloadRepoData.app
{
    internal static class Utils
    {
        /// <summary>
        /// This method copies one stream into another, using 8K buffers
        /// </summary>
        /// <param name="input"></param>
        /// <param name="output"></param>
        public static void CopyStream(Stream input, Stream output)
        {
            byte[] buffer = new byte[8 * 1024];
            int len;
            while ((len = input.Read(buffer, 0, buffer.Length)) > 0)
            {
                output.Write(buffer, 0, len);
            }

        } // method copyStream

        public static HttpWebRequest CreateGetWebRequest(string url)
        {
            var getRequest = (HttpWebRequest)WebRequest.Create(url);

            getRequest.Method = "GET";
            getRequest.KeepAlive = true;
            getRequest.ProtocolVersion = HttpVersion.Version11;
            getRequest.Accept = Constants.StandardAcceptHeaders;
            getRequest.UserAgent = Constants.UserAgent;
            getRequest.CookieContainer = new CookieContainer();

            return getRequest;

        } // method CreateGetWebRequest

        public static HttpWebRequest CreatePostWebRequest(string url)
        {
            var request = (HttpWebRequest)WebRequest.Create(url);
            request.KeepAlive = true;
            request.ProtocolVersion = HttpVersion.Version11;
            request.Method = "POST";
            request.UserAgent = Constants.UserAgent;

            return request;

        } // method CreatePostWebRequest

    } // class Utils
}
