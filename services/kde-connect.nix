{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.yesterday17.services.kdeconnect.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      {
        from = 5353;
        to = 5353;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
