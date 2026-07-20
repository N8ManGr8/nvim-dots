local wk = require "which-key"

wk.setup {
  preset = "helix",
}

wk.add {
  -- Files
  { "<leader>f", group = "Files" },

  -- Git
  { "<leader>g", group = "Git" },

  -- Code
  { "<leader>c", group = "Code" },

  -- Octo
  { "<leader>o", group = "Octo" },

  -- Trouble
  { "<leader>x", group = "Trouble" },
}
