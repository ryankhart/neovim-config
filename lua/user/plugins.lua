local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    use { "mbbill/undotree", commit = "1a23ea84bd02c34f50d8e10a8b4bfc89597ffe4e" } -- Like git commits but for undos/redos
    use { "christoomey/vim-titlecase", commit = "69a697c54a08ca5603cb757b4d4f78cd4b567549" }
    use { "rmagatti/auto-session", commit = "c8b2f4048f846387361bd04cc185bf1aa7d2e3d1" }
    use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
    use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" } -- Useful lua functions used by lots of plugins
    use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and treesitter
    use { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" }
    use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }
    use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
    use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }
    use { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" }
    use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
    use { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" }
    use { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" }
    use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
    use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
    use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
    use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }
    use {"folke/which-key.nvim"}

    -- Colorschemes
    use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
    use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }
    use { "ishan9299/nvim-solarized-lua" }

    -- Cmp 
    use { "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" } -- The completion plugin
    use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
    use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions
    use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
    use { "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" }
    use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

    -- Snippets
    use { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" } --snippet engine
    use { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" } -- a bunch of snippets to use

    -- LSP
    use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
    use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"} -- simple to use language server installer
    use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
    use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
    use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

    -- Telescope
    use { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac" }

    -- Git
    use { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" }
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim',
        config = function ()
            neogit.setup {
                disable_signs = false,
                disable_hint = false,
                disable_context_highlighting = false,
                disable_commit_confirmation = false,
                -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
                -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
                auto_refresh = true,
                disable_builtin_notifications = false,
                use_magit_keybindings = false,
                -- Change the default way of opening neogit
                kind = "tab",
                -- The time after which an output console is shown for slow running commands
                console_timeout = 2000,
                -- Automatically show console if a command takes more than console_timeout milliseconds
                auto_show_console = true,
                -- Change the default way of opening the commit popup
                commit_popup = {
                    kind = "split",
                },
                -- Change the default way of opening popups
                popup = {
                    kind = "split",
                },
                -- customize displayed signs
                signs = {
                    -- { CLOSED, OPENED }
                    section = { ">", "v" },
                    item = { ">", "v" },
                    hunk = { "", "" },
                },
                integrations = {
                    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
                    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
                    --
                    -- Requires you to have `sindrets/diffview.nvim` installed.
                    -- use {
                    --   'TimUntersberger/neogit',
                    --   requires = {
                    --     'nvim-lua/plenary.nvim',
                    --     'sindrets/diffview.nvim'
                    --   }
                    -- }
                    --
                    diffview = false
                },
                -- Setting any section to `false` will make the section not render at all
                sections = {
                    untracked = {
                        folded = false
                    },
                    unstaged = {
                        folded = false
                    },
                    staged = {
                        folded = false
                    },
                    stashes = {
                        folded = true
                    },
                    unpulled = {
                        folded = true
                    },
                    unmerged = {
                        folded = false
                    },
                    recent = {
                        folded = true
                    },
                },
                -- override/add mappings
                mappings = {
                    -- modify status buffer mappings
                    status = {
                        -- Adds a mapping with "B" as key that does the "BranchPopup" command
                        ["B"] = "BranchPopup",
                        -- Removes the default mapping of "s"
                        ["s"] = "",
                    }
                }
            }
        end}

    -- Example --
    -- use {
    --     'myusername/example',        -- The plugin location string
    --     -- The following keys are all optional
    --     disable = boolean,           -- Mark a plugin as inactive
    --     as = string,                 -- Specifies an alias under which to install the plugin
    --     installer = function,        -- Specifies custom installer. See "custom installers" below.
    --     updater = function,          -- Specifies custom updater. See "custom installers" below.
    --     after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
    --     rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
    --     opt = boolean,               -- Manually marks a plugin as optional.
    --     bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
    --     branch = string,             -- Specifies a git branch to use
    --     tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
    --     commit = string,             -- Specifies a git commit to use
    --     lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
    --     run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
    --     requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
    --     rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
    --     config = string or function, -- Specifies code to run after this plugin is loaded.
    --     -- The setup key implies opt = true
    --     setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
    --     -- the plugin is waiting for other conditions (ft, cond...) to be met.
    --     -- The following keys all imply lazy-loading and imply opt = true
    --     cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
    --     ft = string or list,         -- Specifies filetypes which load this plugin.
    --     keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
    --     event = string or list,      -- Specifies autocommand events which load this plugin.
    --     fn = string or list          -- Specifies functions which load this plugin.
    --     cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
    --     module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
    --     -- with one of these module names, the plugin will be loaded.
    --     module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
    --     -- requiring a string which matches one of these patterns, the plugin will be loaded.
    -- }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
