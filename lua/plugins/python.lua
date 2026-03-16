return {
  -- LazyVim's Python extra: pyright LSP, treesitter, ruff formatting/linting
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  -- Ensure treesitter python parser is installed safely
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "python") then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- Ensure Mason installs the necessary tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "debugpy",
      })
    end,
  },
}
