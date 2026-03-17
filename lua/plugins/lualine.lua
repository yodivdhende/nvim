return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local max_branch_len = 20
    for _, section in pairs(opts.sections or {}) do
      for i, component in ipairs(section) do
        if component == "branch" or (type(component) == "table" and component[1] == "branch") then
          if type(component) == "string" then
            section[i] = {
              "branch",
              fmt = function(s)
                return #s > max_branch_len and s:sub(1, max_branch_len) .. "…" or s
              end,
            }
          else
            local orig_fmt = component.fmt
            component.fmt = function(s)
              s = orig_fmt and orig_fmt(s) or s
              return #s > max_branch_len and s:sub(1, max_branch_len) .. "…" or s
            end
          end
        end
      end
    end
    return opts
  end,
}
