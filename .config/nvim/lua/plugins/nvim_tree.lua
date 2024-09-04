-- nvim-tree.lua - A File Explorer For Neovim Written In Lua.
-- git status icons
--     ✗  unstaged
--     ✓  staged
--       unmerged
--     ➜  renamed
--     ★  untracked
--       deleted
--     ◌  ignored
-- Show the mappings
--     type `g?``


local M = {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
    end,
    cmd = "NvimTreeOpen",
    -- key mappings to Open and close the tree.
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File Explorer" },
    }
}

return M
