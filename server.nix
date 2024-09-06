{ pkgs, config, lib, ... }:
let
  mediaDir = "/mnt/docker_storage";  # Matches your existing file structure
  mediaGroup = "media";
in
{
  options = {
    media_server.enable = lib.mkEnableOption "Serve and store media from this machine";
  };

  config = lib.mkIf config.media_server.enable {
    # Create the media group
    users.groups.media = {};

    # Create directories and set permissions to match your structure
    systemd.tmpfiles.rules = [
      "d ${mediaDir} 0775 root media -"
      "d ${mediaDir}/complete 0775 root media -"
      "d ${mediaDir}/complete/tv 0775 root media -"
      "d ${mediaDir}/complete/movies 0775 root media -"
      "d ${mediaDir}/downloads 0775 root media -"
      "d ${mediaDir}/downloads/complete 0775 root media -"
      "d ${mediaDir}/downloads/incomplete 0775 root media -"
      "d ${mediaDir}/config 0775 root media -"
    ];

    # SABnzbd configuration
    services.sabnzbd = {
      enable = true;
      package = pkgs.sabnzbd;
   #   configFile = "${mediaDir}/config/sabnzbd/sabnzbd.ini";
    };

    # Sonarr configuration
    services.sonarr = {
      enable = true;
      dataDir = "${mediaDir}/config/sonarr";
      # mediaDirs = [ "${mediaDir}/complete/tv" ]; # Uncomment if you need specific media directories
      # downloadDirs = [ "${mediaDir}/downloads" ]; # Uncomment if you need specific download directories
      openFirewall = true;
      group = mediaGroup;
    };

    # Radarr configuration
    services.radarr = {
      enable = true;
      dataDir = "${mediaDir}/config/radarr";
      # mediaDirs = [ "${mediaDir}/complete/movies" ]; # Uncomment if you need specific media directories
      # downloadDirs = [ "${mediaDir}/downloads" ]; # Uncomment if you need specific download directories
      openFirewall = true;
      group = mediaGroup;
    };

    # Plex configuration
    services.plex = {
      enable = true;
      dataDir = "${mediaDir}/config/plex/db";
      # mediaDirs = [ "${mediaDir}/complete" ]; # For both TV and movies, uncomment if needed
      # transcodeDir = "/dev/shm"; # RAM-based transcoding, uncomment if needed
      openFirewall = true;
      group = mediaGroup;
    };

    # Bazarr configuration
    services.bazarr = {
      enable = true;
    #  dataDir = "${mediaDir}/config/bazarr";
    #  mediaDirs = [
    #    "${mediaDir}/complete/movies"
    #    "${mediaDir}/complete/tv"
    #  ];
      openFirewall = true;
      group = mediaGroup;
    };

    # Set the environment system packages (optional)
    environment.systemPackages = [
      pkgs.sabnzbd
      pkgs.plex
      pkgs.sonarr
      pkgs.radarr
      pkgs.bazarr
    ];
  };
}
