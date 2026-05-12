return {
  -- Remote-attach config for the webserver container.
  --
  -- docker-compose.yml forwards debugpy on host port 5678 and mounts
  -- ./webserver at /opt/webserver. To break in, start Django inside the
  -- container with:
  --   python -m debugpy --listen 0.0.0.0:5678 --wait-for-client manage.py runserver 0.0.0.0:8000
  -- then run <leader>dc and pick this configuration.
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- 'default' makes debugpy enable its built-in filters (includes "raised"),
      -- which stops on every AttributeError inside Django. Empty list disables all.
      dap.defaults.python.exception_breakpoints = {}

      dap.configurations.python = dap.configurations.python or {}
      table.insert(dap.configurations.python, 1, {
        type = "python",
        request = "attach",
        name = "Django: attach to webserver container",
        connect = { host = "127.0.0.1", port = 5678 },
        pathMappings = {
          {
            localRoot = vim.fn.expand("~/Repos/Vectera/webapp-dev/webserver"),
            remoteRoot = "/opt/webserver",
          },
        },
        justMyCode = false,
        django = true,
      })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("debugpy-adapter")
    end,
  },
}
