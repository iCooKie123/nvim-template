local function extractFolderPath(filePath)
  local lastBackslashIndex = filePath:find "\\[^\\]*%.csproj$"
  if lastBackslashIndex then
    local projectName = filePath:sub(lastBackslashIndex + 1, -8) -- Extract project name
    local folderPath = filePath:sub(1, lastBackslashIndex - 1)
    return folderPath, projectName
  else
    return "Invalid file path", "Invalid project name"
  end
end

return { extractFolderPath = extractFolderPath }
