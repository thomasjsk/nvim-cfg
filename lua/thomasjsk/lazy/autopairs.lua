return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        npairs.setup({
            check_ts = true, -- Enable tree-sitter integration
            ts_config = {
                lua = { "string", "source" }, -- Don't add pairs in Lua strings
                javascript = { "string", "template_string" },
                typescript = { "string", "template_string" },
                elixir = { "string", "sigil" },
                rust = { "string" },
                go = { "string" },
                python = { "string", "fstring" },
                html = { "string" },
                css = { "string" },
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0, -- Offset from pattern match
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        })

        -- Add custom rules for specific languages
        local ts_conds = require("nvim-autopairs.ts-conds")

        -- Lua-specific rules
        npairs.add_rules({
            Rule("%", "%", "lua")
                :with_pair(ts_conds.is_ts_node({ "string", "comment" })),
            Rule("$", "$", "lua")
                :with_pair(ts_conds.is_not_ts_node({ "function" })),
        })

        -- Elixir-specific rules (handle sigils properly)
        npairs.add_rules({
            Rule("~", "~", "elixir")
                :with_pair(ts_conds.is_ts_node({ "sigil" })),
        })

        -- JavaScript/TypeScript template literal rules
        npairs.add_rules({
            Rule("`", "`", { "javascript", "typescript" })
                :with_pair(ts_conds.is_ts_node({ "template_string" })),
        })

        -- Add space between brackets
        npairs.add_rules({
            Rule(" ", " ")
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(function(opts)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local context = opts.line:sub(col - 1, col + 2)
                    return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
                end),
            Rule("", " ")
                :with_pair(cond.none())
                :with_move(function(opts)
                    return opts.char == " "
                end)
                :with_cr(cond.none())
                :with_del(cond.none())
                :use_key(" "),
        })

        -- Auto-close quotes with Tree-sitter awareness
        npairs.add_rules({
            Rule("'", "'", { "lua", "javascript", "typescript", "elixir", "rust", "go", "python" })
                :with_pair(ts_conds.is_ts_node({ "string", "comment" }))
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.none()),
            Rule('"', '"', { "lua", "javascript", "typescript", "elixir", "rust", "go", "python" })
                :with_pair(ts_conds.is_ts_node({ "string", "comment" }))
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.none()),
        })

        -- Smart bracket rules with Tree-sitter
        npairs.add_rules({
            Rule("(", ")", { "lua", "javascript", "typescript", "elixir", "rust", "go", "python" })
                :with_pair(ts_conds.is_not_ts_node({ "string", "comment", "function" }))
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.none()),
            Rule("[", "]", { "lua", "javascript", "typescript", "elixir", "rust", "go", "python" })
                :with_pair(ts_conds.is_not_ts_node({ "string", "comment" }))
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.none()),
            Rule("{", "}", { "lua", "javascript", "typescript", "elixir", "rust", "go", "python" })
                :with_pair(ts_conds.is_not_ts_node({ "string", "comment" }))
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.none()),
        })
    end,
}
