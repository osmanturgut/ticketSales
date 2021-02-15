using System;
using System.Collections.Generic;

namespace ticketSales.Models
{
    public partial class Expeditions
    {
        public Expeditions()
        {
            Tickets = new HashSet<Tickets>();
        }

        public int Id { get; set; }
        public int BusId { get; set; }
        public int RouteId { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan Time { get; set; }
        public double Price { get; set; }

        public Buses Bus { get; set; }
        public Routes Route { get; set; }
        public ICollection<Tickets> Tickets { get; set; }
    }
}
