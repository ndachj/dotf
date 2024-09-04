-- VIM OPTIONS
-- See `:help option-list``
-- and `:help vim.opt`
-- NOTE: Options are automatically loaded before lazy.nvim startup


local o = vim.opt

-- [[ Appearance
o.number = true
o.numberwidth = 4
o.relativenumber = true -- add numbers to each line on the left side
o.cursorline = true     -- highlight cursor line underneath the cursor horizontally
o.cursorlineopt = "both"
o.splitbelow = true     -- open new vertical split bottom
o.splitright = true     -- open new horizontal splits right
o.termguicolors = true  -- enabl 24-bit RGB color in the TUI
o.wrap = true           -- wrap lines longer than the width of the window.
o.showmode = true
o.background = "dark"
-- ]]

-- [[ Searching
o.ignorecase = true    -- Ignore case in search patterns.
o.smartcase = true
o.inccommand = 'split' -- preview substitutions live, as you type!
-- ]]

-- [[ Highlight
o.hlsearch = true  -- highlight on search
o.incsearch = true -- highlight match while typing search pattern
-- ]]

-- [[ Tab and Indentation
-- NOTE: To insert a real tab when 'expandtab' is on, use CTRL-V.
o.expandtab = true  -- convert tab to spaces
o.tabstop = 4       -- 4 spaces == 1 Tab
o.softtabstop = 4   -- 4 spaces == 1 Tab while editing
o.shiftwidth = 4    -- number of spaces to use for (auto)indent step
o.smarttab = true   -- use 'shiftwidth' when inserting <Tab>>
o.autoindent = true -- take indent for new line from previous linee
-- ]]

-- [[ LSP related
o.updatetime = 300    -- have shorter updatetime (default = 4000 ms)
o.backup = false      -- no backup files
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited.
o.signcolumn = "yes"  -- always show the signcolumn
-- ]]

-- Enables mouse support.
o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
o.clipboard = "unnamedplus"

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 5

-- options for Insert mode
o.completeopt = { "menu", "menuone", "noselect" }

-- Consider - as part of a word
o.iskeyword:append("-")


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { eol = '', tab = '» ', trail = '·', nbsp = '␣' }
