using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics;

namespace GettingStarted.Frontend.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;
    private readonly ActivitySource _activitySource;


    public IndexModel(ILogger<IndexModel> logger, ActivitySource activitySource)
    {
        _logger = logger;
        _activitySource = activitySource;
    }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        using var activity = _activitySource.StartActivity("IndexPage_OnPost_PressMe", ActivityKind.Internal);
        activity?.SetTag("user.action", "button_press");
        activity?.SetTag("custom.message", "User clicked the button on the index page");
        Thread.Sleep(200);
        activity?.Stop();
        TempData["ShowToast"] = true;
    }
}
