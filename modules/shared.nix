# Shared module logic for rovim NixOS and Home Manager modules
{ lib, pkgs }:
{
  # Common options for both NixOS and Home Manager modules
  options = {
    enable = lib.mkEnableOption "rovim neovim configuration";

    anthropicApiKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Path to a file containing the Anthropic API key for AI plugins.
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

  # Build the final package with optional API key wrapping
  mkFinalPackage = cfg:
    if cfg.anthropicApiKeyFile != null
    then
      pkgs.symlinkJoin {
        name = "rovim-wrapped";
        paths = [ cfg.package ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/nvim \
            --run 'export ANTHROPIC_API_KEY="$(cat ${cfg.anthropicApiKeyFile})"'
        '';
      }
    else cfg.package;
}
