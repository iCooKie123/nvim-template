local notify = require "notify"

local TIMEOUT = 10000 -- Timeout period in milliseconds
local CHECK_INTERVAL = 100 -- Interval between checks in milliseconds


local function search_files(global_var_name, file_regex)
  return require("telescope.builtin").find_files {
    prompt_title = "Live Grep",
    find_command = { "rg", "--files", "--no-ignore", "-g" .. file_regex },
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
        require("telescope.actions").close(prompt_bufnr)
        vim.g[global_var_name] = selection.path
      end)

      return true
    end,
  }
end

local function check_search_completion(global_var_name, callback, elapsed_time)
  if vim.g[global_var_name] ~= nil then
    callback(vim.g[global_var_name])
  elseif elapsed_time >= TIMEOUT then
    notify("Search timed out " .. global_var_name, "error")
  else
    elapsed_time = elapsed_time + CHECK_INTERVAL
    vim.defer_fn(function() check_search_completion(global_var_name, callback, elapsed_time) end, CHECK_INTERVAL) -- Check again after CHECK_INTERVAL ms
  end
end

local defer_search = function(global_var_name, file_regex, callback)
  vim.g[global_var_name] = nil
  local elapsed_time = 0
  search_files(global_var_name, file_regex)
  vim.defer_fn(function() check_search_completion(global_var_name, callback, elapsed_time) end, CHECK_INTERVAL) -- Start checking after CHECK_INTERVAL ms
end

return { defer_search = defer_search }
