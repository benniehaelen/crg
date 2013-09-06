using System;

namespace DownloadRepoData.app
{
    internal class Arguments
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public string CompanyId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string FileName { get; set; }

    } // class Arguments

} // namespace 
