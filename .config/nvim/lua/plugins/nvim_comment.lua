-- Comment.nvim is a smart comment plugin for neovim.
-- NOTE:  mappings in NORMAL and VISUAL mode
--    Linewise comment  'gcc'
--    Blockwise comment  'gbc'
--    Inserts comment below  'gco'
--    Inserts comment above  'gcO'
--    Inserts comment at the end of line  'gcA'


local M = {
    'numToStr/Comment.nvim',
    lazy = false,
}

function M.config()
    -- you need to call the setup() method to create the default mappings.
    require('Comment').setup({
        toggler = { line = 'gcc', block = 'gbc' },
        opleader = { line = 'gcc', block = 'gbc' },
        extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
        mappings = { basic = true, extra = true },
    })
    -- Add a visual shortcut
    local wk = require "which-key"
    wk.add({
        { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment the current line", mode = "n" },
        { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  desc = "Comment the current line", mode = "x" },
    })
end

return M
