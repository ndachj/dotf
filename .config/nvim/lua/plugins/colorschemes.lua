-- NOTE: the colorscheme should be available when starting Neovim.


local M = {
    -- VScode's light and dark theme
    {
        "Mofiqul/vscode.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('vscode').setup {
                -- Alternatively set style in setup
                style = 'dark',
                -- Enable transparent background
                transparent = false,
                -- Enable italic comment
                italic_comments = false,
                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,
            }
        end
    },
    -- Atom One dark theme
    {
        "navarasu/onedark.nvim",
        lazy = false,
        config = function()
            require('onedark').setup {
                style = 'darker',      -- Default theme style. Choose between 'dark ', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                term_colors = true,    -- Change terminal color as per the selected theme style
                ending_tildes = false, -- Show the end-of-buffer tildes.
                -- Change code style: Options are italic, bold, underline, none
                code_style = {
                    comments = 'none',
                    keywords = 'italic',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },
            }
        end
    },
}

return M
