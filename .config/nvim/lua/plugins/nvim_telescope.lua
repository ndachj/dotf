-- Telescope.nvim - a plugin for fuzzy finding in neovim.


local M = {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.6',
    branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        -- extensions for Telescope
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'fannheyward/telescope-coc.nvim' }, -- find/preview/pick results from coc.nvim.
        -- { 'olacin/telescope-cc.nvim' }        -- Telescope integration of Conventional Commits.
    },
}

function M.config()
    local icons = require "extra.icons"
    local actions = require "telescope.actions"
    local telescope = require("telescope")

    -- See: `:help telescope.setup`
    telescope.setup {
        theme = "dropdown",
        defaults = {
            prompt_prefix = icons.ui.Telescope .. " ",
            selection_caret = icons.ui.Forward .. " ",
            entry_prefix = "   ",
            multi_icon = icons.ui.Check .. " ",
            initial_mode = "insert",
            sroll_strategy = "cycle",
            selection_strategy = "reset",
            layout_strategy = "horizontal",
            path_display = { "shorten" },
            color_devicons = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            mappings = {
                -- insert mode
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous, },
                -- normal mode
                n = {
                    ["<esc>"] = actions.close,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["q"] = actions.close,
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
                find_files = {
                    hidden = true,
                },
                planets = {
                    -- hidden features
                    show_pluto = true,
                    show_moon = true,
                },
            },
            extensions = {
                coc = {
                    theme = "ivy",
                    prefer_locations = true,    -- always use Telescope locations to preview definitions/declarations/implementations etc
                    push_cursor_on_edit = true, -- save the cursor position to jump back in the future
                    timeout = 3000,             -- timeout for coc commands
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
            },
        },
    }

    -- load_extension, somewhere after setup function:
    telescope.load_extension('fzf')
    telescope.load_extension('coc')

    -- Set Keymaps for Telescope
    local wk = require "which-key"
    wk.add({
        -- Spelling suggestions
        { "<leader>;",  "<cmd>Telescope spell_suggest<cr>",             desc = "Spelling suggestions" },

        -- Buffers section
        { "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>",   desc = "List open buffers" },

        -- CoC & LSP section
        { "<leader>cc", "<cmd>Telescope coc commands<cr>",              desc = "List commands" },
        { "<leader>ld", "<cmd>Telescope coc diagnostics<cr>",           desc = "List diagnostics" },
        { "<leader>lD", "<cmd>Telescope coc workspace_diagnostics<cr>", desc = "List workspce diagnostics" },
        { "<leader>lw", "<cmd>Telescope coc workspace_symbols<cr>",     desc = "List workspce symbols" },

        -- Find section
        { "<leader>fc", "<cmd>Telescope colorscheme<cr>",               desc = "Colorscheme" },
        { "<leader>fC", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Grep text" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Find Help" },
        { "<leader>fH", "<cmd>Telescope highlights<cr>",                desc = "Find highlight groups" },
        { "<leader>fl", "<cmd>Telescope resume<cr>",                    desc = "Resume last search" },
        { "<leader>fm", "<cmd>Telescope man_pages<cr>",                 desc = "Man pages" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },

        -- Git section
        { "<leader>gb", "<cmd>Telescope git_branches<cr>",              desc = "Checkout branch" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>",               desc = "Checkout commits" },
        { "<leader>gC", "<cmd>Telescope git_bcommits<cr>",              desc = "Checkout commits (for current buffer)" },
        { "<leader>gf", "<cmd>Telescope git_files<cr>",                 desc = "Git Files" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>",                desc = "Git Status" },

        -- Neovim section
        { "<leader>Na", "<cmd>Telescope autocommands<cr>",              desc = "Vim autocommands" },
        { "<leader>Nb", "<cmd>Telescope planets<cr>",                   desc = "I'm bored!" },
        { "<leader>Nk", "<cmd>Telescope keymaps<cr>",                   desc = "Discover keymaps" },
        { "<leader>No", "<cmd>Telescope vim_options<cr>",               desc = "Set options" },

    })
end

return M
