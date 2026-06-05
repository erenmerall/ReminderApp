using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class RemindersController : ControllerBase
{
    private readonly AppDbContext _context;

    public RemindersController(AppDbContext context)
    {
        _context = context;
    }

    private string? GetUserId()
    {
        return
            User.FindFirstValue(JwtRegisteredClaimNames.Sub) ??
            User.FindFirstValue("nameid") ??
            User.FindFirstValue(ClaimTypes.NameIdentifier);
    }

    [HttpGet]
    public async Task<IActionResult> GetReminders()
    {
        var userId = GetUserId();
        if (string.IsNullOrWhiteSpace(userId))
            return Unauthorized("Token içinden kullanıcı id okunamadı.");

        var reminders = await _context.Reminders
            .Where(r => r.UserId == userId)
            .ToListAsync();

        return Ok(reminders);
    }

    [HttpPost]
    public async Task<IActionResult> Create(Reminder reminder)
    {
        var userId = GetUserId();
        if (string.IsNullOrWhiteSpace(userId))
            return Unauthorized("Token içinden kullanıcı id okunamadı.");

        reminder.UserId = userId;

        _context.Reminders.Add(reminder);
        await _context.SaveChangesAsync();

        return Ok(reminder);
    }


    [HttpPut("{id}")]
    public async Task<IActionResult> Update(Guid id, Reminder updated)
    {
        var reminder = await _context.Reminders.FindAsync(id);
        if (reminder == null) return NotFound();

        reminder.Title = updated.Title;
        reminder.Category = updated.Category;
        reminder.DateTime = updated.DateTime;
        reminder.IsCompleted = updated.IsCompleted;
        reminder.IsDeleted = updated.IsDeleted;
        reminder.IsPinned = updated.IsPinned;

        await _context.SaveChangesAsync();
        return Ok(reminder);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var reminder = await _context.Reminders.FindAsync(id);
        if (reminder == null) return NotFound();

        _context.Reminders.Remove(reminder);
        await _context.SaveChangesAsync();
        return NoContent();
    }
}
