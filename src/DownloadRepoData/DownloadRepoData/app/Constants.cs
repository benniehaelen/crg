namespace DownloadRepoData.app
{
    internal class Constants
    {
        public const string BaseUrl = @"https://www.recoverydatabase.net";
        public const string LoginUrl = BaseUrl + @"/v2/security/user_login.php";
        public const string columnsUrl = BaseUrl + @"/v2.5/users/multisearch/adjust_columns.php";
        public const string InitialReportUrl =
            @"https://www.recoverydatabase.net/v2.5/users/multisearch/results.php?liennames=&assigneename=&clientissid=&order_worker=&investigator=&claim_number=&VehicleVIN=&VehicleYear=&VehicleMake=&title_received=&VehicleModel=&ROFirstName=&romi=&ROLastName=&ssn=&VehicleLicenseNo=&address=&city=&county=&zip=&RecoveryAddress=&RecoveryCity=&RecoveryState=&RecoveryZip=&alert=&ICRA%5Bticket%5D=&ICRA%5B1_start%5D=&ICRA%5B1_end%5D=&ICRA%5B2_start%5D=&ICRA%5B2_end%5D=&KeyStatus=&StorageLocation=&transport_coby=&transported_to=&LastUpdated=&addl_collateral=&hold_reason=&closereason=&TransportTo=&ReleaseTo=&agent=&date_action_agent=&DateFromAgent=&DateToAgent=&udbsaid=&branchID=&date_action=&DateFrom=&DateTo=&date_action_2=&DateFrom2=2013-05-01&DateTo2=2013-05-02&sort_results_by=regowner.id&Submit=Search%21";

        public const string ExportUrl = BaseUrl + @"/v2.5/users/multisearch/export.php";

        public const string StandardAcceptHeaders = @"text/html, application/xhtml+xml, */*";
        public const string UserAgent = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)";
        public const string StandardContentType = @"application/x-www-form-urlencoded";

        public const string AllColumns =
            @"criteria=a:51:{s:9:'liennames';s:0:'';s:12:'assigneename';s:0:'';s:11:'clientissid';s:0:'';s:12:'order_worker';s:0:'';s:12:'investigator';s:0:'';s:12:'claim_number';s:0:'';s:10:'VehicleVIN';s:0:'';s:11:'VehicleYear';s:0:'';s:11:'VehicleMake';s:0:'';s:14:'title_received';s:0:'';s:12:'VehicleModel';s:0:'';s:11:'ROFirstName';s:0:'';s:4:'romi';s:0:'';s:10:'ROLastName';s:0:'';s:3:'ssn';s:0:'';s:16:'VehicleLicenseNo';s:0:'';s:7:'address';s:0:'';s:4:'city';s:0:'';s:6:'county';s:0:'';s:3:'zip';s:0:'';s:15:'RecoveryAddress';s:0:'';s:12:'RecoveryCity';s:0:'';s:13:'RecoveryState';s:0:'';s:11:'RecoveryZip';s:0:'';s:5:'alert';s:0:'';s:4:'ICRA';a:5:{s:6:'ticket';s:0:'';s:7:'1_start';s:0:'';s:5:'1_end';s:0:'';s:7:'2_start';s:0:'';s:5:'2_end';s:0:'';}s:9:'KeyStatus';s:0:'';s:15:'StorageLocation';s:0:'';s:14:'transport_coby';s:0:'';s:14:'transported_to';s:0:'';s:11:'LastUpdated';s:0:'';s:15:'addl_collateral';s:0:'';s:11:'hold_reason';s:0:'';s:11:'closereason';s:0:'';s:11:'TransportTo';s:0:'';s:9:'ReleaseTo';s:0:'';s:5:'agent';s:0:'';s:17:'date_action_agent';s:0:'';s:13:'DateFromAgent';s:0:'';s:11:'DateToAgent';s:0:'';s:7:'udbsaid';s:0:'';s:8:'branchID';s:0:'';s:11:'date_action';s:0:'';s:8:'DateFrom';s:0:'';s:6:'DateTo';s:0:'';s:13:'date_action_2';s:0:'';s:9:'DateFrom2';s:10:'2013-05-01';s:7:'DateTo2';s:10:'2013-05-02';s:15:'sort_results_by';s:11:'regowner.id';s:6:'Submit';s:7:'Search!';s:4:'page';i:1;}";

    } // class Constants
}
