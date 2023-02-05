local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

-- make sure to run this code before calling setup()
-- refer to the full lists at https://github.com/folke/which-key.nvim/blob/main/lua/which-key/plugins/presets/init.lua
local presets = require("which-key.plugins.presets")
presets.motions["H"] = "Go to tab left"
presets.motions["L"] = "Go to tab right"
presets.motions["<C-h>"] = "Focus on window left" -- TODO: These are showing up as <C-H>
presets.motions["<C-l>"] = "Focus on window right"
presets.motions["<C-j>"] = "Focus on window down"
presets.motions["<C-k>"] = "Focus on window up"
presets.motions["<A-j>"] = "Move line down"
presets.motions["<A-k>"] = "Move line up"
presets.motions["<ESC><ESC>"] = "No highlight" -- TODO: Why doesn't this work?

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <C-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        ["<cr>"] = "RET",
        ["<space>"] = "SPC",
        ["<tab>"] = "TAB",
        ["<ESC>"] = "ESC",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    a = { ":Alpha<cr>", "Alpha" },
    b = {
        name = "Buffers",
        b = { ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
            "Buffers", },
        d = { ":confirm :bdelete<CR>", "Delete Buffer" },
    },
    e = { ":NvimTreeToggle<cr>", "Explorer" },
    q = { ":confirm quitall<cr>", "Quit" },
    P = { ":lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    T = { ":WhichKey<cr>", "Top Level"},

    f = {
        name = "File",
        s = { ":w!<CR>", "Save" },
        f = { ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
            "Find files" },
        F = { ":Telescope live_grep theme=ivy<cr>", "Find text" },
        R = { ":RestoreSession<cr>", "Restore Session" },
    },

    p = {
        name = "Packer",
        c = { ":PackerCompile<cr>", "Compile" },
        i = { ":PackerInstall<cr>", "Install" },
        s = { ":PackerSync<cr>", "Sync" },
        S = { ":PackerStatus<cr>", "Status" },
        u = { ":PackerUpdate<cr>", "Update" },
    },

    g = {
        name = "Git",
        g = { ":Neogit<CR>", "Neogit" },
        c = { ":Neogit commit<cr>", "Neogit Commit"},
        j = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = { ":lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk", },
        o = { ":Telescope git_status<cr>", "Open changed file" },
        b = { ":Telescope git_branches<cr>", "Checkout branch" },
        C = { ":Telescope git_commits<cr>", "Checkout commit" },
        d = {
            ":Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    l = {
        name = "LSP",
        a = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { ":Telescope diagnostics bufnr=0<cr>",
            "Document Diagnostics", },
        w = { ":Telescope diagnostics<cr>",
            "Workspace Diagnostics", },
        f = { ":lua vim.lsp.buf.format{async=true}<cr>", "Format" },
        i = { ":LspInfo<cr>", "Info" },
        I = { ":LspInstallInfo<cr>", "Installer Info" },
        j = { ":lua vim.lsp.diagnostic.goto_next()<CR>",
            "Next Diagnostic", },
        k = { ":lua vim.lsp.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic", },
        l = { ":lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { ":lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { ":Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { ":Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols", },
    },
    m = {
        name = "Motions",
        j = { ":join<cr>", "Join this line with next line" },
    },
    s = {
        name = "Search",
        b = { ":Telescope git_branches<cr>", "Checkout branch" },
        c = { ":Telescope colorscheme<cr>", "Colorscheme" },
        h = { ":Telescope help_tags<cr>", "Find Help" },
        M = { ":Telescope man_pages<cr>", "Man Pages" },
        r = { ":Telescope oldfiles<cr>", "Open Recent File" },
        R = { ":Telescope registers<cr>", "Registers" },
        k = { ":Telescope keymaps<cr>", "Keymaps" },
        C = { ":Telescope commands<cr>", "Commands" },
    },

    t = {
        name = "Terminal",
        n = { ":lua _NODE_TOGGLE()<cr>", "Node" },
        u = { ":lua _NCDU_TOGGLE()<cr>", "NCDU" },
        t = { ":lua _HTOP_TOGGLE()<cr>", "Htop" },
        p = { ":lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { ":ToggleTerm direction=float<cr>", "Float" },
        h = { ":ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { ":ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },

    u = {':UndotreeToggle<cr>:UndotreeFocus<cr>', 'Undotree'},

    w = {
        name = "Window",
        d = { "<C-w>c", "Delete window" },
        h = { "<C-h>", "Focus on window to the left" },
        l = { "<C-l>", "Focus on window to the right" },
        k = { "<C-k>", "Focus on window above" },
        j = { "<C-j>", "Focus on window below" },
        o = { "<C-w>o", "Delete other windows"},
        v = { "<C-w>v", "Split | vertical"},
        s = { "<C-w>s", "Split - horizontal"},
    }
}

which_key.setup(setup)
which_key.register(mappings, opts)
