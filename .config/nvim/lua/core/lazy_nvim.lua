-- lazy.nvim is a modern plugin manager for Neovim.


-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- setup options for lazy
local opts = {
    root = vim.fn.stdpath("data") .. "/lazy",                 -- directory where plugins will be installed
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    defaults = {
        lazy = false,                                         -- should plugins be lazy-loaded?
    },
    checker = {
        -- automatically check for plugin updates
        enabled = false,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true,        -- get a notification when new updates are found
        frequency = 3600,     -- check for updates every hour
        check_pinned = false, -- check for pinned packages that can't be updated
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        -- get a notification when changes are foun
        notify = true,
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "desert" },
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                -- "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.8, height = 0.8 },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        backdrop = 60,
        title = "Plugin Manager",
        title_pos = "center",
    },
}


-- load anything in 'plugins' dir
require("lazy").setup("plugins", opts)
