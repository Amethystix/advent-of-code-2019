function makeCoordinate(x, y, instructionString)
  local coordinate = {}
  local direction = string.sub(instructionString, 1, 1)
  local amount = tonumber(string.sub(instructionString, 2))

  coordinate.steps = math.abs(amount)

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

function findShortestIntersection(wires)
  local shortestIntersection = math.huge
  local index1 = 1
  while (index1 < #wires[1]) do
    local wire1Coordinate1 = wires[1][index1]
    local wire1Coordinate2 = wires[1][index1 + 1]

    local index2 = 1
    while (index2 < #wires[2]) do
      local wire2Coordinate1 = wires[2][index2]
      local wire2Coordinate2 = wires[2][index2 + 1]

      if (wire2Coordinate1.y >= wire1Coordinate1.y and wire2Coordinate2.y <= wire1Coordinate2.y) or (wire2Coordinate1.y <= wire1Coordinate1.y and wire2Coordinate2.y >= wire1Coordinate2.y) then
        if (wire2Coordinate1.x >= wire1Coordinate1.x and wire2Coordinate2.x <= wire1Coordinate2.x) or (wire2Coordinate1.x <= wire1Coordinate1.x and wire2Coordinate2.x >= wire1Coordinate2.x) then
          local intersection = { x = 0, y = 0 }
          if (wire1Coordinate1.y == wire1Coordinate2.y) then
            intersection.y = wire1Coordinate1.y
            intersection.x = wire2Coordinate1.x
          elseif (wire1Coordinate1.x == wire1Coordinate2.x) then
            intersection.x = wire1Coordinate1.x
            intersection.y = wire2Coordinate1.y
          end
          local distance = math.abs(intersection.x) + math.abs(intersection.y)
          if (distance < shortestIntersection) then
            shortestIntersection = distance
          end
        end
      end
      index2 = index2 + 1
    end
    index1 = index1 + 1
  end
  return shortestIntersection
end

-- wires = inputToCoordinates()
-- print(findIntersections(wires))

-- Part 2
function findFirstIntersection(wires)
  local shortestIntersection = math.huge
  local index1 = 1
  local wire1Steps = 0
  while (index1 < #wires[1]) do
    local wire1Coordinate1 = wires[1][index1]
    local wire1Coordinate2 = wires[1][index1 + 1]
    wire1Steps = wire1Steps + wire1Coordinate1.steps

    local index2 = 1
    local wire2Steps = 0
    while (index2 < #wires[2]) do
      local wire2Coordinate1 = wires[2][index2]
      local wire2Coordinate2 = wires[2][index2 + 1]
      wire2Steps = wire2Steps + wire2Coordinate1.steps

      if (wire2Coordinate1.y >= wire1Coordinate1.y and wire2Coordinate2.y <= wire1Coordinate2.y) or (wire2Coordinate1.y <= wire1Coordinate1.y and wire2Coordinate2.y >= wire1Coordinate2.y) then
        if (wire2Coordinate1.x >= wire1Coordinate1.x and wire2Coordinate2.x <= wire1Coordinate2.x) or (wire2Coordinate1.x <= wire1Coordinate1.x and wire2Coordinate2.x >= wire1Coordinate2.x) then
          local intersection = { x = 0, y = 0 }
          local extraSteps = 0

          if (wire1Coordinate1.y == wire1Coordinate2.y) then
            intersection.y = wire1Coordinate1.y
            intersection.x = wire2Coordinate1.x
            local wire1 = math.abs(intersection.x - wire1Coordinate1.x)
            local wire2 = math.abs(intersection.y - wire2Coordinate1.y)
            extraSteps = wire1 + wire2
          elseif (wire1Coordinate1.x == wire1Coordinate2.x) then
            intersection.x = wire1Coordinate1.x
            intersection.y = wire2Coordinate1.y
            local wire2 = math.abs(intersection.x - wire2Coordinate1.x)
            local wire1 = math.abs(intersection.y - wire1Coordinate1.y)
            extraSteps = wire1 + wire2
          end
          local distance = wire1Steps + wire2Steps + extraSteps
          if (distance < shortestIntersection) then
            shortestIntersection = distance
          end
        end
      end
      index2 = index2 + 1
    end
    index1 = index1 + 1
  end
  return shortestIntersection
end

wires = inputToCoordinates()
print(findFirstIntersection(wires))