
function isValid(current)
  local currentTbl = numberToTable(current)
  local prevDigit = currentTbl[1]
  local hasAdjacent = false
  for place, digit in ipairs(currentTbl) do
    if (place ~= 1) then
      if (digit < prevDigit) then 
        return 0
      elseif (digit == prevDigit) then
        hasAdjacent = true
      end
    end
    prevDigit = digit
  end
  if (hasAdjacent) then
    return 1
  end
  return 0
end

function generatePossibleAnswers(low, high)
  local count = 0
  for i=low, high do
    count = count + isValid(i)
  end
  return count
end

function numberToTable(num) 
  local tbl = {}
  local numStr = tostring(num)
  numStr:gsub('.', function(c) table.insert(tbl,tonumber(c)) end)
  return tbl
end

print(generatePossibleAnswers(272091, 815432))
