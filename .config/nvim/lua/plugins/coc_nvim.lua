-- coc.nvim - LSP based intellisense engine for neovim and vim.
-- NOTE: Requirements
-- 1. NodeJS https://nodejs.org/ >= 16.18.0
-- 2. npm
-- 3. Neovim >= 0.4.0

-- NOTE: coc.nvim doesn't come with support for any specific language.
-- You need to install coc-extensions for the language.

-- Features that automatically work by default:
--      Trigger completion      coc-completion.
--      Diagnostics refresh     coc-diagnostics.
--      Pull diagnostics        coc-pullDiagnostics.
--      Trigger signature help  coc-signature.
--      Inlay hints             coc-inlayHint


-- [[ JUST SOME NOTES
-- To Install a coc-extensions from npm (recommended):
--      `:CocInstall <extension-name>`
-- To Update
--      `:CocUpdate` or `:CocUpdateSync`
-- To Unistall
--      `:CocUninstall <extension-name>`
-- To Manage
--      `:CocList extensions`
-- To add some configurations
--      `:CocConfig`
-- Open commands list
--      `:CocList commands`
--      `:CocCommand <TAB>`
-- Restart coc.nvim service.
--      `:CocRestart`
-- Open log file of coc.nvim.
--      `:CocOpenLog`
-- ]]


return {
    'neoclide/coc.nvim',
    -- Use release branch (recommended)
    branch = 'release'
}
