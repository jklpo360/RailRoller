region_names = {
  "NE": 9,
  "SE": 11,
  "NC": 8,
  "SC":11,
  "P":9,
  "NW":9,
  "SW":10
}

def makeCommas(rows, cols):
  accum = ""
  for i in  range(rows-1):
    accum += '\n  ['
    for j in range(cols-1):
      if (cols == rows) and (i == j): 
        accum += "   0, "
      else:
        accum += ", "
    accum += "],"
  accum += '\n  ['
  for j in range(cols):
      if (cols == rows) and (cols-1 == j): 
        accum += "   0"
      else:
        if j == cols-1:
          accum += ""
        else:
          accum += ", "
  accum += "]"
  return accum
print("****************keys*******************")
for x in region_names:
  for y in region_names:
    print("\"" + x + y + "\"")

print("****************values*******************")
for x in region_names:
  for y in region_names:
    print("[\n" + makeCommas(region_names[x], region_names[y]) + "\n],")
