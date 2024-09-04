-- Make coc.nvim install extensions on startup,
-- See `:help g:coc_global_extensions`
vim.g.coc_global_extensions = { "coc-pairs", "coc-git", "coc-json", "coc-prettier", "coc-snippets", "coc-sumneko-lua",
    "coc-pyright", "coc-sh", "coc-marketplace", "coc-markdownlint", "coc-cmake" }

local keyset = vim.keymap.set


-- [[ AUTO-COMPLETION
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-y>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
--keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
-- ]]


-- [[ JUMP TO
-- Jump to diagnostics
keyset("n", "<leader>lk", "<Plug>(coc-diagnostic-prev)", { silent = true, desc = "Previous Diagnostic" })
keyset("n", "<leader>lj", "<Plug>(coc-diagnostic-next)", { silent = true, desc = "Next Diagnostic" })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "[LSP] Goto [D]efinition" })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true, desc = "[LSP] Goto t[Y]pe definition" })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true, desc = "[LSP] Goto [I]mplementation" })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true, desc = "[LSP] Goto [R]eference" })
-- ]]


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>lr", "<Plug>(coc-rename)", { silent = true, desc = "Rename symbol under cursor" })


-- Formatting selected code
keyset("x", "<leader>lf", "<Plug>(coc-format-selected)", { silent = true, desc = "Format selected code" })
keyset("n", "<leader>lf", "<Plug>(coc-format-selected)", { silent = true, desc = "Format selected code" })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "python,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})


-- [[ CODE ACTION
-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
keyset("x", "<leader>la", "<Plug>(coc-codeaction)",
    { silent = true, nowait = true, desc = "Code actions of current file." })
keyset("n", "<leader>la", "<Plug>(coc-codeaction)",
    { silent = true, nowait = true, desc = "Code actions of current file." })

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>lc", "<Plug>(coc-codeaction-cursor)",
    { silent = true, nowait = true, desc = "Code actions at cursor position" })

-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>lS", "<Plug>(coc-codeaction-source)",
    { silent = true, nowait = true, desc = "Source Code actions for current file" })

-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>lq", "<Plug>(coc-fix-current)",
    { silent = true, nowait = true, desc = "Quickfix" })
-- Remap keys for apply refactor code actions.
keyset("n", "<leader>lR", "<Plug>(coc-codeaction-refactor)",
    { silent = true, nowait = true, desc = "Refactor Code action at cursor position" })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>ll", "<Plug>(coc-codelens-action)",
    { silent = true, nowait = true, desc = "Code Lens actions on the current line" })
-- ]]


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
--keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
--keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Save without formatting (noautocmd)
keyset("n", "<leader>wQ", ":noa w<cr>", { silent = true, desc = "Save without formatting (noautocmd)" })

-- [[ USER COMANDS
-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
-- ]]


-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- [[ CoCList
-- Manage extensions
keyset("n", "<leader>ce", ":<C-u>CocList extensions<cr>",
    { silent = true, nowait = true, desc = "Discover/List extensions" })
-- Resume latest coc list
keyset("n", "<leader>cr", ":<C-u>CocListResume<cr>", { silent = true, nowait = true, desc = "(Resume) Last CocList" })
-- ]]


-- Outline is a split window with current document symbols rendered as coc-tree.
keyset("n", "<leader>lo", ":call CocAction('showOutline')<cr>", { silent = true, desc = "Show Outline" })
keyset("n", "<leader>lO", ":call CocAction('hideOutline')<cr>", { silent = true, desc = "Hide Outline" })
