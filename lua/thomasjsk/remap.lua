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
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = false, silent = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = false, silent = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = false, silent = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = false, silent = true })
-- vim.keymap.set("n", "<leader>wv", ":vsplit <cr>", { noremap = false, silent = true})
-- vim.keymap.set("n", "<leader>ww", ":split <cr>", { noremap = false, silent = true})
--
vim.api.nvim_set_keymap('n', '<leader>c', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gc', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })

-- Format JavaScript/TypeScript with ESLint --fix
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
    callback = function()
        -- Check for ESLint v9+ flat config files first
        local flat_config_js = vim.fn.findfile("eslint.config.js", ".;")
        local flat_config_mjs = vim.fn.findfile("eslint.config.mjs", ".;")
        local flat_config_cjs = vim.fn.findfile("eslint.config.cjs", ".;")
        
        -- Check for legacy config files
        local eslintrc_js = vim.fn.findfile(".eslintrc.js", ".;")
        local eslintrc_json = vim.fn.findfile(".eslintrc.json", ".;")
        local eslintrc_cjs = vim.fn.findfile(".eslintrc.cjs", ".;")
        
        local eslint_cmd = ""
        
        if flat_config_js ~= "" or flat_config_mjs ~= "" or flat_config_cjs ~= "" then
            -- ESLint v9+ flat config found - try eslint_d first, fallback to yarn
            eslint_cmd = "eslint_d --fix " .. vim.fn.expand("%") .. " 2>/dev/null || yarn eslint --fix " .. vim.fn.expand("%")
        elseif eslintrc_js ~= "" or eslintrc_json ~= "" or eslintrc_cjs ~= "" then
            -- Legacy config found - try eslint_d first, fallback to yarn
            eslint_cmd = "ESLINT_USE_FLAT_CONFIG=false eslint_d --fix " .. vim.fn.expand("%") .. " 2>/dev/null || ESLINT_USE_FLAT_CONFIG=false yarn eslint --fix " .. vim.fn.expand("%")
        end
        
        if eslint_cmd ~= "" then
            -- Save current position
            local pos = vim.api.nvim_win_get_cursor(0)
            -- Run eslint --fix silently
            vim.cmd("silent! !" .. eslint_cmd)
            -- Reload the file
            vim.cmd("checktime")
            -- Restore cursor position
            vim.api.nvim_win_set_cursor(0, pos)
        end
    end,
})

-- Git
--vim.keymap.set('n', 'gs', ':Git<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gb', ':Git blame<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gdi', ':Gdiff<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gp', ':!git push -u origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gP', ':!git push -u --force origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gr', ':Git rebase', { noremap = true })
--vim.keymap.set('n', 'gR', ':Git reset', { noremap = true })
--vim.keymap.set('n', 'gl', ':!git pull origin $(git rev-parse --abbrev-ref HEAD)<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gf', ':Git fetch origin', { noremap = true })
--vim.keymap.set('n', 'go', ':Git checkout', { noremap = true })
--vim.keymap.set('n', 'gO', ":!sh -c 'git fetch origin pull/$1/head:pr/$1 && git checkout pr/$1' -<CR>", { noremap = true, silent = true })
--vim.keymap.set('n', 'gcc', ':Git commit --verbose<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gca', ':Git commit --all --verbose<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gdl', ':diffget LOCAL<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gdr', ':diffget REMOTE<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'gcb', ':!git branch --merged | egrepd -v "(^\\*|master)" | xargs git branch -d<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'Gt', ':!gt<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'Gb', ':!gt b<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'Gbc', ':!gt bc<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'Gl', ':!gt l<CR>', { noremap = true, silent = true })

--vim.keymap.set("n", "<leader>e", function()
--    vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = true })
--end, { noremap = true, silent = true })
--
--vim.keymap.set("n", "<leader>E", function()
--    vim.diagnostic.open_float(nil, { scope = "buffer", border = "rounded", focusable = true })
--end, { noremap = true, silent = true })
