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
        -- Function to check if ESLint is available and configured
        local function has_eslint_config()
            -- Check for ESLint v9+ flat config files
            local flat_config_js = vim.fn.findfile("eslint.config.js", ".;")
            local flat_config_mjs = vim.fn.findfile("eslint.config.mjs", ".;")
            local flat_config_cjs = vim.fn.findfile("eslint.config.cjs", ".;")

            -- Check for legacy config files
            local eslintrc_js = vim.fn.findfile(".eslintrc.js", ".;")
            local eslintrc_json = vim.fn.findfile(".eslintrc.json", ".;")
            local eslintrc_cjs = vim.fn.findfile(".eslintrc.cjs", ".;")
            local eslintrc_yml = vim.fn.findfile(".eslintrc.yml", ".;")
            local eslintrc_yaml = vim.fn.findfile(".eslintrc.yaml", ".;")

            -- Check for package.json with eslint dependency
            local package_json = vim.fn.findfile("package.json", ".;")
            local has_eslint_dep = false

            if package_json ~= "" then
                local file = io.open(package_json, "r")
                if file then
                    local content = file:read("*all")
                    file:close()
                    -- Check if eslint is in dependencies or devDependencies
                    has_eslint_dep = content:match('"eslint"') ~= nil
                end
            end

            -- Return true only if we have both a config file AND eslint dependency
            local has_config = flat_config_js ~= "" or flat_config_mjs ~= "" or flat_config_cjs ~= "" or
            eslintrc_js ~= "" or eslintrc_json ~= "" or eslintrc_cjs ~= "" or
            eslintrc_yml ~= "" or eslintrc_yaml ~= ""

            return has_config and has_eslint_dep
        end

        -- Only run ESLint if we have proper configuration
        if has_eslint_config() then
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
                -- ESLint v9+ flat config found - use eslint_d for speed
                eslint_cmd = "eslint_d --fix " .. vim.fn.expand("%")
            elseif eslintrc_js ~= "" or eslintrc_json ~= "" or eslintrc_cjs ~= "" then
                -- Legacy config found - use eslint_d for speed
                eslint_cmd = "ESLINT_USE_FLAT_CONFIG=false eslint_d --fix " .. vim.fn.expand("%")
            end

            -- Check if eslint_d is available, fallback to npx eslint if not
            if eslint_cmd and eslint_cmd:match("eslint_d") then
                local handle = io.popen("which eslint_d 2>/dev/null")
                if handle then
                    local result = handle:read("*a")
                    handle:close()
                    if result == "" then
                        -- eslint_d not found, use npx eslint instead
                        eslint_cmd = eslint_cmd:gsub("eslint_d", "npx eslint")
                    end
                end
            end

            if eslint_cmd ~= "" then
                -- Save current position
                local pos = vim.api.nvim_win_get_cursor(0)
                -- Run eslint --fix asynchronously for speed
                vim.fn.jobstart(eslint_cmd, {
                    on_exit = function()
                        -- Reload the file when done
                        vim.schedule(function()
                            vim.cmd("checktime")
                            vim.api.nvim_win_set_cursor(0, pos)
                        end)
                    end
                })
            end
        end
        -- If no ESLint config is found, silently skip (no error messages)
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

-- Elixir/Mix commands
vim.keymap.set("n", "<leader>mc", ":!mix compile<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mt", ":!mix test<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mT", ":!mix test --watch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mf", ":!mix format<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>md", ":!mix deps.get<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mD", ":!mix deps.compile<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mp", ":!mix phx.server<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mi", ":terminal iex -S mix<CR>", { noremap = true, silent = true })

-- Terminal toggle (useful for running commands)
vim.keymap.set("n", "<leader>tt", ":terminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>th", ":split | terminal<CR>", { noremap = true, silent = true })
