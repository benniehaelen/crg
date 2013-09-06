
namespace CRG.Reporting.Domain
{
    public class StatusCountValue
    {
        public int MonthKey { get; set; }
        public int Year { get; set; }
        public string MonthName { get; set; }
        public int Repossessed { get; set; }
        public int OnHold { get; set; }
        public int Closed { get; set; }
        public int Open { get; set; }
        public int Reassigned { get; set; }
        public int NeedInfo { get; set; }
        public int ClosedPositiveResolution { get; set; }
        public int Completed { get; set; }
        public int PendingClose { get; set; }
        public int PendingOnHold { get; set; }

    } // class StatusCountValue

} // namespace 
