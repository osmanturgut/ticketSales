using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ticketSales.Models;

namespace ticketSales2.Controllers
{
    public class UserController : Controller
    {
        TicketSalesContext _context;
        public UserController(TicketSalesContext context)
        {
            _context = context;
        }
        [HttpGet]
        [Route("Admin")]
        public IActionResult Login(string email, string password)
        {

            if (email != null || password != null)
            {
                var kullanici = _context.Users.Include(x => x.UserRole).Where(p => p.Email == email && p.Password == password).FirstOrDefault();
                if (kullanici != null)
                {
                    var usr_Role = _context.UserRole.Where(x => x.UserId == kullanici.Id).FirstOrDefault();
                    var yetki = _context.Roles.Where(x => x.Id == usr_Role.RoleId && x.Name == "yonetıcı").FirstOrDefault();
                    if (yetki != null)
                    {
                        return RedirectToAction("BiletList", "Admin", new { area = "" });
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home", new { kullanici.Id });
                    }
                }
                else
                {
                    ViewBag.Message = "Kullanıcı Bulunamadı";
                    return View("Index");
                }
            }
            return RedirectToAction("Index", "User", new { area = "Giriş Başarısız" });
        }
        // GET: Admin/Create
        public ActionResult Create()
        {

            return View("Create");
        }
        public ActionResult KullaniciOlustur(string UserName, string UserSurname, string Email, string Password)
        {
            
            Users usr = new Users();
            usr.Email = Email;
            usr.Password = Password;
            usr.UserName = UserName;
            usr.UserSurname = UserSurname;
            _context.Add(usr);
            _context.SaveChanges();
            int intIdt = _context.Users.Max(u => u.Id);
            UserRole usrRole = new UserRole();
            usrRole.RoleId = 2;
            usrRole.UserId = intIdt;
            _context.Add(usrRole);
            _context.SaveChanges();
            return View("Index");
        }
        public IActionResult Index()
        {

            return View("Index");
        }
    }
}