-- AUTOCOMMAD
-- See `:help autocmd`
--     `:h vim.api.nvim_create_autocmd`


local autocmd = vim.api.nvim_create_autocmd

-- Enable highlighting the yanked region.
-- See: `:help vim.highlight.on_yank()`
autocmd({ "TextYankPost" },
    {
        pattern = "*",
        desc = "Highlight the yanked region",
        callback = function()
            vim.highlight.on_yank {
                higroup = "Visual",
                timeout = 100 }
        end,
    })

-- close some filetypes with <q>
autocmd({ "FileType" },
    {
        pattern = {
            "Jaq",
            "qf",
            "git",
            "help",
            "man",
            "checkhealth",
            "lspinfo",
            "lir",
            "DressingSelect",
            "tsplayground",
            "",
        },
        callback = function()
            vim.opt_local.buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
        end,
    })

-- wrap and check for spelling
autocmd({ "FileType" },
    {
        pattern = { "gitcommit", "markdown", },
        callback = function()
            vim.opt_local.wrap = true
            -- See `:help spell`
            vim.opt_local.spell = true
            vim.opt_local.spelllang = { "en_us", "en_gb" }
        end,
    })
