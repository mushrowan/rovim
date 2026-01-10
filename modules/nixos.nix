# NixOS module wrapper that adds avante API key file support
{
  config,
  lib,
  pkgs,
  ...
}: let
  shared = import ./shared.nix { inherit lib pkgs; };
  cfg = config.programs.rovim;
in {
  options.programs.rovim = shared.options;

  config = lib.mkIf cfg.enable {
    programs.rovim.finalPackage = shared.mkFinalPackage cfg;
    environment.systemPackages = [ cfg.finalPackage ];
  };
}
