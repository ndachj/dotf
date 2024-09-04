-- bufferline.nvim - A snazzy bufferline for neovim written in lua.


local M = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
}

function M.config()
    local icons = require "extra.icons"
    require("bufferline").setup {
        options = {
            themeable = true,
            numbers = "bufger_id",
            buffer_close_icon = icons.ui.Close,
            modified_icon = icons.ui.Circle,
            close_icon = icons.ui.BoldClose,
            left_trunc_marker = icons.ui.ArrowCircleLeft,
            right_trunc_marker = icons.ui.ArrowCircleRight,
            diagnostics = "coc",
            color_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true
                },
            },
        },
    }

    -- key mappings
    local wk = require "which-key"
    wk.add({
        { "<leader>bc", "<cmd>BufferLinePickClose<cr>",       desc = "Pick a buffer to close", },
        { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
        { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>",       desc = "Close all to the Left" },
        { "<leader>bj", "<cmd>BufferLinePick<cr>",            desc = "Jump to" },
        { "<leader>bl", "<cmd>BufferLineCloseRight<cr>",      desc = "Close all to the Right" },
        { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
        { "<leader>bn", "<cmd>BufferLineCycleNext<cr>",       desc = "Cycle Next" },
    })
end

return M
