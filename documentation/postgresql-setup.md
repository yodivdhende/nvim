# PostgreSQL Database Setup in Neovim

Guide for querying PostgreSQL databases directly inside Neovim using the **vim-dadbod** ecosystem.

## Plugins

| Plugin                              | Role                                   |
| :---------------------------------- | :------------------------------------- |
| `tpope/vim-dadbod`                  | Core database driver (PostgreSQL, etc) |
| `kristijanhusak/vim-dadbod-ui`      | UI drawer, connection manager          |
| `kristijanhusak/vim-dadbod-completion` | SQL completions via nvim-cmp        |

Config file: `lua/plugins/database.lua`

## Installation

Open Neovim and run:

```
:Lazy sync
```

## Adding a Connection

### Option A — via the UI (ad-hoc)

```
:DBUIAddConnection
```

Enter a PostgreSQL connection URL when prompted:

```
postgresql://user:password@localhost:5432/mydb
```

### Option B — via environment variable (recommended for projects)

Set these in your shell or `.env` file:

```sh
export DBUI_URL="postgresql://user:password@localhost:5432/mydb"
export DBUI_NAME="My DB"
```

Open Neovim — the connection appears automatically in the DBUI drawer.

### Option C — hardcoded named connections (permanent)

Add to `lua/config/options.lua`:

```lua
vim.g.dbs = {
  { name = "local_mydb", url = "postgresql://user:password@localhost:5432/mydb" },
}
```

> **Warning:** Never commit credentials to git. Prefer Option B with a gitignored `.env`.

## Keymaps

| Keymap       | Action                         |
| :----------- | :----------------------------- |
| `<leader>Du` | Toggle the DBUI drawer         |
| `<leader>Da` | Add a new connection           |
| `<leader>Df` | Find which DB a buffer belongs to |

## Using the UI

Open the drawer with `<leader>Du`. Navigate with:

| Key      | Action                              |
| :------- | :---------------------------------- |
| `<Enter>`| Expand/collapse node or open table  |
| `o`      | Open a query editor for a table     |
| `R`      | Refresh the connection              |
| `d`      | Delete a connection                 |
| `A`      | Add a new connection                |

## Running Queries

In any `.sql` buffer or DBUI query editor:

| Key              | Action                        |
| :--------------- | :---------------------------- |
| `<leader>S`      | Execute query under cursor    |
| `<leader>E`      | Execute the entire file       |
| visual `<leader>S` | Execute the selected SQL    |

Results appear in a split below the query buffer.

## Ad-hoc Queries (no UI)

Run a one-shot query directly from the command line:

```vim
:DB postgresql://user:password@localhost:5432/mydb SELECT * FROM users LIMIT 10;
```

Or reference a named connection:

```vim
:DB local_mydb SELECT now();
```

## SQL Completions

Completions are provided by `vim-dadbod-completion` and integrate with **nvim-cmp** automatically in `sql`, `mysql`, and `plsql` buffers. No extra setup needed.

## Connection Storage

Connections added via `:DBUIAddConnection` are saved to:

```
~/.local/share/nvim/db_ui/
```

This directory is outside your git repo — credentials are not tracked.

## Security Checklist

- [ ] Never put credentials in `lua/config/options.lua` if that file is tracked by git
- [ ] Add `.env` to `.gitignore`
- [ ] Use `DBUI_URL` / `DBUI_NAME` env vars for project-specific connections
- [ ] Use Option A (UI prompt) for one-off local connections
