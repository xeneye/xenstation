{pkgs, ...}: let
  yaml = pkgs.formats.yaml {};
in {
  xdg.configFile."espanso/config/default.yml".source = yaml.generate "default.yml" {
    show_icon = false;
    show_notifications = false;
    keyboard_layout = {
      layout = "gb";
    };
    search_shortcut = "ALT+SPACE";
  };

  xdg.configFile."espanso/match/general.yml".source = yaml.generate "general.yml" {
    matches = [
      {
        trigger = "ahk";
        replace = "AutoHotkey";
      }
      {
        trigger = "pdf";
        replace = "PDF";
      }
      {
        trigger = "yyt";
        replace = "YouTube";
      }
      {
        trigger = "aavf";
        replace = "AVForums";
      }
      {
        trigger = "rmsd";
        replace = "Royal Mail Special Delivery";
      }
      {
        trigger = "rmrd";
        replace = "Royal Mail First Class Recorded Delivery";
      }
      {
        trigger = "ddate";
        replace = "{{date}}";
        vars = [
          {
            name = "date";
            type = "date";
            params = {
              format = "%d/%m/%Y";
            };
          }
        ];
      }
    ];
  };

  xdg.configFile."espanso/match/personal.yml".source = yaml.generate "personal.yml" {
    matches = [
      {
        trigger = "ppf";
        replace = "Paul Fowler";
      }
      {
        trigger = "hhf";
        replace = "Helen Fowler";
      }
      {
        trigger = "jjam";
        replace = "Jamie Fowler";
      }
      {
        trigger = "jjor";
        replace = "Jordan Fowler";
      }
      {
        trigger = "pfdl";
        replace = "FOWLE611208PW9TB";
      }
      {
        trigger = "hfdl";
        replace = "BUTLA652119HM9GC";
      }
      {
        trigger = "pfni";
        replace = "NR413285B";
      }
      {
        trigger = "hfni";
        replace = "NR693576B";
      }
    ];
  };

  xdg.configFile."espanso/match/contact.yml".source = yaml.generate "contact.yml" {
    matches = [
      {
        trigger = "peml";
        replace = "paul@g00ner.com";
      }
      {
        trigger = "pxeml";
        replace = "paul@xeneye.com";
      }
      {
        trigger = "pgeml";
        replace = "xeneyehq@gmail.com";
      }
      {
        trigger = "heml";
        replace = "helen@g00ner.com";
      }
      {
        trigger = "jaeml";
        replace = "jamie@g00ner.com";
      }
      {
        trigger = "joeml";
        replace = "jordan@g00ner.com";
      }
      {
        trigger = "28w";
        replace = "28 Wray Court";
      }
      {
        trigger = "eev";
        replace = "Emerson Valley";
      }
      {
        trigger = "mmk";
        replace = "Milton Keynes";
      }
      {
        trigger = "bbu";
        replace = "Bucks";
      }
      {
        trigger = "ppc";
        replace = "MK4 2GF";
      }
      {
        trigger = "uuk";
        replace = "United Kingdom";
      }
      {
        trigger = "mdpc";
        replace = "MK12 5FE";
      }
      {
        trigger = "pmob";
        replace = "07587858587";
      }
      {
        trigger = "hmob";
        replace = "07428785749";
      }
      {
        trigger = "jamob";
        replace = "07580044577";
      }
      {
        trigger = "jomob";
        replace = "07494246997";
      }
    ];
  };

  xdg.configFile."espanso/match/finance.yml".source = yaml.generate "finance.yml" {
    matches = [
      {
        trigger = "ppme";
        replace = "https://paypal.me/paulfowler";
      }
      {
        trigger = "natsort";
        replace = "07-04-36";
      }
      {
        trigger = "natcard";
        replace = "4659352140926107";
      }
      {
        trigger = "natacc";
        replace = "09481280";
      }
      {
        trigger = "barcsort";
        replace = "20-53-31";
      }
      {
        trigger = "barccard";
        replace = "4658580634832404";
      }
      {
        trigger = "barcacc";
        replace = "20950742";
      }
    ];
  };

  xdg.configFile."espanso/match/locations.yml".source = yaml.generate "locations.yml" {
    matches = [
      {
        trigger = "audreg";
        replace = "X8PWF";
      }
      {
        trigger = "kiareg";
        replace = "X9HMF";
      }
      {
        trigger = "skoreg";
        replace = "KJ16 JHU";
      }
      {
        trigger = "uszip";
        replace = "99515";
      }
      {
        trigger = "usstate";
        replace = "Alaska";
      }
      {
        trigger = "canzip";
        replace = "V0K 2S0";
      }
      {
        trigger = "canstate";
        replace = "Yale";
      }
    ];
  };

  xdg.configFile."espanso/match/computers.yml".source = yaml.generate "computers.yml" {
    matches = [
      {
        trigger = "xen";
        replace = "Xeneye";
      }
      {
        trigger = "xxen";
        replace = "xeneye";
      }
      {
        trigger = "xhq";
        replace = "xeneyehq";
      }
      {
        trigger = "mgp";
        replace = "MacGeekPaul";
      }
      {
        trigger = "lmgp";
        replace = "macgeekpaul";
      }
      {
        trigger = "fusr";
        replace = "f0wlerUK";
      }
      {
        trigger = "ggeek";
        replace = "geekstation";
      }
      {
        trigger = "wwork";
        replace = "workstation";
      }
      {
        trigger = "rrst";
        replace = "remotestation";
      }
      {
        trigger = "mmst";
        replace = "mediastation";
      }
      {
        trigger = "vvst";
        replace = "vaultstation";
      }
      {
        trigger = "xxst";
        replace = "xenstation";
      }
    ];
  };

  xdg.configFile."espanso/match/special.yml".source = yaml.generate "special.yml" {
    matches = [
      {
        trigger = "xham";
        replace = "https://xhamster.com";
      }
      {
        trigger = "xhub";
        replace = "https://pornhub.com";
      }
    ];
  };

  xdg.configFile."espanso/match/templates.yml".source = yaml.generate "templates.yml" {
    matches = [
      {
        trigger = "atb";
        replace = "All the best,\n\nPaul.";
      }
      {
        trigger = "kkr";
        replace = "Kind Regards,\n\nPaul.";
      }
      {
        trigger = "avfsell";
        replace = "Hi ???,\n\nIf paying via PayPal Gift, please send to paul@xeneye.com or visit: https://paypal.me/paulfowler\n\nIf by Bank Transfer, then please send to:\nAccount Name: Mr Paul Fowler\nBank: Nationwide\nSort Code: 07-04-36\nAccount Number: 09481280\n\nKind regards,\n\nPaul.";
      }
      {
        trigger = "avfbuy";
        replace = "Hi ???,\n\nPayment just made via ???,\n\nPlease send to:\n\nPaul Fowler\n28 Wray Court,\nEmerson Valley,\nMilton Keynes,\nBucks.\nMK4 2GF\n07587858587\npaul@xeneye.com\n\nCheers,\n\nPaul.";
      }
      {
        trigger = "avftrack";
        replace = "Hi ???,\n\nJust to confirm that the ??? has just been posted out to you today via ???, the tracking number is:???.\n\nIt should hopefully be with you shortly.\n\nKind regards,\n\nPaul.";
      }
    ];
  };

  systemd.user.services.espanso = {
    Unit = {
      Description = "Espanso";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.espanso-wayland}/bin/espanso daemon";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
