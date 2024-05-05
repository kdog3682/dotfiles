
local function iterate_over_mappings(callback, mode)
  mode = mode or "n"
  local mappings = vim.api.nvim_get_keymap(mode)

  for _, mapping in ipairs(mappings) do
    callback(mapping)
  end
end
function test(s, r)
    return string.match(s, r) ~= nil
end

local function remove_bracket_mappings()
    local function callback(mapping)
        lhs = mapping.lhs
        if test(lhs, pattern) then
            vim.api.nvim_del_keymap('n', lhs)
        end
    end
    iterate_over_mappings(callback)
end

-- remove_bracket_mappings()
