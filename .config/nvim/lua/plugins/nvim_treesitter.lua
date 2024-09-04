-- nvim-treesitter -- provide functionalities such as highlighting and incremental selection, and a command to easily install parsers.
-- NOTE: By default, Nvim bundles only parsers for C, Lua, and Vimscript, but other parsers can be installed.


local M = {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate'
}

function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = { 'lua', 'luadoc', 'awk', 'bash', 'bp', 'csv', 'gitignore', 'gitcommit', 'gitattributes', 'git_config', 'dockerfile', 'json', 'jsonc', 'markdown', 'markdown_inline', 'powershell', 'properties', 'python', 'rst', 'toml', 'udev', 'vim', 'vimdoc', 'yaml' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' }
        },
    }
end

return M
