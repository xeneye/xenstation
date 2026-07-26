{...}: {
  programs.starship = {
    enable = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      ######################################################################
      # Prompt Layout
      ######################################################################

      add_newline = true;

      format = ''
        [╭─](bold #7aa2f7)$os$username$hostname[ ⟫ ](bold white)$directory$git_branch$git_status$nix_shell$python$nodejs$rust$golang$java$docker_context$kubernetes$fill$cmd_duration$time
        [╰─](bold #7aa2f7)$character
      '';
      right_format = "$battery";

      fill = {
        symbol = " ";
      };

      character = {
        success_symbol = "[❯](bold #9ece6a)";
        error_symbol = "[❯](bold #f7768e)";
        vimcmd_symbol = "[❮](bold #e0af68)";
      };

      ######################################################################
      # User / Host / OS
      ######################################################################

      os = {
        disabled = false;
        style = "bold cyan";

        symbols = {
          AIX = " ";
          AlmaLinux = " ";
          Alpaquita = " ";
          Alpine = " ";
          ALTLinux = " ";
          Amazon = " ";
          Android = " ";
          AOSC = " ";
          Arch = " ";
          Artix = " ";
          Bluefin = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Elementary = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = " ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = " ";
          InstantOS = " ";
          Ios = "󰀷 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = " ";
          OpenCloudOS = " ";
          openEuler = " ";
          openSUSE = " ";
          OracleLinux = "󰺡 ";
          PikaOS = " ";
          Pop = " ";
          Raspbian = " ";
          Redhat = "󱄛 ";
          RedHatEnterprise = "󱄛 ";
          Redox = "󰀘 ";
          RockyLinux = " ";
          Solus = " ";
          SUSE = " ";
          Ubuntu = " ";
          Ultramarine = " ";
          Unknown = " ";
          Uos = " ";
          Void = " ";
          Windows = "󰍲 ";
          Zorin = " ";
        };
      };

      username = {
        show_always = true;
        format = "[$user](bold #7dcfff)";
      };

      hostname = {
        ssh_only = false;
        ssh_symbol = " ";
        format = "[@$hostname](bold #89b4fa)";
      };

      ######################################################################
      # Directory
      ######################################################################

      directory = {
        style = "bold #7aa2f7";
        truncation_length = 4;
        truncate_to_repo = false;
        home_symbol = "  ";
        read_only = "󰌾 ";

        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
          Videos = " ";
          Projects = " ";
          Desktop = " ";
          Development = "󰲋 ";
        };
      };

      ######################################################################
      # Git
      ######################################################################

      git_branch = {
        symbol = " ";
        style = "bold #bb9af7";
      };

      git_status = {
        style = "bold #9ece6a";
      };

      git_commit = {
        tag_symbol = "  ";
      };

      ######################################################################
      # Nix
      ######################################################################

      nix_shell = {
        symbol = " ";
        format = "[$symbol$state]($style) ";
      };

      ######################################################################
      # Time
      ######################################################################

      time = {
        disabled = false;
        time_format = "%H:%M";
        format = "[󰥔 $time](#565f89)";
      };

      ######################################################################
      # Command Duration
      ######################################################################

      cmd_duration = {
        min_time = 1000;
        format = "[󰔛 $duration](#e0af68)";
      };

      ######################################################################
      # Battery
      ######################################################################

      battery = {
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰂑 ";
        empty_symbol = "󰂎 ";
      };

      ######################################################################
      # Icons
      ######################################################################

      aws.symbol = " ";
      azure.symbol = " ";
      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      cobol.symbol = " ";
      conda.symbol = " ";
      container.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      direnv.symbol = " ";
      docker_context.symbol = " ";
      dotnet.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      erlang.symbol = " ";
      fennel.symbol = " ";
      fortran.symbol = " ";
      fossil_branch.symbol = " ";
      gcloud.symbol = "󱇶 ";
      gleam.symbol = " ";
      golang.symbol = " ";
      gradle.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      helm.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      kubernetes.symbol = "󱃾 ";
      lua.symbol = " ";
      maven.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      mojo.symbol = "󰈸 ";
      nats.symbol = " ";
      netns.symbol = "󰛳 ";
      nim.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      odin.symbol = "󰟢 ";
      opa.symbol = " ";
      openstack.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      pixi.symbol = "󰏗 ";
      pulumi.symbol = " ";
      purescript.symbol = " ";
      python.symbol = " ";
      raku.symbol = "󱖊 ";
      red.symbol = "󱍼 ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      shlvl.symbol = "󰹍 ";
      singularity.symbol = " ";
      solidity.symbol = " ";
      spack.symbol = " ";
      status.symbol = " ";
      sudo.symbol = " ";
      swift.symbol = " ";
      terraform.symbol = " ";
      typst.symbol = " ";
      vagrant.symbol = " ";
      vlang.symbol = " ";
      xmake.symbol = " ";
      zig.symbol = " ";
    };
  };
}
