using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ticketSales.Models
{
    public partial class Users
    {
        public Users()
        {
            Tickets = new HashSet<Tickets>();
            UserRole = new HashSet<UserRole>();
        }

        public int Id { get; set; }
        [Required]
        public string UserName { get; set; }
        [Required]
        public string UserSurname { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }

        public ICollection<Tickets> Tickets { get; set; }
        public ICollection<UserRole> UserRole { get; set; }
    }
}
