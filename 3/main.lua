function makeCoordinate(x, y, instructionString)
  local coordinate = {}
  local direction = string.sub(instructionString, 1, 1)
  local amount = tonumber(string.sub(instructionString, 2))

  if (direction == 'R') then
    coordinate.x = amount + x
    coordinate.y = y
  elseif (direction == 'L') then
    coordinate.x = x - amount
    coordinate.y = y
  elseif (direction == 'U') then
    coordinate.x = x
    coordinate.y = y + amount
  elseif (direction == 'D') then
    coordinate.x = x
    coordinate.y = y - amount
  end
  return coordinate
end

function inputToCoordinates()
  local file = './input.txt'
  local wires = {}
  for line in io.lines(file) do
    local sep = ','
    local wire = {}
    local x = 0
    local y = 0
    for str in string.gmatch(line, "([^"..sep.."]+)") do
      local coordinate = makeCoordinate(x, y, str)
      x = coordinate.x
      y = coordinate.y
      wire[#wire + 1] = coordinate
    end
    wires[#wires + 1] = wire
  end
  return wires
end

function printWires(wires)
  for k, v in ipairs(wires) do
    print(k)
    for i, coor in ipairs(v) do
      print(string.format('x: %d, y: %d', coor.x, coor.y))
    end
  end
end

-- Not finished yet
function findIntersections(wires)
  local shortestIntersection = math.huge
  for k1, coor1 in ipairs(wires[1]) do
    for k2, coor2 in ipairs(wires[2]) do
      if (coor1.x == coor2.x and coor1.y == coor2.y) then
        local distance = math.abs(coor1.x) + math.abs(coor1.y)
        if (distance < shortestIntersection) then
          shortestIntersection = distance
        end
      end
    end
  end
  return shortestIntersection
end

wires = inputToCoordinates()
print(findIntersections(wires))
