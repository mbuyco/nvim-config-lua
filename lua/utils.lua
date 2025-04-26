local M = {}

-- @param package_name: String
-- @return: any or nil
M.get_package = function(package_name)
  if type(package_name) ~= 'string' then
    return nil
  end

  local ok, package = pcall(require, package_name)
  if not ok then
    return nil
  end

  return package
end

-- @param config_name: String
-- @param options: Table
M.setup_config = function(config_name, options)
  local config = M.get_package(config_name)
  if not config then
    return
  end

  config.setup(options)
end

return M
