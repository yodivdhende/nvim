return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "html",
          "svelte",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          settings = {
            svelte = {
              plugin = {
                typescript = { enabled = true },
                css = { enabled = true },
                html = { enabled = true },
              },
            },
          },
        },
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "typescript-svelte-plugin",
                location = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin"),
                languages = { "svelte" },
              },
            },
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "svelte" },
        },
        eslint = {
          settings = {
            workingDirectories = { { mode = "auto" } },
          },
        },
        html = {},
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local o = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, o)
        end,
      })
    end,
  },
}
