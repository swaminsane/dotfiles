local M = {}

local function read_theme()
  local path = os.getenv("HOME") .. "/.config/theme/colors.h"
  local colors = {}

  for line in io.lines(path) do
    local key, val = line:match('#define%s+(%S+)%s+"(#%x+)"')
    if key and val then
      colors[key] = val
    end
  end

  return colors
end

M.colors = read_theme()

return M
