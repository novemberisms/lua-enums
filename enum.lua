--[[
Copyright 2019 Novemberisms

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local Enum = {}

local function defineEnum(enum, variants)
  local variant_keys = {}
  -- input validation
  for i = 1, #variants do
    variant_keys[variants[i]] = true
    -- check the uniqueness of all the variants with the == operator
    for j = i + 1, #variants do
      if variants[i] == variants[j] then
        error("Duplicate variant for Enum definition", 3)
      end
    end
  end

  rawset(enum, "__variants", variants)
  rawset(enum, "__variant_keys", variant_keys)
end

local Enum_mt = {}
Enum_mt.__index = Enum_mt
Enum_mt.__call = function(t, variants)
  local new_enum = setmetatable({}, Enum)
  defineEnum(new_enum, variants)
  return new_enum
end
setmetatable(Enum, Enum_mt)

Enum.__index = function(enum, val)
  if rawget(enum, val) then
    return rawget(enum, val)
  end
  local variant_exists = enum.__variant_keys[val]
  return variant_exists and val or error("No variant called '" .. val .. "' on Enum", 2)
end

Enum.__newindex = function()
  error("Cannot set or edit keys on Enums", 2)
end

return Enum
