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
