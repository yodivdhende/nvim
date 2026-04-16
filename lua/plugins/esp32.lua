-- ESP32 / PlatformIO C development stack
-- Targets: ESP32-2432S028R (Cheap Yellow Display board)
-- Build system: PlatformIO (pio)
-- Toolchain: xtensa-esp32-elf-gcc, OpenOCD

return {
  -- ─── Treesitter parsers ───────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "c", "cpp", "cmake", "make" })
    end,
  },

  -- ─── clangd LSP ──────────────────────────────────────────────────────────
  -- PlatformIO generates compile_commands.json at:
  --   .pio/build/<env>/compile_commands.json
  -- Run `pio run -t compiledb` to generate it, then symlink to project root:
  --   ln -s .pio/build/<env>/compile_commands.json compile_commands.json
  -- clangd will pick it up automatically from the project root.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--pch-storage=memory",
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "platformio.ini",
              "compile_commands.json",
              ".clangd",
              ".git"
            )(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  -- ─── Mason: install LSP servers & tools ──────────────────────────────────
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "clangd",
        "clang-format",
        "cpptools", -- MS cpptools DAP adapter (wraps GDB)
      })
    end,
  },

  -- ─── clang-format ────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
    },
  },

  -- ─── nvim-platformio.lua ─────────────────────────────────────────────────
  -- Provides Telescope-based pickers for all PlatformIO commands.
  -- Keymaps (all under <leader>e):
  --   <leader>eb  Build
  --   <leader>eu  Upload
  --   <leader>em  Serial Monitor
  --   <leader>ec  Clean
  --   <leader>ed  Upload + Monitor
  --   <leader>ei  Init new project (Telescope picker)
  --   <leader>eI  Install library (Telescope picker)
  {
    "anurag3301/nvim-platformio.lua",
    dependencies = {
      "akinsho/toggleterm.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "Piobuild",
      "Pioupload",
      "Piomonitor",
      "Pioclean",
      "Pioinit",
      "Piolibinstall",
      "Piodebug",
    },
    keys = {
      { "<leader>eb", "<cmd>Piobuild<cr>",      desc = "PIO Build" },
      { "<leader>eu", "<cmd>Pioupload<cr>",     desc = "PIO Upload" },
      { "<leader>em", "<cmd>Piomonitor<cr>",    desc = "PIO Monitor" },
      { "<leader>ec", "<cmd>Pioclean<cr>",      desc = "PIO Clean" },
      { "<leader>ed", "<cmd>Pioupload<cr>",     desc = "PIO Upload + Monitor" },
      { "<leader>ei", "<cmd>Pioinit<cr>",       desc = "PIO Init Project" },
      { "<leader>eI", "<cmd>Piolibinstall<cr>", desc = "PIO Install Library" },
    },
  },

  -- ─── toggleterm (used by nvim-platformio) ────────────────────────────────
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "horizontal",
      size = 15,
      open_mapping = [[<C-\>]],
      shade_terminals = false,
    },
  },

  -- ─── nvim-dap: OpenOCD + xtensa-esp32-elf-gdb ────────────────────────────
  -- Workflow:
  --   1. Run `pio run -t compiledb` to generate compile_commands.json
  --   2. Start OpenOCD: openocd -f interface/esp_usb_jtag.cfg -f target/esp32.cfg
  --   3. Press <leader>dc and select "ESP32 via OpenOCD"
  -- ELF is at: .pio/build/<env>/firmware.elf
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require("dap")

      local cpptools_path = require("mason-registry").get_package("cpptools"):get_install_path()
        .. "/extension/debugAdapters/bin/OpenDebugAD7"

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = cpptools_path,
      }

      dap.configurations.c = {
        {
          name = "ESP32 via OpenOCD (PlatformIO)",
          type = "cppdbg",
          request = "launch",
          program = function()
            -- PlatformIO ELF lives in .pio/build/<env>/firmware.elf
            return vim.fn.input("ELF path: ", vim.fn.getcwd() .. "/.pio/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          MIMode = "gdb",
          miDebuggerPath = "xtensa-esp32-elf-gdb",
          miDebuggerServerAddress = "localhost:3333",
          setupCommands = {
            { text = "set remote hardware-watchpoint-limit 2", ignoreFailures = true },
            { text = "mon reset halt",                         ignoreFailures = false },
            { text = "maintenance flush register-cache",       ignoreFailures = true },
          },
          logging = { engineLogging = false },
        },
      }

      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
