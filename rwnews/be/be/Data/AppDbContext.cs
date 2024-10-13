using be.models;
using Microsoft.EntityFrameworkCore;

namespace be.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        public DbSet<New> News { get; set; }
    }
}
