using System;
using System.Collections.Generic;

namespace ticketSales.Models
{
    public partial class Buses
    {
        public Buses()
        {
            Expeditions = new HashSet<Expeditions>();
        }

        public int Id { get; set; }
        public string Plaque { get; set; }

        public ICollection<Expeditions> Expeditions { get; set; }
    }
}
