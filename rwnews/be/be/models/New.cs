using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace be.models
{
    public class New
    {
        public int id { get; set; }

        [Required]
        public required string title { get; set; }

        [Required]
        public required string source { get; set; }

        [Required]
        public required string content { get; set; }

        [Required]
        public required DateTime date { get; set; }

        [Required]
        public required string image { get; set; }

        [Required]
        public required string email { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column(TypeName = "datetime2")]
        public DateTime? Created_At { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column(TypeName = "datetime2")]
        public DateTime? Updated_At { get; set; }

        [DefaultValue(0)]
        public int? Deleted { get; set; }
    }
}
