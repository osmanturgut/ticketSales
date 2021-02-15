using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ticketSales.ViewModel
{
    public class BiletDetayViewModel
    {

        public int Id { get; set; }
        public int ExpeditionId { get; set; }
        public double TicketPrice { get; set; }
        public string Email { get; set; }
        public byte SeatNumber { get; set; }
        public bool Status { get; set; }
        public string Departure { get; set; }
        public string Arrival { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan Time { get; set; }
        public double Price { get; set; }
    }
}

