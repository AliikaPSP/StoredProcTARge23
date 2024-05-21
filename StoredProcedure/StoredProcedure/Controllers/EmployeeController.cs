using Microsoft.AspNetCore.Mvc;
using StoredProcedure.Models;
using StoredProcedure.Data;
using Microsoft.EntityFrameworkCore;

namespace StoredProcedure.Controllers
{
    public class EmployeeController : Controller
    {
        public StoredProcDbContext _context;
        public EmployeeController
            (
                StoredProcDbContext context
            )
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IEnumerable<Employee> SearchResult()
        {
            var result = _context.Employees
                .FromSqlRaw<Employee>("spSearchEmployees")
                .ToList();

            return result;
        }
    }
}
