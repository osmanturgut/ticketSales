using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ticketSales.Models;
using ticketSales.ViewModel;

namespace ticketSales2.Controllers
{
    public class AdminController : Controller
    {
        TicketSalesContext _context;
       

        public AdminController(TicketSalesContext context)
        {
            _context = context;
        }
        // GET: Admin
        public ActionResult BiletList()
        {

            var biletler = _context.Tickets.ToList();
            var kullanıcılar = _context.Users.ToList();
            var güzergahlar = _context.Routes.ToList();
            var seferler = _context.Expeditions.ToList();

            List<BiletDetayViewModel> biletList = new List<BiletDetayViewModel>();
            if(biletler != null)
            {
                foreach (var item in biletler)
                {
                    BiletDetayViewModel obj = new BiletDetayViewModel();
                    obj.Date = seferler.Where(x => x.Id == item.ExpeditionId).FirstOrDefault().Date;
                    obj.Time = seferler.Where(x => x.Id == item.ExpeditionId).FirstOrDefault().Time;
                    obj.Arrival = güzergahlar.Where(x => x.Id == (seferler.Where(y => y.Id == item.ExpeditionId).FirstOrDefault().RouteId)).FirstOrDefault().Arrival;
                    obj.Departure = güzergahlar.Where(x => x.Id == (seferler.Where(y => y.Id == item.ExpeditionId).FirstOrDefault().RouteId)).FirstOrDefault().Departure;
                    obj.TicketPrice = item.TicketPrice;
                    obj.Email = kullanıcılar.Where(x => x.Id == item.UserId).FirstOrDefault().Email;
                    obj.Id = item.Id;
                    obj.Status = item.Status;
                    biletList.Add(obj);
                }
            }

            biletList.OrderBy(x => x.Date);
            // satılan bilet listesi 

            return View("BiletList", biletList);
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Cikis()
        {

            return RedirectToAction("Index", "User", new { area = "" });
        }
        public ActionResult Iptal(int id)
        {
            Tickets bilet = new Tickets();
            bilet= _context.Tickets.Where(x => x.Id == id).FirstOrDefault();
            bilet.Status = false;
            _context.SaveChanges();
            return RedirectToAction("BiletList", "Admin", new { area = "" });
        }
    }
}