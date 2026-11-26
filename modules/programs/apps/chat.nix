{ ... }:
{
  den.aspects.apps.chat = {
    homeManager = {
      programs.vesktop.enable = true;

      xdg.desktopEntries.vesktop = {
        name = "Vesktop";
        exec = "vesktop --ozone-platform=x11 %U";
        icon = "vesktop";
        type = "Application";
        terminal = false;

      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];

      mimeType = [ "x-scheme-handler/discord" ];
      };
    };
  };
}
