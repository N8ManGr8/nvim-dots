local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

dashboard.section.buttons.val = {
  dashboard.button("f", " Find File", ":Telescope find_files<CR>"),
  dashboard.button("/", " Find Word", ":Telescope live_grep<CR>"),
  dashboard.button("r", " Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("l", "󰒲 Lazy", ":Lazy <CR>"),
  dashboard.button("q", " Quit", ":qa<CR>"),
}

dashboard.section.footer.val = { "", " Another day of trying not to get fired. " }

alpha.setup(dashboard.opts)
