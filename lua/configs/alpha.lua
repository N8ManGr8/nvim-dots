local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

dashboard.section.buttons.val = {
  dashboard.button("f", " Find File", ":Telescope find_files<CR>"),
  dashboard.button("/", " Find Word", ":Telescope live_grep<CR>"),
  dashboard.button("r", " Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("l", "󰒲 Lazy", ":Lazy <CR>"),
  dashboard.button("q", " Quit", ":qa<CR>"),
}

-- Calculate days since start date at OI
local start_date = { year = 2024, month = 11, day = 11 }
local now = os.time()
local start_time = os.time {
  year = start_date.year,
  month = start_date.month,
  day = start_date.day,
  hour = 0,
  min = 0,
  sec = 0,
}

local days_since = math.floor(os.difftime(now, start_time) / (24 * 60 * 60))
dashboard.section.footer.val = { "", " Day " .. days_since .. " of trying not to get fired. " }

alpha.setup(dashboard.opts)
