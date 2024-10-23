vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        -- Map Spacebar to act like Enter (CR) in netrw
        vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "<Plug>NetrwLocalBrowseCheck", { noremap = true, silent = true })
    end
})

-- Clipboard copy
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>Y",  '"+yg_', { noremap = true })
vim.keymap.set("n", "<leader>y",  '"+y', { noremap = true })
vim.keymap.set("n", "<leader>yy",  '"+yy', { noremap = true })

-- Clipboard paste
vim.keymap.set("v", "<leader>p", "+p", { noremap = true })
vim.keymap.set("n", "<leader>P", "+P", { noremap = true })
vim.keymap.set("n", "<leader>p", "+r" , { noremap = true })
vim.keymap.set("n", "<leader>P", "+P", { noremap = true })

-- Move quicker [normal mode]
vim.keymap.set("n", "J", "5j", { noremap = true , silent = true })
vim.keymap.set("n", "K", "5k", { noremap = true , silent = true })
vim.keymap.set("n", "H", "5h", { noremap = true , silent = true })
vim.keymap.set("n", "L", "5l", { noremap = true , silent = true })

-- Move quicker [visual mode]
vim.keymap.set("v", "J", "5j", { noremap = true , silent = true })
vim.keymap.set("v", "K", "5k", { noremap = true , silent = true })
vim.keymap.set("v", "H", "5h", { noremap = true , silent = true })
vim.keymap.set("v", "L", "5l", { noremap = true , silent = true })

-- Tabs
vim.keymap.set("n", "<leader>wm", ":tab sp<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<leader>wq", ":tabclose <cr>", { noremap = true, silent = true })

-- Panes
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = false, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = false, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = false, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = false, silent = true })
vim.keymap.set("n", "<leader>wv", ":vsplit <cr>", { noremap = false, silent = true})
vim.keymap.set("n", "<leader>ww", ":split <cr>", { noremap = false, silent = true})

vim.api.nvim_set_keymap('n', '<leader>c', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })

-- Git
vim.keymap.set('n', 'gs', ':Git<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gdi', ':Gdiff<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gp', ':!git push -u origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gP', ':!git push -u --force origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gr', ':Git rebase', { noremap = true })
vim.keymap.set('n', 'gR', ':Git reset', { noremap = true })
vim.keymap.set('n', 'gl', ':!git pull origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gf', ':Git fetch origin', { noremap = true })
vim.keymap.set('n', 'go', ':Git checkout', { noremap = true })
vim.keymap.set('n', 'gO', ":!sh -c 'git fetch origin pull/$1/head:pr/$1 && git checkout pr/$1' -<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 'gcc', ':Git commit --verbose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gca', ':Git commit --all --verbose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gdl', ':diffget LOCAL<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gdr', ':diffget REMOTE<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gcb', ':!git branch --merged | egrepd -v "(^\\*|master)" | xargs git branch -d<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'Gt', ':!gt<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'Gb', ':!gt b<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'Gbc', ':!gt bc<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'Gl', ':!gt l<CR>', { noremap = true, silent = true })

