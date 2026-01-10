# Home Manager module wrapper that adds avante API key file support
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.rovim;
in {
  options.programs.rovim = {
    enable = lib.mkEnableOption "rovim neovim configuration";

    avanteApiKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Path to a file containing the Anthropic API key for avante.nvim.
        The file should contain only the API key with no trailing newline.
        This is useful for integration with sops-nix or agenix.
      '';
      example = "/run/secrets/anthropic-api-key";
    };

    package = lib.mkOption {
      type = lib.types.package;
      description = "The rovim package to use";
    };

    finalPackage = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "The final wrapped rovim package with API key injection";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.rovim.finalPackage =
      if cfg.avanteApiKeyFile != null
      then
        pkgs.symlinkJoin {
          name = "rovim-wrapped";
          paths = [cfg.package];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/nvim \
              --run 'export ANTHROPIC_API_KEY="$(cat ${cfg.avanteApiKeyFile})"'
          '';
        }
      else cfg.package;

    home.packages = [cfg.finalPackage];
  };
}
