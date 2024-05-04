local dap = require "dap"
local search_files = require("utils/search_files").defer_search
local notify = require "notify"

local callback_build = function(path)
  local cmd = "dotnet build -c Debug " .. path
  print ""
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    notify("Build: ✅", "info", { title = "Build", timeout = 1000 })
  else
    notify("Build: ❌", "error", { title = "Build", timeout = 1000 })
  end
end

vim.g.dotnet_build_project = function() search_files("project_files", "*.csproj", callback_build) end

vim.g.dotnet_get_dll_path = function()
  local projectName = "OnlineNotebook"
  search_files("project_files", projectName .. ".dll", function(path)
    print("Path: " .. path)
    vim.g["dotnet_dll_path"] = path

    local config = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function() return vim.g["dotnet_dll_path"] end,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
        },
      },
    }

    dap.configurations.cs = config
    dap.configurations.fsharp = config
    dap.configurations.netcoredbg = config
    notify("DLL Path configured, ready to debug", "info", { title = "Dotnet", timeout = 1000 })
  end)
end

vim.g.dotnet_cmd = function()
  local cmd = [[
    start powershell -NoExit -Command "echo $PID;[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [System.IO.File]::WriteAllText('pid.txt', $PID);dotnet run --project OnlineNotebook ; pause"
  ]]
  os.execute(cmd)
  vim.wait(1000)
  local file = io.open("pid.txt", "rb") -- r read mode and b binary mode
  vim.g["powershell_PID"] = file:read()
  file:close()

  notify("Running dotnet    project PID:" .. vim.g["powershell_PID"], "info", { title = "Dotnet", timeout = 1000 })
end

dap.adapters.coreclr = {
  type = "executable",
  command = "C:\\Users\\acons\\AppData\\Local\\nvim-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe",
  args = { "--interpreter=vscode" },
}
