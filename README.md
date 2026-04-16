# nvim-esp

A [LazyVim](https://www.lazyvim.org/)-based Neovim config for ESP32 embedded C development with
[PlatformIO](https://platformio.org/).

Targeting the **ESP32-2432S028R** (Cheap Yellow Display board).

---

## Requirements

- Neovim >= 0.10
- [PlatformIO CLI](https://docs.platformio.org/en/latest/core/installation/index.html) (`pio` on PATH)
- `clangd` — installed automatically via Mason on first launch
- `xtensa-esp32-elf-gdb` — from the ESP32 toolchain (for debugging)
- [OpenOCD](https://openocd.org/) — for hardware debugging (optional)
- `git`, `make`, a C compiler (for building Neovim plugins)

---

## Installation

Clone the repo to your Neovim config directory:

```bash
git clone https://github.com/yodivdhende/nvim-esp ~/.config/nvim-esp
```

Launch Neovim pointing at this config:

```bash
NVIM_APPNAME=nvim-esp nvim
```

On first launch, lazy.nvim will install all plugins automatically. Afterwards run:

```
:Lazy sync
:Mason
```

Mason will install `clangd`, `clang-format`, and `cpptools` (the DAP adapter).

> **Tip:** Add a shell alias so you don't have to type the full env var every time:
> ```bash
> alias nvim-esp='NVIM_APPNAME=nvim-esp nvim'
> ```

---

## Colorscheme

Uses [nord.nvim](https://github.com/shaunsingh/nord.nvim) with a transparent background so your
terminal background shows through.

| Setting                       | Value |
| :---------------------------- | :---- |
| Contrast (sidebar/statusline) | on    |
| Split borders                 | on    |
| Transparent background        | on    |
| Italic / bold fonts           | on    |
| Uniform diff background       | on    |

---

## LSP — clangd

clangd provides code intelligence (completions, go-to-definition, diagnostics, inlay hints) for C/C++.
It reads a `compile_commands.json` file to understand your project's include paths and compiler flags.

### Generating compile_commands.json

PlatformIO puts this file at `.pio/build/<env>/compile_commands.json` after a build.
Generate and symlink it to the project root (clangd searches there by default):

```bash
# inside your PlatformIO project
pio run -t compiledb
ln -s .pio/build/<env>/compile_commands.json compile_commands.json
```

Replace `<env>` with your environment name from `platformio.ini` (e.g. `esp32dev`).

Re-run `pio run -t compiledb` whenever you add new source files or libraries.

### Suppressing Xtensa-specific flags

clangd does not understand some ESP32 compiler flags and will emit errors for them.
Add a `.clangd` file at the project root to filter them out:

```yaml
# .clangd
CompileFlags:
  Remove:
    - -mlongcalls
    - -mtext-section-literals
    - -fno-tree-switch-conversion
```

### LSP keymaps (LazyVim defaults)

These work in any C/C++ file when clangd is attached.

| Keymap       | Action                     |
| :----------- | :------------------------- |
| `gd`         | Go to definition           |
| `gr`         | Go to references           |
| `gI`         | Go to implementation       |
| `gy`         | Go to type definition      |
| `K`          | Hover documentation        |
| `<leader>ca` | Code action                |
| `<leader>cr` | Rename symbol              |
| `<leader>cf` | Format file (clang-format) |
| `<leader>cd` | Line diagnostics           |
| `]d` / `[d`  | Next / previous diagnostic |

---

## PlatformIO — build, upload, monitor

Powered by [nvim-platformio.lua](https://github.com/anurag3301/nvim-platformio.lua). Each command
opens in a toggleterm split at the bottom of the screen.

| Keymap       | Action                      |
| :----------- | :-------------------------- |
| `<leader>eb` | Build                       |
| `<leader>eu` | Upload to board             |
| `<leader>em` | Open serial monitor         |
| `<leader>ec` | Clean build artifacts       |
| `<leader>ed` | Upload + Monitor            |
| `<leader>ei` | Init new PlatformIO project |
| `<leader>eI` | Install a library           |

The terminal toggle (`<C-\>`) opens/closes the last toggleterm window.

---

## Debugging (OpenOCD + GDB)

Hardware debugging uses [nvim-dap](https://github.com/mfussenegger/nvim-dap) with the `cpptools`
adapter connecting to OpenOCD over port 3333.

### Workflow

**Step 1** — Start OpenOCD in a terminal (outside Neovim):

```bash
openocd -f interface/esp_usb_jtag.cfg -f target/esp32.cfg
```

**Step 2** — In Neovim, start a debug session:

```
<leader>dc   →  Continue / launch
```

When prompted for the ELF path, navigate to:

```
.pio/build/<env>/firmware.elf
```

**Step 3** — Use DAP keymaps to control execution:

| Keymap       | Action                 |
| :----------- | :--------------------- |
| `<leader>dc` | Continue / launch      |
| `<leader>db` | Toggle breakpoint      |
| `<leader>dB` | Conditional breakpoint |
| `<leader>do` | Step over              |
| `<leader>di` | Step into              |
| `<leader>dO` | Step out               |
| `<leader>dt` | Terminate session      |
| `<leader>du` | Toggle DAP UI          |

---

## Window navigation

Powered by [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) with tmux
integration — splits and tmux panes are navigated with the same keys.

| Keymap               | Action                 |
| :------------------- | :--------------------- |
| `<C-h/j/k/l>`        | Move between splits    |
| `<M-h/j/k/l>`        | Resize splits          |
| `<leader><leader>h`  | Swap buffer left       |
| `<leader><leader>j`  | Swap buffer down       |
| `<leader><leader>k`  | Swap buffer up         |
| `<leader><leader>l`  | Swap buffer right      |

---

## File explorer

Neo-tree is enabled. Toggle it with:

| Keymap      | Action               |
| :---------- | :------------------- |
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Focus file explorer  |

---

## Plugin overview

| Plugin                  | Purpose                              |
| :---------------------- | :----------------------------------- |
| lazy.nvim               | Plugin manager                       |
| LazyVim                 | Neovim distribution / base config    |
| nvim-lspconfig + clangd | C/C++ language server                |
| mason.nvim              | LSP/tool installer                   |
| nvim-platformio.lua     | PlatformIO build/upload/monitor      |
| toggleterm.nvim         | Embedded terminal (used by PIO)      |
| nvim-dap + cpptools     | Hardware debugging via OpenOCD       |
| conform.nvim            | Formatting (clang-format)            |
| nvim-treesitter         | Syntax highlighting (C, CMake, Make) |
| nord.nvim               | Colorscheme                          |
| smart-splits.nvim       | Tmux-aware split navigation          |
| neo-tree.nvim           | File explorer                        |
| telescope.nvim          | Fuzzy finder                         |

---

## Troubleshooting

**clangd shows errors everywhere**
→ Make sure `compile_commands.json` exists at the project root. Run `pio run -t compiledb` and
symlink the file as described above.

**clangd complains about unknown flags**
→ Add a `.clangd` file with `CompileFlags.Remove` as shown in the LSP section.

**PlatformIO commands not found**
→ Make sure `pio` is on your PATH before launching Neovim. Test with `which pio` in your shell.

**OpenOCD can't connect**
→ Check the interface config file matches your programmer (USB-JTAG, ESP-Prog, etc.).
Run `openocd` manually first to confirm the connection before starting a DAP session.

**Mason tools missing after first launch**
→ Run `:Mason` and check that `clangd`, `clang-format`, and `cpptools` are installed.
