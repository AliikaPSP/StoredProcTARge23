using Microsoft.AspNetCore.Mvc;

namespace StoredProcedure.Controllers
{
    public class EmployeeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
