using System.ComponentModel.DataAnnotations;

public class Reminder
{
    [Key]
    public Guid Id { get; set; }

    [Required]
    public string Title { get; set; }

    public string Category { get; set; }

    public DateTime DateTime { get; set; }

    public bool IsCompleted { get; set; }

    public bool IsDeleted { get; set; }

    public bool IsPinned { get; set; }
    public string UserId { get; set; }
    public AppUser User { get; set; }
}
