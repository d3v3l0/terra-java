local P = {}

local C = terralib.includecstring [[
  #include <stdio.h>
  #include <stdlib.h>
]]

P.fatal = macro(function(fmt, ...)
  fmt = "fatal: " .. fmt:asvalue() .. "\n"
  local arg = {...}
  return quote
    C.printf(fmt, arg)
    C.abort()
  end
end)

function P.errorf(fmt, ...)
  fmt = fmt .. "\n"
  error(fmt:format(...))
end

function P.popl(lst)
  local ret = {}
  for i = 2, #lst do
    ret[i - 1] = lst[i]
  end
  return ret
end

return P
