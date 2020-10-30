local pbind = {}

-- bind options
function pbind.bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.api.nvim_command('set ' .. k)
    elseif type(v) == 'table' then
      local values = ''
      for k2, v2 in pairs(v) do
        if k2 == 1 then
          values = values .. v2
        else
          values = values .. ',' .. v2
        end
      end
      vim.api.nvim_command('set ' .. k .. '=' .. values)
    else
      vim.api.nvim_command('set ' .. k .. '=' .. v)
    end
  end
end

local rhs_options = {}

function rhs_options:new()
  local instance = {
    cmd = '',
    options = {
      noremap = false,
      silent = false,
      expr = false,
    }
  }
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function rhs_options:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

function rhs_options:map_cr(cmd_string)
  self.cmd = (":%s<CR>"):format(cmd_string)
  return self
end

function rhs_options:map_cu(cmd_string)
  self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

function rhs_options:with_silent()
  self.options.silent = true
  return self
end

function rhs_options:with_noremap()
  self.options.noremap = true
  return self
end

function rhs_options:with_expr()
  self.options.expr = true
  return self
end

function pbind.map_cr(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cu(cmd_string)
end

function pbind.nvim_load_mapping(mapping)
    for key,value in pairs(mapping) do
      local mode,keymap = key:match("([^|]*)|?(.*)")
      if type(value) == 'table' then
        local rhs = value.cmd
        local options = value.options
        vim.fn.nvim_set_keymap(mode,keymap,rhs,options)
      end
    end
end

return pbind
