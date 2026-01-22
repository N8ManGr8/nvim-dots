return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show {}
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      "<leader>",
      "<c-w",
      '"',
      "'",
      "`",
      "c",
      "v",
      "g",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
    config = function()
      require "configs.whichkey"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "rust",
      },
    },
  },

  {
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
      },
      lazy = false, -- neo-tree will lazily load itself
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      _G.Snacks = require "snacks"
    end,

    --@type snacks.Config
    opts = {
      notifier = {
        enabled = true,
        timeout = 6000,
      },
      picker = { enabled = true },
    },

    keys = {
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>N",
        function()
          Snacks.picker.notification()
        end,
        desc = "Notifications",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
    },
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nhattVim/alpha-ascii.nvim",
      opts = require "configs.alpha-ascii",
    },
    config = function()
      require "configs.alpha"
    end,
  },
}
