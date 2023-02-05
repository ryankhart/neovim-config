local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
keymap("n", "<Space>", "<NOP>", opts)  -- TODO: Doesn't work for some reason

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Backspace key in normal mode
keymap("n", "<BS>", "<nop>", opts)

-- Move the Redo keymap to a more sensible mapping
keymap("n", "R", "<Nop>", opts)
keymap("n", "U", ":redo<CR>", opts)

-- Double tap ESC to hide text highlighting, from search for example
keymap("n", "<ESC><ESC>", ":noh<CR>", opts)

-- Better window navigation
keymap("n", "<S-h>", "<C-w>h", opts)  -- Move cursor to window left
keymap("n", "<S-j>", "<C-w>j", opts)  -- Move cursor to window up
keymap("n", "<S-k>", "<C-w>k", opts)  -- Move cursor to window down
keymap("n", "<S-l>", "<C-w>l", opts)  -- Move cursor to window right

-- Keymaps for if you have holding capslock be ctrl and tapping capslock be ESC
keymap("n", "<c-k>", ":bnext<cr>", opts)
keymap("n", "<c-j>", ":bprevious<cr>", opts)
keymap('n', '<c-h>', '<c-o>',opts)  -- Go Back
keymap('n', '<c-l>', '<c-i>',opts)  -- Go Forward

-- I don't use a keyboard with a 10-key so these keymaps aren't useful to me.
keymap("n", "-", "<nop>", opts)
keymap("n", "+", "<nop>", opts)

-- Resize with arrows
keymap("n", "<A-S-k>", ":resize -2<CR>", opts)
keymap("n", "<A-S-j>", ":resize +2<CR>", opts)
keymap("n", "<A-S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-S-l>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":move .+1<CR>==", opts)
keymap("v", "<A-j>", ":move .+1<CR>==", opts)
keymap("n", "<A-k>", ":move .-2<CR>==", opts)
keymap("v", "<A-k>", ":move .-2<CR>==", opts)
keymap("i", "<A-j>", "<ESC>:move .+1<CR>==i", opts)
keymap("i", "<A-k>", "<ESC>:move .-2<CR>==i", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Helix style keymaps
keymap("n", "gh", "^", opts)
keymap("n", "gl", "$", opts)

-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Pasting while in visual mode no longer replaces
-- clipboard with deleted text
keymap("v", "p", '"_dP', opts)

-- Auto-indent whole file (gg to move to top, = to format every line until the
-- last line (G), then return to previous cursor position (<C-o>))
keymap("n", "<F7>", "gg=G<C-o>", opts)

-- Terminal --
 -- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Plugin Keymaps --
-- Undotree
keymap("n", "<F5>", ":UndotreeToggle<cr>:UndotreeFocus<cr>", opts)

-- if vim.fn.exists("vim.g.plugs.undotree") then
--     vim.g.loaded_undotree = 2
--     vim.api.nvim_set_keymap("n", "<Leader>u", ":UndotreeToggle<CR>", {noremap = true})
-- end
