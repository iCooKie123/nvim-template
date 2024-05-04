local extractFolderPath = function(filePath)
  local lastSlashIndex = filePath:find "\\[^\\]*%.csproj$"
  if lastSlashIndex then
    return filePath:sub(1, lastSlashIndex - 1)
  else
    return "Invalid file path"
  end
end

return { extractFolderPath = extractFolderPath }
