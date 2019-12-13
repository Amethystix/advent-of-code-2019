function inputToArray()
  local file = './input.txt'
  local rawStrs = {}
  for line in io.lines(file) do
    rawStrs[#rawStrs + 1] = line
  end
  local sep = ','
  local tab = {}
  for k, v in ipairs(rawStrs) do
    for str in string.gmatch(v, "([^"..sep.."]+)") do
      table.insert(tab, tonumber(str))
    end
  end
  return tab
end

function printArray(arr)
  for k, v in ipairs(arr) do
    print(v)
  end
end

function translateArray(numArray)
  local index = 1
  while (index < #numArray) do
    if (numArray[index] == 1) then
      numArray[numArray[index + 3] + 1] = numArray[numArray[index + 2] + 1] + numArray[numArray[index + 1] + 1]
    elseif (numArray[index] == 2) then
      numArray[numArray[index + 3] + 1] = numArray[numArray[index + 2] + 1] * numArray[numArray[index + 1] + 1]
    elseif (numArray[index] == 99) then
      return numArray[1]
    end
    index = index + 4
  end
  return numArray[1]
end


-- res = inputToArray()
-- print(translateArray(res))

-- Part 2

function copyTable(tbl)
  local newTable = {}
  for k, v in ipairs(tbl) do
    newTable[k] = v
  end
  return newTable
end

function findValue(endVal)
  local metaTable = inputToArray()
  for i=0, 99 do 
    for j=0, 99 do
      local tempArray = copyTable(metaTable)
      tempArray[2] = i
      tempArray[3] = j
      if (translateArray(tempArray) == endVal) then
        return { i, j }
      end
    end
  end
  return { -1, -1 }
end

printArray(findValue(19690720))
