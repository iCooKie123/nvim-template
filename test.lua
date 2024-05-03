local function read_file(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  print(file:read())
  file:close()
end

local main = function()
  local cmd = [[
  start powershell -NoExit -Command "echo $PID;[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; [System.IO.File]::WriteAllText('pid.txt', $PID); pause"
  ]]
  os.execute(cmd)
  vim.wait(1000)
  read_file "pid.txt"
end

main()
