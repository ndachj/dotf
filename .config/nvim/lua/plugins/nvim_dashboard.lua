-- dashboard-nvim - a fancy and Blazing Fast start screen plugin of neovim.


local M = {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}

local banner = {
    [[ ╭─────────────────────────────────────╮ ]],
    [[ │    _  __    __            __     _  │ ]],
    [[ │   / |/ /___/ /___ _ ____ / /    (_) │ ]],
    [[ │  /    // _  // _ `// __// _ \  / /  │ ]],
    [[ │ /_/|_/ \_,_/ \_,_/ \__//_//_/_/ /   │ ]],
    [[ │                             │__/    │ ]],
    [[ ╰─────────────────────────────────────╯ ]],
}

function M.config()
    local icons = require("extra.icons")
    require('dashboard').setup {
        theme = 'doom',      --  theme is doom and hyper
        config = {
            header = banner, --your header
            center = {
                {
                    icon = icons.ui.FindFile,
                    icon_hl = 'Title',
                    desc = 'Find File',
                    desc_hl = 'String',
                    key = 'f',          -- shortcut key in dashboard buffer not keymap!!
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = "Telescope find_files"
                },
                {
                    icon = icons.ui.NewFile,
                    icon_hl = 'Title',
                    desc = 'New File',
                    desc_hl = 'String',
                    key = 'n',
                    key_format = ' %s',
                    action = "ene | startinsert"
                },
                {
                    icon = icons.ui.History,
                    icon_hl = 'Title',
                    desc = 'Recent Files',
                    desc_hl = 'String',
                    key = 'r',
                    key_format = ' %s',
                    action = 'Telescope oldfiles'
                },
                {
                    icon = icons.misc.Key,
                    icon_hl = 'Title',
                    desc = 'Keymaps',
                    desc_hl = 'String',
                    key = 'm',
                    key_format = ' %s',
                    action = 'Telescope keymaps'
                },
                {
                    icon = icons.ui.Gear,
                    icon_hl = 'Title',
                    desc = 'Nvim Config',
                    desc_hl = 'String',
                    key = 'c',
                    key_format = ' %s',
                    action = 'NvimTreeOpen ~/.config/nvim/'
                },
                {
                    icon = icons.ui.BoldClose,
                    icon_hl = 'Title',
                    desc = 'Quit Nvim',
                    desc_hl = 'String',
                    key = 'q',
                    key_format = ' %s',
                    action = 'confirm quit'
                },
            },
            -- footer = {}  --your footer
        },
        hide = {
            statusline, -- hide statusline
            tabline,    -- hide the tabline
            winbar,     -- hide winbar
        },
    }
end

return M
