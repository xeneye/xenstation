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
        [╭─](bold #7aa2f7)$os$username$hostname$fill$cmd_duration$time
        [│](bold #7aa2f7)$directory$git_branch$git_status
        [╰─](bold #7aa2f7)$character
      '';

      right_format = "$battery";

      fill.symbol = " ";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold yellow)";
      };

      ######################################################################
      # OS
      ######################################################################

      os = {
        disabled = false;
        style = "bold cyan";

        symbols.NixOS = " ";
      };

      ######################################################################
      # Username / Hostname
      ######################################################################

      username = {
        show_always = true;
        style_user = "7dcfff";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "89b4fa";
        format = "[@$hostname]($style)";
      };

      ######################################################################
      # Directory
      ######################################################################

      directory = {
        style = "bold blue";

        truncation_length = 4;
        truncate_to_repo = false;

        home_symbol = "󰋜 ";
        read_only = "󰌾 ";

        substitutions = {
          Desktop = " ";
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
          Videos = " ";
          Projects = " ";
          Development = "󰲋 ";
        };
      };

      ######################################################################
      # Git
      ######################################################################

      git_branch = {
        symbol = " ";
        style = "bold magenta";
      };

      git_status = {
        style = "bold green";
      };

      ######################################################################
      # Nix Shell
      ######################################################################

      nix_shell = {
        symbol = " ";
        format = "[$symbol$state]($style)";
      };

      ######################################################################
      # Command Duration
      ######################################################################

      cmd_duration = {
        min_time = 1000;
        style = "yellow";
        format = "[$duration]($style) ";
      };

      ######################################################################
      # Time
      ######################################################################

      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "dimmed white";
        format = "[ $time]($style)";
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
      # Language Icons
      ######################################################################

      package.symbol = "󰏗 ";

      python.symbol = " ";
      nodejs.symbol = " ";
      rust.symbol = "󱘗 ";
      golang.symbol = " ";
      java.symbol = " ";

      docker_context.symbol = " ";

      kubernetes.symbol = "󱃾 ";

      terraform.symbol = " ";

      lua.symbol = " ";

      ruby.symbol = " ";

      php.symbol = " ";

      swift.symbol = " ";

      zig.symbol = " ";

      c.symbol = " ";

      cpp.symbol = " ";

      cmake.symbol = " ";

      dotnet.symbol = " ";

      kotlin.symbol = " ";

      haskell.symbol = " ";

      scala.symbol = " ";

      dart.symbol = " ";

      deno.symbol = " ";

      bun.symbol = " ";

      docker_context.only_with_files = true;

      memory_usage = {
        disabled = false;
        threshold = -1;
        symbol = "󰍛 ";
      };
    };
  };
}
