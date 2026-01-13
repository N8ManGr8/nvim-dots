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
