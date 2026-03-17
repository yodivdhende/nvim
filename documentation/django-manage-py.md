# Django manage.py Integration

Run Django management commands directly from Neovim using **toggleterm.nvim** and a custom **Telescope picker**.

## Plugins

| Plugin | Role |
| :--- | :--- |
| `akinsho/toggleterm.nvim` | Persistent terminal splits for running commands |
| `nvim-telescope/telescope.nvim` | Fuzzy picker for command discovery (bundled with LazyVim) |

Config file: `lua/plugins/django.lua`

## Installation

Open Neovim and run:

```
:Lazy sync
```

## Keymaps

All keymaps are under the `<leader>d` namespace (visible in which-key).

| Keymap | Action |
| :--- | :--- |
| `<leader>dd` | Open Telescope picker with all `manage.py` commands |
| `<leader>dr` | `manage.py runserver` |
| `<leader>dm` | `manage.py migrate` |
| `<leader>dM` | `manage.py makemigrations` |
| `<leader>ds` | `manage.py shell` |
| `<leader>dt` | `manage.py test` |
| `<leader>dT` | `manage.py test <current-app>` (scoped to the open file's directory) |
| `<c-\>` | Toggle the last terminal open/closed |

## Telescope Command Picker

`<leader>dd` is the main entry point for any command you don't have a direct keymap for.

1. Press `<leader>dd` — Neovim runs `manage.py help --commands` in the background
2. All available commands populate a fuzzy-searchable Telescope list
3. Select a command and press `<Enter>`
4. You are prompted for optional extra arguments (e.g. an app label, `--noinput`, `--verbosity 2`)
5. Press `<Enter>` again — a terminal split opens and runs the command

## Virtual Environment

Commands run using the `python` interpreter active in your shell at the time Neovim was opened. To switch environments inside Neovim use the venv selector:

```
<leader>cv   →   select virtualenv
```

Always select the correct venv before running `manage.py` commands.

## manage.py Discovery

The plugin walks up from the current working directory until it finds `manage.py`. This means you can open Neovim from any subdirectory of your project and commands will still resolve correctly.

If no `manage.py` is found, it falls back to `manage.py` on your `$PATH`.

## Terminal Behaviour

- Terminals stay open after a command finishes (`close_on_exit = false`) so you can scroll through output
- Each command opens its own named terminal (e.g. `runserver`, `migrate`)
- Use `<c-\>` to toggle the last terminal; use `<leader>dd` to spawn a new one for a different command
- In terminal mode press `<C-\><C-n>` to return to normal mode

## Example Workflow

```
# Start a Django project session
<leader>cv          → select .venv
<leader>dm          → run migrations
<leader>dr          → start dev server (stays running in background terminal)
<leader>dd          → pick "createsuperuser", enter no extra args, create admin user
<leader>dT          → run tests for the app you're currently editing
```
