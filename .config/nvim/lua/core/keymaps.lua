--  See `:help vim.keymap.set()`
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- [[[ NORMAL MODE ]]]
-- Write and Quit
keymap("n", "<leader>wq", ":wq<CR>", { desc = "Write and Quit" })
-- Quit without Saving
keymap("n", "<leader>wa", ":q!<CR>", { desc = "Quit without saving" })

-- Unhighlight on pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Unhighlight" })

-- TIP: Disable arrow keys in normal mode
keymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Resize with arrow keys
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
--keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
--keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
--keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
--keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


-- [[[ VISUAL MODE ]]]
-- Move current line / block with Alt-j/k ala vscode.
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move current line/block down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move current line/block up" })

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- [[[ VISUAL BLOCK MODE ]]]
-- Move current line / block with Alt-j/k ala vscode.
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, desc = "Move current line/block down" })
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, desc = "Move current line/block up" })

-- [[[ INSERT MODE ]]]
