-- ~/.config/nvim/init.lua

-- <------- ------- ------- ------- ------->
-- Ndachj <https://github.com/ndachj/dotf>
-- <------- ------- ------- ------- ------->

-- disable netrw at the very start of your init.lua
-- See `:help netrw`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- Set <underscore> as the local leader key
-- See `:help mapleader`,
--     `:help maplocalleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "_"

--[[
├── init.lua
└── lua
    ├── configs
    │   └── coc_nvim_config.lua
    ├── core
    │   ├── autocmds.lua
    │   ├── keymaps.lua
    │   ├── lazy_nvim.lua
    │   └── options.lua
    ├── extra
    │   └── icons.lua
    └── plugins
        ├── coc_nvim.lua
        ├── colorschemes.lua
        ├── nvim_bufferline.lua
        ├── ...
        └── vim_snippets.lua
]]

-- core modules
require("core.keymaps")
require("core.options")
require("core.autocmds")

-- plugin manager
require("core.lazy_nvim")

--  set the colorscheme
vim.cmd("colorscheme vscode")

-- other config
require("configs.coc_nvim_config")
