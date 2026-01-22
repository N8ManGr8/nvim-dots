require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")

-- Telescope
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map("n", "gd", function()
  require("telescope.builtin").lsp_definitions { reuse_win = true }
end, { desc = "Goto Definition" })
map("n", "gI", function()
  require("telescope.builtin").lsp_implementations { reuse_win = true }
end, { desc = "Goto Implementation" })
map("n", "gy", function()
  require("telescope.builtin").lsp_type_definitions { reuse_win = true }
end, { desc = "Goto T[y]pe Definition" })

-- Terminals
map({ "n", "t" }, "<leader>ft", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })
-- map("t", "<ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<A-x>", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })
  map("n", "<S-l>", function()
    require("nvchad.tabufline").next()
  end, { desc = "buffer goto next" })

  map("n", "<S-h>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "buffer goto prev" })
end

-- Neotree
map("n", "<leader>e", "<cmd>Neotree toggle=true source=filesystem reveal=true<CR>", { desc = "Toggle Explorer" })

-- Git stuff
map("n", "<leader>gb", "<cmd>Git blame_line<CR>", { desc = "Git blame line" })
map("n", "<leader>gh", "<cmd>Git blame<CR>", { desc = "Git blame hunks" })

-- Splits
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Rename
map("n", "<leader>cr", require "nvchad.lsp.renamer", { desc = "Rename" })

-- Disable mappings
local nomap = vim.keymap.del

-- Disable new terminals
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<C-n>")
