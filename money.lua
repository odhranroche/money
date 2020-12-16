math.randomseed(os.time())

-- baseline values
local sequence = {10295,9691,11299,11861,
                  11967,11995,12834,13140,
                  14508,14571,15623,16531,
                  16978,17290,18451,19453,
                  20677,22335,22336,24224,
                  25908,26366,26662,28018}

-- the average amount increased between steps in the list
function average_change(seq)
  local sum = 0
  local val = seq[1]
  for i = 2, #seq do
    sum = sum + (seq[i] - val)
    val = seq[i]
  end

  return sum / ((#seq)-1)
end

-- the list of changes between values in the list
function change_sequence(seq)
  local changes = {}
    
  local val = seq[1]
  for i = 2, #seq do
    local diff = seq[i] - val
    table.insert(changes, diff)
    val = seq[i]
  end

  return changes
end

function mean(t)
  local sum = 0
  local count= 0

  for k,v in pairs(t) do
    if type(v) == 'number' then
      sum = sum + v
      count = count + 1
    end
  end

  return (sum / count)
end

function standard_deviation(t)
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = mean( t )

  for k,v in pairs(t) do
    if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
    end
  end

  result = math.sqrt(sum / (count-1))

  return result
end

function predict(seq, av_change, std_deviation, n)
  for k, v in ipairs(seq) do
    print(v)
  end
  local final_value = seq[#seq]

  for i = 1, n do
    local sum = av_change - math.random(-std_deviation, std_deviation)
    local prediction = math.floor(final_value + sum)
    print(prediction)
    final_value = prediction
  end
end

local av_change = average_change(sequence)
--print("Average change: " .. av_change)
local change_seq = change_sequence(sequence)
--print("Changes: ")
--for k,v in ipairs(change_seq) do
--  print(k,v)
--end
local std_deviation = standard_deviation(change_seq)
--print("Standard deviation: " .. std_deviation)

local num_predictions = 12*3
predict(sequence, av_change, std_deviation, num_predictions)