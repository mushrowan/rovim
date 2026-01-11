{
  description = "Ro's neovim config, with NixCats!";

  outputs = {
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = ./.;
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    extra_pkg_config = {
      allowUnfree = true;
    };
    dependencyOverlays = [
      (utils.standardPluginOverlay inputs)
      # Build direnv-nvim from source since it's not in nixpkgs
      (final: prev: {
        neovimPlugins = prev.neovimPlugins or {} // {
          direnv-nvim = final.vimUtils.buildVimPlugin {
            pname = "direnv-nvim";
            version = "unstable";
            src = inputs."plugins-direnv-nvim";
          };
        };
      })
    ];
    categoryDefinitions = {
      name,
      pkgs,
      ...
    }: {
      # LSPs and runtime dependencies by category
      lspsAndRuntimeDeps = {
        editor = with pkgs; [
          ripgrep
          luajitPackages.sqlite
        ];
        lsp = with pkgs; [
          # Nix
          alejandra
          nil
          nixd
          statix
          # Lua
          lua-language-server
          stylua
          # Shell
          bash-language-server
          shellcheck
          shfmt
          # Web
          typescript
          typescript-language-server
          vscode-json-languageserver
          prettier
          # Go
          gopls
          # Python
          ruff
          # .NET
          csharp-ls
          # Dart
          dart
          # Data formats
          yaml-language-server
          sqls
          # Docker
          docker-compose-language-service
          docker-ls
          dockerfile-language-server
          dockerfmt
          # Terraform
          terraform-ls
          # Docs
          markdown-oxide
          marksman
          # Jinja
          jinja-lsp
          # QML
          kdePackages.qtdeclarative
          quickshell
          # Misc
          caddy
          trivy
        ];
        typst = with pkgs; [
          typst
          typstPackages.easytable
          tinymist
          zathura
        ];
      };

      # Plugins loaded at startup (always needed)
      startupPlugins = {
        editor = with pkgs.vimPlugins; [
          lze
          lzextras
          nui-nvim
          plenary-nvim
        ];
      };

      # Lazy-loaded plugins by category
      optionalPlugins = {
        # Core editing functionality
        editor = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          rose-pine
          pkgs.neovimPlugins."direnv-nvim"
          which-key-nvim
          flash-nvim
          mini-icons
          mini-surround
          yanky-nvim
          oil-nvim
          smart-splits-nvim
          persistence-nvim
          snacks-nvim
          sqlite-lua
        ];

        # UI enhancements
        ui = with pkgs.vimPlugins; [
          lualine-nvim
          scope-nvim
          tabby-nvim
          noice-nvim
          nvim-notify
        ];

        # LSP and language support
        lsp = with pkgs.vimPlugins; [
          nvim-lspconfig
          lsp_lines-nvim
          lazydev-nvim
          rustaceanvim
          jinja-vim
        ];

        # Completion
        completion = with pkgs.vimPlugins; [
          blink-cmp
          blink-compat
        ];

        # Git integration
        git = with pkgs.vimPlugins; [
          gitsigns-nvim
        ];

        # Testing
        testing = with pkgs.vimPlugins; [
          neotest
          neotest-rust
          nvim-dap
        ];

        # Notes and markdown
        notes = with pkgs.vimPlugins; [
          obsidian-nvim
          render-markdown-nvim
          bullets-vim
        ];

        # Formatting and linting
        format = with pkgs.vimPlugins; [
          conform-nvim
          nvim-lint
        ];

        # AI assistance
        ai = with pkgs.vimPlugins; [
          avante-nvim
        ];

        # Remote development
        remote = with pkgs.vimPlugins; [
          (pkgs.vimPlugins.remote-nvim-nvim.overrideAttrs (finalAttrs: previousAttrs: {
            dontPatchShebangs = true;
          }))
        ];

        # Discord rich presence
        discordRichPresence = [
          pkgs.vimPlugins.neocord
        ];

        # Typst support
        typst = with pkgs.vimPlugins; [
          typst-preview-nvim
        ];
      };
    };

    packageDefinitions = {
      nvim = {
        pkgs,
        name,
        ...
      }: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
        };
        categories = {
          editor = true;
          ui = true;
          lsp = true;
          completion = true;
          git = true;
          testing = true;
          notes = true;
          format = true;
          ai = true;
          remote = true;
          discordRichPresence = false;
          typst = false;
        };
      };
      # Dev mode: uses local lua files for live reloading
      nvim-dev = {
        pkgs,
        name,
        ...
      }: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = false; # Use local config, not baked-in
        };
        categories = {
          editor = true;
          ui = true;
          lsp = true;
          completion = true;
          git = true;
          testing = true;
          notes = true;
          format = true;
          ai = true;
          remote = true;
          discordRichPresence = false;
          typst = false;
        };
      };
    };

    defaultPackageName = "nvim";
  in
    forEachSystem (system: let
      nixCatsBuilder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions;
      nvimPackage = nixCatsBuilder defaultPackageName;
      nvimDevPackage = nixCatsBuilder "nvim-dev";
      pkgs = import nixpkgs {inherit system;};

      # Neovide wrapper that uses our custom nvim
      neovideWrapper = pkgs.writeShellScriptBin "rovim" ''
        exec ${pkgs.neovide}/bin/neovide --neovim-bin ${nvimPackage}/bin/nvim "$@"
      '';

      # Dev mode neovide wrapper (uses local config)
      neovideDevWrapper = pkgs.writeShellScriptBin "rovim-dev" ''
        exec ${pkgs.neovide}/bin/neovide --neovim-bin ${nvimDevPackage}/bin/nvim "$@"
      '';

      # Combined package with both neovide wrapper and nvim
      defaultPackage = pkgs.symlinkJoin {
        name = "rovim";
        paths = [neovideWrapper nvimPackage];
      };

      # Dev package for live config reloading
      devPackage = pkgs.symlinkJoin {
        name = "rovim-dev";
        paths = [neovideDevWrapper nvimDevPackage];
      };
    in {
      packages = {
        default = defaultPackage;
        neovide = defaultPackage;
        nvim = nvimPackage;
        # Dev mode packages (use local lua files, changes apply on restart)
        dev = devPackage;
        neovide-dev = devPackage;
        nvim-dev = nvimDevPackage;
      };

      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [nvimDevPackage]; # Use dev package in shell for live editing
        };
      };

      checks.default = pkgs.runCommand "nvim-config-check" {
        nativeBuildInputs = [nvimPackage];
      } ''
        export HOME=$(mktemp -d)
        nvim --headless +'lua print("Config loaded successfully")' +qa 2>&1 | tee $out
        if grep -q "Error" $out; then
          echo "Neovim config has errors!"
          exit 1
        fi
      '';
    })
    // {
      overlays =
        utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions
        defaultPackageName;

      nixosModules.default = ./modules/nixos.nix;
      homeModules.default = ./modules/home-manager.nix;

      inherit utils;
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    "plugins-direnv-nvim" = {
      url = "github:NotAShelf/direnv.nvim";
      flake = false;
    };
  };
}
