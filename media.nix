{ pkgs, config, lib, ... }:

{
  options = {
    media_server.enable = lib.mkEnableOption "Enable media server services";
  };

  config = lib.mkIf config.media_server.enable {
    # Set up the media group
    users.groups.media = {};

    # Define Radarr service
    services.radarr = {
      enable = true; # Enables the Radarr service
      user = "radarr"; # Sets the user under which Radarr runs
      package = pkgs.radarr; # Specifies the package to use
      openFirewall = true; # Opens firewall rules for Radarr
      group = "media"; # Sets the group for Radarr
      dataDir = "/mnt/docker_storage/config/radarr"; # Directory for Radarr data
    };

    # Define Sonarr service
    services.sonarr = {
      enable = true; # Enables the Sonarr service
      user = "sonarr"; # Sets the user under which Sonarr runs
      package = pkgs.sonarr; # Specifies the package to use
      openFirewall = true; # Opens firewall rules for Sonarr
      group = "media"; # Sets the group for Sonarr
      dataDir = "/mnt/docker_storage/config/sonarr"; # Directory for Sonarr data
    };

    # Define Bazarr service
    services.bazarr = {
      enable = true; # Enables the Bazarr service
      user = "bazarr"; # Sets the user under which Bazarr runs
      openFirewall = true; # Opens firewall rules for Bazarr
      listenPort = 6767; # Port Bazarr listens on
      group = "media"; # Sets the group for Bazarr
    };

    # Define SABnzbd service
    services.sabnzbd = {
      enable = true; # Enables the SABnzbd service
      user = "sabnzbd"; # Sets the user under which SABnzbd runs
      package = pkgs.sabnzbd; # Specifies the package to use
      openFirewall = true; # Opens firewall rules for SABnzbd
      group = "media"; # Sets the group for SABnzbd
      configFile = "/mnt/docker_storage/config/sabnzbd/sabnzbd.ini"; # Path to the configuration file
    };
    services.plex = {
      enable = true;
      user = "plex";
      package = pkgs.plex;
      group = "media";
      opneFirewall = true;
      dataDir = "/mnt/dockerstorage/config/plex";
    };


  };
}
