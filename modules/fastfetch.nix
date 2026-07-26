{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        type = "small";
        padding = {
          top = 3;
          left = 4;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        {
          key = " ";
          type = "custom";
        }
        {
          key = " ";
          type = "custom";
        }
        {
          key = "╭───────────╮";
          type = "custom";
        }
        {
          key = "│  user    │";
          type = "title";
          format = "{user-name}";
        }
        {
          key = "│  distro  │";
          type = "os";
          format = "{pretty-name}";
        }
        {
          key = "│  kernel  │";
          type = "kernel";
        }
        {
          key = "│ 󰍛 cpu     │";
          type = "cpu";
          showPeCoreCount = true;
        }
        {
          key = "│ 󰍛 gpu     │";
          type = "gpu";
        }
        {
          key = "│ 󰉉 disk    │";
          type = "disk";
          folders = "/";
          format = "{1} / {2} ({3})";
        }
        {
          key = "│  memory  │";
          type = "memory";
        }
        {
          key = "╰───────────╯";
          type = "custom";
        }
        {
          key = " ";
          type = "custom";
        }
        {
          key = " ";
          type = "custom";
        }
      ];
    };
  };
}
