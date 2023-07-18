-- Disable netrw to avoid conflicts with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        side = "right",
        width = 50
    }
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { silent = true })
vim.keymap.set("n", "<leader>tc", ":NvimTreeFocus<CR>", { silent = true })
