{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    opts = {
      relativenumber = true;
      incsearch = true;
    };

    colorschemes.onedark.enable = true;

    plugins = {
      # Prevents the deprecation warning from Telescope
      web-devicons.enable = true;

      lualine.enable = true;
      treesitter.enable = true;
      telescope.enable = true;

      lsp = {
        keymaps = {
          silent = true;

          lspBuf = {
            gd = "definition";
            K = "hover";
          };
        };
      };
    };
  };
}
