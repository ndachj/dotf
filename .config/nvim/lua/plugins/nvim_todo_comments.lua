-- todo-comments.nvim - highlight and search for todo comments like TODO, HACK, BUG in your code base.
-- NOTE: optional requirements
--    `ripgrep`
--    `plenary`
--    `Telescope`
--    `nerd font`
--  keywords recognized as todo comments:
--     FIX, FIXME, BUG, FIXIT, ISSUE    (error)
--     NOTE, INFO                       (hint)
--     TODO,                            (info)
--     WARN, HACK                       (warning)
--     TEST, PASSED, FAILED             (test)
--     PERFORMANCE, OPTIMIZE


local M = {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
    },
    keys = {
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODO comments" },
    },
}

return M
