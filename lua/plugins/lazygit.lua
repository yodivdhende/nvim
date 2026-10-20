-- called by lazygit through --remote-expr: hide the lazygit float, then open the file
-- in the window behind it. Scheduled so the remote call returns before the float closes.
function _G.lazygit_edit(file, line)
  vim.schedule(function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      vim.api.nvim_win_close(0, false)
    end
    vim.cmd.edit(vim.fn.fnameescape(file))
    if line then
      pcall(vim.api.nvim_win_set_cursor, 0, { line, 0 })
    end
  end)
  return ""
end

return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {
      config = {
        os = {
          -- the default "nvim-remote" preset uses --remote-tab; plain --remote would open the file
          -- inside the lazygit float itself, so close the float first and edit in the previous window
          edit = [[nvim --server "$NVIM" --remote-expr "v:lua.lazygit_edit({{filename}})"]],
          editAtLine = [[nvim --server "$NVIM" --remote-expr "v:lua.lazygit_edit({{filename}}, {{line}})"]],
          editAtLineAndWait = [[nvim --server "$NVIM" --remote-expr "v:lua.lazygit_edit({{filename}}, {{line}})"]],
        },
      },
    },
  },
}
