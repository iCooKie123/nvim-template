-- custom get dll path
vim.g.dotnet_get_dll_path = function()
  local projectName = "OnlineNotebook"
  search_files("dll-files", projectName .. ".dll", function(path)
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

-- custom run dotnet project with powershell and PID
vim.g.dotnet_cmd = function()
  local cmd = [[
    start powershell -NoExit -Command "echo $PID;[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [System.IO.File]::WriteAllText('pid.txt', $PID);dotnet run --project OnlineNotebook ; pause"
  ]]
  os.execute(cmd)
  vim.wait(1000)
  local file = io.open("pid.txt", "rb")
  vim.g["powershell_PID"] = file:read()
  file:close()

  notify("Running dotnet    project PID:" .. vim.g["powershell_PID"], "info", { title = "Dotnet", timeout = 1000 })
end