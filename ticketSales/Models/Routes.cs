using System;
using System.Collections.Generic;

namespace ticketSales.Models
{
    public partial class Routes
    {
        public Routes()
        {
            Expeditions = new HashSet<Expeditions>();
        }

        public int Id { get; set; }
        public string Departure { get; set; }
        public string Arrival { get; set; }

        public ICollection<Expeditions> Expeditions { get; set; }
    }
}
