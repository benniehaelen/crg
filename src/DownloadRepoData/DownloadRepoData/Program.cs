using System;
using DownloadRepoData.app;

namespace DownloadRepoData
{
    class Program
    {
        static void Main(string[] args)
        {
            // Set the Certificate Policy
            System.Net.ServicePointManager.CertificatePolicy = new CustomCertificate();

            Arguments arguments;

            // Parse the command line arguments
            if (!parseCommandLineArguments(args, out arguments))
            {
                Console.Error.WriteLine(("Usage DownloadRepoData <userName> <password> <companyId> <fromDate> <toDate> <outputFileName>"));
                return;
            }

            // Create an instance of the DataDownloader and connect
            var downloader = new DataDownloader();
            downloader.Connect(arguments);

            //// Download the data
            downloader.DownloadData();


        } // method Main

        private static bool parseCommandLineArguments(string[] args, out Arguments arguments)
        {
            DateTime fromDate, toDate;
            arguments = new Arguments();

            // We need exactly three arguments
            if (args.Length != 6) return false;

            // Save UserName, Password and CompanyID
            arguments.UserName = args[0];
            arguments.Password = args[1];
            arguments.CompanyId = args[2];

            // Make sure that we can parse the from and to dates
            if (!DateTime.TryParse(args[3], out fromDate)) return false;
            if (!DateTime.TryParse(args[4], out toDate)) return false;

            // Set our arguments
            arguments.FromDate = fromDate;
            arguments.ToDate = toDate;
            arguments.FileName = args[5];

            return true;

        } // method parseCommandLineArguments

    } // class Program


} // namespace
