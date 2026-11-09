return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
    config = function()
      local telescope = require "telescope"
      local lga_actions = require "telescope-live-grep-args.actions"

      telescope.setup {
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-space>"] = lga_actions.to_fuzzy_refine,
              },
            },
            theme = "dropdown", -- use dropdown theme
            theme = {}, -- use own theme spec
            layout_config = { mirror = true }, -- mirror preview pane
          },
        },
      }

      telescope.load_extension "live_grep_args"
    end,
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
          Snacks.picker.notifications()
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
    -- floating cmdline popup; hides the bottom command line row (cmdheight=0)
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      cmdline = { view = "cmdline_popup" },
      -- keep snacks.notifier as the vim.notify handler
      notify = { enabled = false },
      -- NvChad already handles LSP hover/signature
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        progress = { enabled = false },
      },
      presets = {
        bottom_search = false, -- / and ? also use the popup
        command_palette = true, -- cmdline + completion menu together at top
        long_message_to_split = true, -- long messages go to a split
        lsp_doc_border = true,
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

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>oi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>op",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>od",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>on",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons", -- optional if file_panel.icons is a function
    },
  },
}
