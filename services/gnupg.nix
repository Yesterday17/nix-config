{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Required to operate on smartcard
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-personalization
  ];

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services.udev.packages = with pkgs; [ yubikey-personalization ];
}
