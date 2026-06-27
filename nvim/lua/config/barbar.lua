local map = vim.api.nvim_set_keymap
local opts = {
    noremap = true,
    silent = true
}

-- Move to previous/next
map('n', '<C-H>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<C-L>', '<Cmd>BufferNext<CR>', opts)
