namespace CRG.Reporting.Domain
{
    public class StatusCountValuesParameters
    {
        public int StartingYear { get; set; }
        public int EndingYear { get; set; }
        public int? CaseWorkerKey { get; set; }
    }
    // { "StartingYear": 2011, "EndingYear": 2013, "CaseWorkerKey": undefined }
}
