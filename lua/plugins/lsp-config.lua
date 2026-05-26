return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "svelte-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "html-lsp",
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
