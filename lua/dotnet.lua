local dap = require "dap"
local search_files = require("utils/search_files").defer_search
local extractFolderPath = require("utils/extract_folder_path").extractFolderPath
local notify = require "notify"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local callback_build = function(path)
  local cmd = "dotnet build -c Debug " .. path
  print ""
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  vim.g["dotnet_project_path"], vim.g["dotnet_project_name"] = extractFolderPath(path)
  if f == 0 then
    notify("Build: ✅ ", "info", { title = "Build", timeout = 1000 })
    return true
  else
    notify("Build: ❌", "error", { title = "Build", timeout = 1000 })
    return false
  end
end

vim.g.dotnet_build_project = function() search_files("project_files", "*.csproj", callback_build) end

dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.stdpath "data" .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
  args = { "--interpreter=vscode" },
}

local get_config = function()
  return {
    {
      name = "Launch an executable",
      type = "coreclr",
      request = "launch",
      program = function()
        return coroutine.create(function(coro)
          local opts = {}
          pickers
            .new(opts, {
              prompt_title = "Path to executable",
              finder = finders.new_oneshot_job({
                "rg",
                "--files",
                "--no-ignore",
                "--glob",
                "*/bin/Debug/net*/" .. vim.g["dotnet_project_name"] .. ".dll",
              }, {}),
              sorter = conf.generic_sorter(opts),
              attach_mappings = function(buffer_number)
                actions.select_default:replace(function()
                  actions.close(buffer_number)
                  coroutine.resume(coro, action_state.get_selected_entry()[1])
                end)
                return true
              end,
            })
            :find()
        end)
      end,
      args = { "--urls=https://localhost:7149;http://localhost:5148" }, --TODO: make this configurable, with all launch options
      env = {
        ASPNETCORE_ENVIRONMENT = "Development",
      },
      cwd = vim.g["dotnet_project_path"],
      prelaunchTask = function()
        return coroutine.create(function(coro)
          local opts = {}
          pickers
            .new(opts, {
              prompt_title = "Project to build",
              finder = finders.new_oneshot_job({ "rg", "--files", "--no-ignore", "-g", "*.csproj" }, {}),
              sorter = conf.generic_sorter(opts),
              attach_mappings = function(buffer_number)
                actions.select_default:replace(function()
                  actions.close(buffer_number)
                  if callback_build(vim.fn.getcwd() .. "\\" .. action_state.get_selected_entry()[1]) then
                    coroutine.resume(coro, action_state.get_selected_entry()[1])
                  else
                    coroutine.yield(nil)
                  end
                end)
                return true
              end,
            })
            :find()
        end)
      end,
    },
  }
end

dap.configurations.cs = get_config()
dap.configurations.fsharp = get_config()
dap.configurations.netcoredbg = get_config()
