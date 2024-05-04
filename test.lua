function extractFolderPath(filePath)
  local lastSlashIndex = filePath:find "/[^/]*%.csproj$"
  if lastSlashIndex then
    return filePath:sub(1, lastSlashIndex - 1)
  else
    return "Invalid file path"
  end
end

-- Example usage:
local filePath = "F:/projects/randomproject/GoodProject/GoodProject.csproj"
local folderPath = extractFolderPath(filePath)
print(folderPath) -- Output: F:/projects/randomproject/GoodProject
