using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using ticketSales.Models;
using ticketSales.ViewModel;
using static System.Net.WebRequestMethods;

namespace ticketSales.Controllers
{
    public class HomeController : Controller
    {
        TicketSalesContext _context;

        public HomeController(TicketSalesContext context)
        {
            _context = context;
        }
        public IActionResult Index(int id,string message)
        {
            if(id != 0)
            {
                ViewBag.user_id = id;
                ViewBag.Message = message;
                return View();
                
            }
            //Users usr = new Users();
            //usr = _context.Users.Where(x => x.Id == id).FirstOrDefault();
            return RedirectToAction("Index", "Admin", new { });
        }
        [HttpPost]
        public IActionResult SeferAra(string kalkis_ili, string varis_ili,DateTime yolculukTarihi,int user_id)
        {


            varis_ili = varis_ili.ToUpper();
            kalkis_ili = kalkis_ili.ToUpper();

            SeferDetayViewModel seferDetay = new SeferDetayViewModel();

            Users usr = new Users();
            usr = _context.Users.Where(x => x.Id == user_id).FirstOrDefault();
            TimeSpan ts = new TimeSpan(yolculukTarihi.Hour, yolculukTarihi.Minute, 0);
            //ViewBag.Yazarlar = yazarlar;
            // güzergah arıyoruz eğer varise bu güzergah gelen tarihte sefer varmı ona bakılacak
            Routes guzergah = new Routes();
            guzergah = _context.Routes.Where(p => p.Arrival == varis_ili && p.Departure == kalkis_ili).First();

            // güzergah bulundu sefer aramaya gidiyoruz güzergah id + tarih +saat ile
            
            seferDetay.Sefer = _context.Expeditions.Where(p => p.RouteId == guzergah.Id && p.Date== yolculukTarihi && p.Time == ts).FirstOrDefault();
            if(seferDetay.Sefer !=null)
            {
                seferDetay.User = usr;
                seferDetay.Varıs = varis_ili;
                seferDetay.Kalkıs = kalkis_ili;

                
                
                List<Tickets> biletler = _context.Tickets.Where(x => x.ExpeditionId == seferDetay.Sefer.Id).ToList();
                
                return View("BiletAl",seferDetay);
            }
            int id = user_id;
            return RedirectToAction("Index", "Home", new { id });
        }
        public IActionResult BiletAl(int sefer_id, int user_id , double fiyat)
        {
            Tickets bilet = new Tickets();
            bilet.SeatNumber = 1;
            bilet.Status = true;
            bilet.UserId = user_id;
            bilet.ExpeditionId = sefer_id;
            bilet.TicketPrice = fiyat;
            _context.Add(bilet);
            _context.SaveChanges();

            Expeditions sefer = new Expeditions();
            sefer = _context.Expeditions.Where(x => x.Id == sefer_id).FirstOrDefault();

            int biletSayısı = _context.Tickets.Where(x => x.ExpeditionId == sefer_id && x.Status == true).Count();
            if(biletSayısı % 5 == 0)
            {
                double yeniFiyat = sefer.Price+((sefer.Price * 10) / 100);
                sefer.Price = yeniFiyat;
                _context.SaveChanges();
            }
            int id = user_id;

            string message = "Biletiniz Alındı...";
            return RedirectToAction("Index", "Home", new { id,message });
        }
        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";
                      
            return View();
        }
      


        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
