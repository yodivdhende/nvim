return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "tpope/vim-dotenv",
    cmd = { "Dotenv" },
    init = function()
      local function build_dbs()
        local dbs = {}

        if vim.env.DBUI_URL and vim.env.DBUI_NAME then
          table.insert(dbs, { name = vim.env.DBUI_NAME, url = vim.env.DBUI_URL })
        end

        -- Hardcoded connections (gitignored, e.g. Google Cloud SQL) live here
        local ok, extra_dbs = pcall(require, "config.db_connections.local")
        if ok and type(extra_dbs) == "table" then
          for _, entry in ipairs(extra_dbs) do
            table.insert(dbs, entry)
          end
        end

        vim.g.dbs = dbs
      end

      local function load_dotenv()
        local env_file = vim.fn.getcwd() .. "/.env"
        if vim.fn.filereadable(env_file) == 1 then
          vim.cmd("Dotenv " .. vim.fn.fnameescape(env_file))
        end
        build_dbs()
      end

      vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
        callback = load_dotenv,
      })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "DB UI Toggle" },
      { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "DB Add Connection" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "DB Find Buffer" },
    },
    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      -- Connections are populated into vim.g.dbs: local one from .env
      -- (via tpope/vim-dotenv), extra ones from config/db_connections/local.lua
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
    config = function()
      local function setup_completion()
        require("cmp").setup.buffer({
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        })
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = setup_completion,
      })
      setup_completion()
    end,
  },
}
