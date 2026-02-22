return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      width = 60,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
      preset = {
        header = [[
██████████████████████████████
██████████████████████████████
██████████████████████████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████
████████              ████████

 Welcome back, Rob. Let's build.]],
        keys = {
          { icon = '󰈮 ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':enew' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
  },
  config = function(_, opts)
    -- Apply green/teal dashboard colors after any colorscheme load
    local function set_dashboard_colors()
      vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#8ec07c' })
      vim.api.nvim_set_hl(0, 'SnacksDashboardKey', { fg = '#8ec07c' })
      vim.api.nvim_set_hl(0, 'SnacksDashboardDesc', { fg = '#a9b665' })
      vim.api.nvim_set_hl(0, 'SnacksDashboardIcon', { fg = '#a9b665' })
      vim.api.nvim_set_hl(0, 'SnacksDashboardFooter', { fg = '#7daea3' })
    end
    -- Set now and re-apply whenever colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', { callback = set_dashboard_colors })
    set_dashboard_colors()
    require('snacks').setup(opts)
  end,
}
-- vim: ts=2 sts=2 sw=2 et
