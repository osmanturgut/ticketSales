using System;
using System.Collections.Generic;

namespace ticketSales.Models
{
    public partial class Tickets
    {
        public int Id { get; set; }
        public int ExpeditionId { get; set; }
        public double TicketPrice { get; set; }
        public int UserId { get; set; }
        public byte SeatNumber { get; set; }
        public bool Status { get; set; }

        public Expeditions Expedition { get; set; }
        public Users User { get; set; }
    }
}
