using System.Net;
using System.Security.Cryptography.X509Certificates;

namespace DownloadRepoData.app
{
    class CustomCertificate : ICertificatePolicy
    {
        public bool CheckValidationResult(
            ServicePoint srvPoint, 
            X509Certificate certificate, 
            WebRequest request, 
            int certificateProblem)
        {
            return true;
        }

    } // class CustomCertificate

} // namespace 
