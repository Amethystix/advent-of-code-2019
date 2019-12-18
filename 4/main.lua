
-- Updated for part 2
function isValid(current)
  local currentTbl = numberToTable(current)
  local prevDigit = currentTbl[1]
  local hasAdjacent = false
  local current2Match = false
  local bigGroup = false
  for place, digit in ipairs(currentTbl) do
    if (place ~= 1) then
      if (digit < prevDigit) then 
        return 0
      elseif (digit == prevDigit) then
        if (current2Match == true) then
          bigGroup = true
        else
          current2Match = true
        end
      elseif (digit ~= prevDigit) then
        if (current2Match == true and bigGroup ~= true) then
          hasAdjacent = true
        end
        current2Match = false
        bigGroup = false
      end
    end
    prevDigit = digit
  end
  if (current2Match == true and bigGroup ~= true) then
    hasAdjacent = true
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
