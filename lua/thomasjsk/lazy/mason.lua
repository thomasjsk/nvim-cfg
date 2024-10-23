return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",        -- Python
          "ts_ls",       -- TypeScript and JavaScript
          "rust_analyzer",  -- Rust
          "lua_ls",         -- Lua (for Neovim development)
        },
      })
    end,
  },
}

