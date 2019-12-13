function calcFuel(mass)
  return math.floor(mass / 3) - 2
end

function inputToArray()
  local file = './input.txt'
  inputArray = {}
  for line in io.lines(file) do
    inputArray[#inputArray + 1] = tonumber(line)
  end
  return inputArray
end

function calcTotal(input)
  result = 0
  for k, v in ipairs(input) do
    result = result + calcFuel(v)
  end
  return result
end

local input = inputToArray()
print(calcTotal(input))

