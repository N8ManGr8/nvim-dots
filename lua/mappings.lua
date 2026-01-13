require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")

-- Telescope live grep
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })

-- Terminals
map({ "n", "t" }, "<leader>ft", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<A-x>", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })
end

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- Disable mappings
local nomap = vim.keymap.del

-- Disable new terminals
nomap("n", "<leader>h")
nomap("n", "<leader>v")
