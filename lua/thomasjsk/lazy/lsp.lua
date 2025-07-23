return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ts_ls",
                "eslint"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        on_attach = function(client, bufnr)
                            local bufopts = { noremap=true, silent=true, buffer=bufnr }

                            -- LSP actions
                            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

                            -- Diagnostic keymaps
                            vim.keymap.set("n", "<leader>e", function()
                                vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = true })
                            end, bufopts)
                            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
                            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
                            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)

                            -- Format on save
                            if client.supports_method("textDocument/formatting") then
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.format({ bufnr = bufnr })
                                    end,
                                })
                            end

                            -- Manual format keymap
                            vim.keymap.set("n", "<leader>f", function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end, bufopts)
                        end,
                        capabilities = capabilities
                    }
                end,

                -- gopls = function()
                --     local lspconfig= require("lspconfig")
                --     lspconfig.gopls.setup({
                --         on_attach = function(client, bufnr)
                --             vim.api.nvim_create_autocmd("BufWritePre", {
                --                 buffer = bufnr,
                --                 callback = function()
                --                     vim.lsp.buf.formatting_sync(nil, 1000)
                --                 end,
                --             })
                --         end,
                --     })
                -- end,
                --
                ['ts_ls'] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ts_ls.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local bufopts = { noremap=true, silent=true, buffer=bufnr }

                            -- LSP actions
                            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

                            -- Diagnostic keymaps
                            vim.keymap.set("n", "<leader>e", function()
                                vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = true })
                            end, bufopts)
                            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
                            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
                            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)

                            -- Format on save
                            if client.supports_method("textDocument/formatting") then
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.format({ bufnr = bufnr })
                                    end,
                                })
                            end

                            -- Manual format keymap
                            vim.keymap.set("n", "<leader>f", function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end, bufopts)
                        end,
                        settings = {
                            completions = {
                                completeFunctionCalls = true
                            }
                        }
                    })
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local bufopts = { noremap=true, silent=true, buffer=bufnr }

                            -- LSP actions
                            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

                            -- Diagnostic keymaps
                            vim.keymap.set("n", "<leader>e", function()
                                vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = true })
                            end, bufopts)
                            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
                            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
                            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)

                            -- Format on save
                            if client.supports_method("textDocument/formatting") then
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.format({ bufnr = bufnr })
                                    end,
                                })
                            end

                            -- Manual format keymap
                            vim.keymap.set("n", "<leader>f", function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end, bufopts)
                        end,
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local bufopts = { noremap=true, silent=true, buffer=bufnr }

                            -- LSP actions
                            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

                            -- Diagnostic keymaps
                            vim.keymap.set("n", "<leader>e", function()
                                vim.diagnostic.open_float(nil, { scope = "line", border = "rounded", focusable = true })
                            end, bufopts)
                            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
                            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
                            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, bufopts)

                            -- Format on save
                            if client.supports_method("textDocument/formatting") then
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.format({ bufnr = bufnr })
                                    end,
                                })
                            end

                            -- Manual format keymap
                            vim.keymap.set("n", "<leader>f", function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end, bufopts)
                        end,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-h>'] = cmp.mapping.confirm({ select = true }),
                -- ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            virtual_text = {
                enabled = true,
                source = "if_many",
                prefix = "●", -- Could be '●', '▎', 'x', or any other symbol
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,

}
