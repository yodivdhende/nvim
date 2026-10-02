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

### Option B — via `.env` file (recommended for projects)

Create a `.env` file in the project root:

```sh
DBUI_URL=postgresql://user:password@localhost:5432/mydb
DBUI_NAME=My DB
```

`tpope/vim-dotenv` loads this automatically — on Neovim startup and whenever
you `:cd` into a directory containing its own `.env` — and exports
`$DBUI_URL`/`$DBUI_NAME` into the process environment, no shell or direnv
setup required. The connection then appears automatically in the DBUI drawer.

If you need to load it manually (e.g. after editing the file), run:

```vim
:Dotenv .env
```

Use `:verbose Dotenv` to confirm which variables were set and from where.

### Option C — hardcoded connections, e.g. Google Cloud SQL (gitignored)

For connections you want defined directly in the nvim config rather than
`.env` — e.g. a Google Cloud SQL instance — add entries to
`lua/config/db_connections/local.lua`:

```lua
-- Gitignored: hardcoded database connections that should never be committed.
return {
  {
    name = "GCloud SQL",
    -- Via Cloud SQL Auth Proxy: cloud-sql-proxy PROJECT:REGION:INSTANCE --port 5433
    url = "postgresql://user:password@127.0.0.1:5433/mydb",
  },
}
```

This file is required by `lua/plugins/database.lua` and its entries are
merged into `vim.g.dbs` alongside the `.env`-sourced connection, so both
show up as separate entries in the DBUI drawer. It's listed in `.gitignore`
(`lua/config/db_connections/local.lua`) so the credential never reaches git.

For Google Cloud SQL specifically, either:
- run the [Cloud SQL Auth Proxy](https://cloud.google.com/sql/docs/postgres/connect-auth-proxy) locally and point the URL at `127.0.0.1:<port>` as above, or
- connect directly to the instance's public IP with `?sslmode=require` appended to the URL, provided your IP is authorized in the instance's network settings.

> **Warning:** Never put credentials in a tracked file like `lua/config/options.lua`. Use Option B (`.env`) for personal/local databases, or this gitignored file for connections you want hardcoded.

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
- [ ] Add `.env` to `.gitignore` (already done in this repo)
- [ ] Add `lua/config/db_connections/local.lua` to `.gitignore` (already done in this repo)
- [ ] Use a `.env` file + `tpope/vim-dotenv` for project-specific connections
- [ ] Use `lua/config/db_connections/local.lua` for connections you want hardcoded (e.g. Cloud SQL)
- [ ] Use Option A (UI prompt) for one-off local connections
