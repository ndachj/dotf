-- which-key.nvim - displays a popup with possible key bindings of the command you started typing.
-- NOTE: which-key uses the desc attributes of your mappings as the default label.
-- run `:checkhealth which-key` to see if there’s any conflicting keymaps.


local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

function M.config()
    local wk = require "which-key"
    wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "CoC" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>N", group = "Neovim" },
        {
            "<leader>n",
            group = "New",
            { "<leader>ne", "<cmd>split | terminal<cr>",  desc = "Terminal" },
            { "<leader>nf", "<cmd>ene | startinsert<cr>", desc = "New File" },
            { "<leader>nt", "<cmd>$tabnew<cr>",           desc = "New Empty Tab" },
            { "<leader>nT", "<cmd>tabnew %<cr>",          desc = "New Tab" },
        },
        {
            "<leader>p",
            group = "Plugins", -- Lazy.nvim
            { "<leader>pc", "<cmd>Lazy clean<cr>",   desc = "Clean" },
            { "<leader>pd", "<cmd>Lazy debug<cr>",   desc = "Debug" },
            { "<leader>ph", "<cmd>Lazy home<cr>",    desc = "Home" },
            { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install" },
            { "<leader>pl", "<cmd>Lazy log<cr>",     desc = "Log" },
            { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile" },
            { "<leader>ps", "<cmd>Lazy sync<cr>",    desc = "Sync" },
            { "<leader>pu", "<cmd>Lazy update<cr>",  desc = "Update" },
        },
        { "<leader>T", group = "Treesitter" },
        { "<leader>w", group = "Quit" },
    })
end

return M
