extends Node2D

const NUM_PLAYERS = 3
const DEFAULT_LOCOMOTIVE_ID = 0
const EXPRESS_ID = 1
const SUPERCHIEF_ID = 2
var rng = RandomNumberGenerator.new()
var returned_regions = []

var home_cities = []
var destinations = []
var player_regions = []

var home_cities_text_boxes
var home_cities_text_regions
var old_destination_text_boxes
var old_destination_text_regions
var destination_text_boxes
var destination_text_regions
var reward_text_boxes

signal choose_region
signal open_exit_menu
signal response

var payoff_chart

var region = {
  [1,2]: "P",
  [1,3]: "SE",
  [1,4]: "SE",
  [1,5]: "SE",
  [1,6]: "NC",
  [1,7]: "NC",
  [1,8]: "NE",
  [1,9]: "NE",
  [1,10]: "NE",
  [1,11]: "NE",
  [1,12]: "NE",

  [0,2]: "SW",
  [0,3]: "SC",
  [0,4]: "SC",
  [0,5]: "SC",
  [0,6]: "SW",
  [0,7]: "SW",
  [0,8]: "P",
  [0,9]: "NW",
  [0,10]: "NW",
  [0,11]: "P",
  [0,12]: "NW"
}

var cities = {

  "NE" : {
	[1,2]: "NEW YORK",
	[1,3]: "NEW YORK",
	[1,4]: "NEW YORK",
	[1,5]: "ALBANY",
	[1,6]: "BOSTON",
	[1,7]: "BUFFALO",
	[1,8]: "BOSTON",
	[1,9]: "PORTLAND",
	[1,10]: "NEW YORK",
	[1,11]: "NEW YORK",
	[1,12]: "NEW YORK",

	[0,2]: "NEW YORK",
	[0,3]: "WASHINGTON",
	[0,4]: "PITTSBURGH",
	[0,5]: "PITTSBURGH",
	[0,6]: "PHILADELPHIA",
	[0,7]: "WASHINGTON",
	[0,8]: "PHILADELPHIA",
	[0,9]: "BALTIMORE",
	[0,10]: "BALTIMORE",
	[0,11]: "BALTIMORE",
	[0,12]: "NEW YORK"
  },

  "SE" : {
	[1,2]: "CHARLOTTE",
	[1,3]: "CHARLOTTE",
	[1,4]: "CHATTANOOGA",
	[1,5]: "ATLANTA",
	[1,6]: "ATLANTA",
	[1,7]: "ATLANTA",
	[1,8]: "RICHMOND",
	[1,9]: "KNOXVILLE",
	[1,10]: "MOBILE",
	[1,11]: "KNOXVILLE",
	[1,12]: "MOBILE",

	[0,2]: "NORFOLK",
	[0,3]: "NORFOLK",
	[0,4]: "NORFOLK",
	[0,5]: "CHARLESTON",
	[0,6]: "MIAMI",
	[0,7]: "JACKSONVILLE",
	[0,8]: "MIAMI",
	[0,9]: "TAMPA",
	[0,10]: "TAMPA",
	[0,11]: "MOBILE",
	[0,12]: "NORFOLK"
  },

  "NC" : {
	[1,2]: "CLEVELAND",
	[1,3]: "CLEVELAND",
	[1,4]: "CLEVELAND",
	[1,5]: "CLEVELAND",
	[1,6]: "DETROIT",
	[1,7]: "DETROIT",
	[1,8]: "INDIANAPOLIS",
	[1,9]: "MILWAUKEE",
	[1,10]: "MILWAUKEE",
	[1,11]: "CHICAGO",
	[1,12]: "MILWAUKEE",

	[0,2]: "CINCINNATI",
	[0,3]: "CHICAGO",
	[0,4]: "CINCINNATI",
	[0,5]: "CINCINNATI",
	[0,6]: "COLUMBUS",
	[0,7]: "CHICAGO",
	[0,8]: "CHICAGO",
	[0,9]: "ST LOUIS",
	[0,10]: "ST LOUIS",
	[0,11]: "ST LOUIS",
	[0,12]: "CHICAGO"
  },

  "SC" : {
	[1,2]: "MEMPHIS",
	[1,3]: "MEMPHIS",
	[1,4]: "MEMPHIS",
	[1,5]: "LITTLE ROCK",
	[1,6]: "NEW ORLEANS",
	[1,7]: "BIRMINGHAM",
	[1,8]: "LOUISVILLE",
	[1,9]: "NASHVILLE",
	[1,10]: "NASHVILLE",
	[1,11]: "LOUISVILLE",
	[1,12]: "MEMPHIS",

	[0,2]: "SHREVEPORT",
	[0,3]: "SHREVEPORT",
	[0,4]: "DALLAS",
	[0,5]: "NEW ORLEANS",
	[0,6]: "DALLAS",
	[0,7]: "SAN ANTONIO",
	[0,8]: "HOUSTON",
	[0,9]: "HOUSTON",
	[0,10]: "FORT WORTH",
	[0,11]: "FORT WORTH",
	[0,12]: "FORT WORTH"
  },

  "P" : {
	[1,2]: "KANSAS CITY",
	[1,3]: "KANSAS CITY",
	[1,4]: "DENVER",
	[1,5]: "DENVER",
	[1,6]: "DENVER",
	[1,7]: "KANSAS CITY",
	[1,8]: "KANSAS CITY",
	[1,9]: "KANSAS CITY",
	[1,10]: "PUEBLO",
	[1,11]: "PUEBLO",
	[1,12]: "OKLAHOMA CITY",

	[0,2]: "OKLAHOMA CITY",
	[0,3]: "ST PAUL",
	[0,4]: "MINNEAPOLIS",
	[0,5]: "ST PAUL",
	[0,6]: "MINNEAPOLIS",
	[0,7]: "OKLAHOMA CITY",
	[0,8]: "DES MOINES",
	[0,9]: "OMAHA",
	[0,10]: "OMAHA",
	[0,11]: "FARGO",
	[0,12]: "FARGO"
  },

  "NW" : {
	[1,2]: "SPOKANE",
	[1,3]: "SPOKANE",
	[1,4]: "SEATTLE",
	[1,5]: "SEATTLE",
	[1,6]: "SEATTLE",
	[1,7]: "SEATTLE",
	[1,8]: "RAPID CITY",
	[1,9]: "CASPER",
	[1,10]: "BILLINGS",
	[1,11]: "BILLINGS",
	[1,12]: "SPOKANE",

	[0,2]: "SPOKANE",
	[0,3]: "SALT LAKE CITY",
	[0,4]: "SALT LAKE CITY",
	[0,5]: "SALT LAKE CITY",
	[0,6]: "PORTLAND",
	[0,7]: "PORTLAND",
	[0,8]: "PORTLAND",
	[0,9]: "POCATELLO",
	[0,10]: "BUTTE",
	[0,11]: "BUTTE",
	[0,12]: "PORTLAND"
  },

  "SW" : {
	[1,2]: "SAN DIEGO",
	[1,3]: "SAN DIEGO",
	[1,4]: "RENO",
	[1,5]: "SAN DIEGO",
	[1,6]: "SACRAMENTO",
	[1,7]: "LAS VEGAS",
	[1,8]: "PHOENIX",
	[1,9]: "EL PASO",
	[1,10]: "TUCUMCARI",
	[1,11]: "PHOENIX",
	[1,12]: "PHOENIX",

	[0,2]: "LOS ANGELES",
	[0,3]: "OAKLAND",
	[0,4]: "OAKLAND",
	[0,5]: "OAKLAND",
	[0,6]: "LOS ANGELES",
	[0,7]: "LOS ANGELES",
	[0,8]: "LOS ANGELES",
	[0,9]: "SAN FRANCISCO",
	[0,10]: "SAN FRANCISCO",
	[0,11]: "SAN FRANCISCO",
	[0,12]: "SAN FRANCISCO"
  }
}

var region_names = {
  "NE": "NORTHEAST",
  "SE": "SOUTHEAST",
  "NC": "NORTH CENTRAL",
  "SC": "SOUTH CENTRAL",
  "P" : "PLAINS",
  "NW": "NORTHWEST",
  "SW": "SOUTHWEST"
}

func make_transpose(matrix):
	var output = []
	var grid_width = len(matrix)
	var grid_height = len(matrix[0])
	for i in grid_height:
		output.append([])
		for j in grid_width:
			output[i].append(0)
	for i in range(grid_height):
		for j in range(grid_width):
			output[i][j] = matrix[j][i]
	return output

var keys = ["NENE", "NESE", "NENC", "NESC", "NEP", "NENW", "NESW", "SENE", "SESE", "SENC", "SESC", "SEP", "SENW", "SESW", "NCNE", "NCSE", "NCNC", "NCSC", "NCP", "NCNW", "NCSW", "SCNE", "SCSE", "SCNC", "SCSC", "SCP", "SCNW", "SCSW", "PNE", "PSE", "PNC", "PSC", "PP", "PNW", "PSW", "NWNE", "NWSE", "NWNC", "NWSC", "NWP", "NWNW", "NWSW", "SWNE", "SWSE", "SWNC", "SWSC", "SWP", "SWNW", "SWSW"]

var values = [
  [
	[   0,  3.5,    2,    3,  1.5,  2.5,  5.5,    3,  3.5],
	[ 3.5,    0,    4,    4,    2,    1,  3.5,  5.5,   .5],
	[   2,    4,    0,    5,  2.5,    3,  6.5,    1,  4.5],
	[   3,    4,    5,    0,    4,    4,  2.5,    6,  4.5],
	[ 1.5,    2,  2.5,    4,    0,    1,  4.5,  3.5,    2],
	[ 2.5,    1,    3,    4,    1,    0,  3.5,  4.5,  1.5],
	[ 5.5,  3.5,  6.5,  2.5,  4.5,  3.5,    0,    8,    3],
	[   3,  5.5,    1,    6,  3.5,  4.5,    8,    0,  5.5],
	[ 3.5,   .5,  4.5,  4.5,    2,  1.5,    3,  5.5,    0]
  ],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [
	[  10,    7,   11,  9.5,  8.5,  7.5,    8,   12,  6.5],
	[ 9.5,  5.5,  9.5,  9.5,  7.5,    8,    8,   11,    5],
	[ 7.5,    4,  8.5,    8,    6,    5,    5,  9.5,    4],
	[  10,  6.5, 11.5,    8,  8.5,  7.5,    7,   12,    6],
	[  11,    8,   12,   12,   10,    9, 10.5,   13,    6],
	[ 8.5,  5.5,  9.5,  7.5,  7.5,  6.5,    6, 10.5,    5],
	[  15, 11.5,   16, 15.5, 13.5, 12.5,   14,   17,   11],
	[13.5, 10.5, 14.5,   12,   12,   11, 10.5, 14.5,   10],
	[   6,  2.5,    7,  6.5,  4.5,  3.5,    5,    8,  2.5],
	[   5,  1.5,  5.5,  5.5,  3.5,  2.5,    4,    7,    1],
	[13.5,   10,   14,   14,   12,   11, 12.5,   15,  9.5]
  ],
  [
	[   0,    3,  2.5,  1.5,  3.5,    2,    7,  3.5,  5.5,    6,  5.5],
	[   3,    0,  2.5,  4.5,  2.5,    4,    6,    6,  4.5,    4,  4.5],
	[ 2.5,  2.5,    0,    4,    4,  2.5,  7.5,    6,    4,  3.5,    6],
	[ 1.5,  4.5,    4,    0,    5,    1,  8.5,    5,  6.5,    6,    2],
	[ 3.5,  2.5,    4,    5,    0,  5.5,  3.5,    4,    6,  6.5,    2],
	[   2,    4,  2.5,    1,  5.5,    0,    9,  5.5,  5.5,    5,    7],
	[   7,    6,  7.5,  8.5,    3,    9,    0,  8.5,  9.5,   10,    2],
	[ 3.5,    6,    6,    5,    4,  5.5,  8.5,    0,  9.5,  9.5,  6.5],
	[ 5.5,  4.5,    4,  6.5,    6,  5.5,  9.5,  9.5,    0,    1,    8],
	[   6,    4,  3.5,    6,  6.5,    5,   10,  9.5,    1,    0,  8.5],
	[ 5.5,  4.5,    6,    2,    2,    7,    2,  6.5,    8,  8.5,    0]
  ],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [
	[   8,    8,   10,    5,    9,    8,  4.5, 11.5,  7.5],
	[   7,    6,  9.5,  4.5,  7.5,  6.5,    3, 10.5,  5.5],
	[   5,  4.5,    7,    2,  5.5,    5,  1.5,    8,  4.5],
	[   6,    5,    8,    3,  6.5,  5.5,    2,  9.5,    5],
	[ 5.5,    6,  7.5,  2.5,  6.5,  6.5,    3,  8.5,    6],
	[ 7.5,    7,  9.5,  4.5,    8,    7,  3.5, 10.5,  6.5],
	[   9,    8,   11,    6,   10,    9,  5.5,   12,  8.5],
	[  10,    9,   12,    7, 10.5,  9.5,    6,   13,    9]
  ],
  [
	[ 7.5,   10,  8.5,    6,   11,  5.5, 14.5,  8.5,  9.5,  8.5, 12.5],
	[   5,    7,  5.5,  3.5,  8.5,    3,   12,  7.5,    7,    6,   10],
	[ 7.5,  9.5,  6.5,    6,   11,  5.5, 14.5,   10,  6.5,  5.5, 12.5],
	[   6,  8.5,    6,  4.5,  9.5,    4,   13,    8,    7,  5.5, 11.5],
	[ 7.5,   10,    8,    6,   11,    5, 14.5,   10,    8,    7, 12.5],
	[   6,    8,  6.5,  4.5,  9.5,    4,   13,    8,    8,    7,   11],
	[   8,   11,  9.5,    7, 11.5,  6.5, 15.5,    9, 10.5,  9.5, 13.5],
	[   6,    9,    8,  4.5,    9,  5.5,   13,  6.5,   10,    9,   11]
  ],
  [
	[   0,    3,  3.5,  3.5,  2.5,    2,    1,    3],
	[   3,    0,  2.5,    1,  2.5,    1,  3.5,  3.5],
	[ 3.5,  2.5,    0,  1.5,  1.5,    3,    4,    5],
	[ 3.5,    1,  1.5,    0,    2,  1.5,    4,    4],
	[ 2.5,  2.5,  1.5,    2,    0,    3,  3.5,    5],
	[   2,    1,    3,  1.5,    3,    0,  2.5,  2.5],
	[   1,  3.5,    4,    4,  3.5,  2.5,    0,  3.5],
	[   3,  3.5,    5,    4,    5,  2.5,  3.5,    0]
  ],
  [[[]]],
  [[[]]],
  [[[]]],
  [[[]]],
  [
	[  11,    8,   12,    9,   10,    9,    8, 13.5,  7.5],
	[  17, 14.5, 18.5,   14,   16, 15.5,   13, 19.5,   14],
	[  17, 14.5, 19.5,   14, 16.5, 15.5,   13, 20.5,   14],
	[15.5,   15, 19.5, 15.5,   17,   16, 14.5, 20.5,   15], ##### I am unsure about the first element in this line
	[13.5,   11,   15, 10.5,   13,   12,  9.5,   18, 10.5],
	[ 8.5,    7, 10.5,  5.5,  8.5,    8,  4.5, 11.5,  6.5],
	[12.5,  9.5,   14,  9.5, 11.5, 10.5,    8,   15,  9.5],
	[10.5,  7.5,   12,  7.5,  9.5,  8.5,    6,   13,    7],
	[  15, 11.5, 15.5,   13, 13.5, 12.5, 11.5, 16.5,   11],
	[19.5,   17,   21, 16.5,   19,   18, 15.5, 22.5,   17],
	[  16, 12.5, 16.5,   14, 15.5, 13.5,   12,   18,   12]
  ],
  [
	[ 1.5,    5,    4,  1.5,  4.5,  2.5,    8,    3,    7,  7.5,    6],
	[   8, 11.5,   11,    9,   11,    9, 14.5,    6,   14,   14, 12.5],
	[   8, 11.5,   11,    9,   11,    9, 14.5,    6,   14,   14, 12.5],
	[ 8.5, 11.5,   11,  8.5,  9.5,  9.5, 13.5,    5, 14.5, 14.5, 11.5],
	[ 5.5,  8.5,  8.5,  5.5,    8,  5.5, 11.5,    5,   11, 10.5,  9.5],
	[ 4.5,    7,  5.5,    3,    8,    3,   12,  5.5,    8,    7,   10],
	[   4,  7.5,    7,    4,    7,    4, 10.5,  3.5,  9.5,    9,  8.5],
	[   3,    6,    5,  1.5,  6.5,    2,   10,    5,    8,    7,    8],
	[   5,  7.5,  7.5,  6.5,    6,    6,   10,  1.5,   10, 10.5,    8],
	[10.5, 13.5, 13.5, 10.5,   12, 11.5, 15.5,    7,   16, 16.5, 13.5],
	[ 6.5,  9.5,    9,    7,    9,    8, 12.5,  4.5,   12,   12,   11]
  ],
  [
	[ 6.5,    5,  7.5,    6,  7.5,    5,  7.5,    5],
	[ 9.5,  9.5, 12.5,   11,   12,  9.5, 10.5,    7],
	[ 9.5,  9.5, 12.5,   11,   12,  9.5, 10.5,    7],
	[  12, 12.5, 13.5,   13, 13.5,   11,   11,    9],
	[ 6.5,  6.5,    9,  6.5,    9,    5,  7.5,  3.5],
	[   3,    1,  3.5,  2.5,  3.5,    1,    4,  2.5],
	[ 5.5,    5,    7,    6,  7.5,    5,    6,    3],
	[ 4.5,    3,  5.5,    4,  5.5,    3,  5.5,    3],
	[   9,  8.5,   11,  9.5,   11,  8.5,   10,    7],
	[  12, 12.5, 14.5, 13.5,   14, 11.5,   13,    9],
	[ 8.5,  8.5,   11, 11.5, 10.5,    9,  8.5,  8.5]
  ],
  [
	[   0,  6.5,  6.5,    7,    4,    4,  2.5,    2,  3.5,  9.5,  4.5],
	[ 6.5,    0,  0.5,  2.5,  3.5,  8.5,    9,    7,    5,  2.5,    2],
	[ 6.5,  0.5,    0,    2,    4,  8.5,    9,    7,    5,  2.5,    2],
	[   7,  2.5,  2.5,    0,  4.5,   10,    6,  8.5,  3.5,    2,  2.5],
	[   4,  3.5,    4,  4.5,    0,    5,  1.5,  3.5,  4.5,    6,    2],
	[   4,  8.5,  8.5,   10,    5,    0,    4,    2,  7.5, 11.5,    8],
	[ 2.5,    9,    9,    6,  1.5,    4,    0,  2.5,    4,  7.5,    4],
	[   2,    7,    7,    8,  3.5,    2,  2.5,    0,  5.5,   10,  6.5],
	[ 3.5,    5,    5,  3.5,  4.5,  7.5,    4,  5.5,    0,  5.5,    3],
	[ 9.5,  2.5,  2.5,    2,    6, 11.5,  7.5,   10,  5.5,    0,    5],
	[ 4.5,    2,    2,    2,    2,    8,    4,  6.5,    3,    5,    0]
  ],
  [[[]]],
  [[[]]],
  [[[]]],
  [
	[18.5,   18, 20.5, 15.5, 19.5, 18.5,   15, 21.5,   18],
	[  12, 11.5,   14,    9, 12.5, 11.5,  8.5,   15,   11],
	[14.5, 14.5, 16.5, 11.5, 15.5, 14.5,   11, 17.5,   14],
	[12.5,   12, 14.5,  9.5, 13.5,   12,    9,   16, 11.5],
	[12.5,   12,   14,    9,   13,   12,  8.5, 15.5, 11.5],
	[15.5, 14.5, 17.5, 12.5,   16,   15, 11.5, 18.5,   14],
	[  13,   13,   15,   10,   14,   13,  9.5,   16, 12.5],
	[18.5,   18,   21, 15.5, 19.5, 18.5,   15,   22,   18],
	[  12,   12,   14,    9,   13,   12,  8.5, 15.5, 11.5]
  ],
  [
	[15.5, 18.5,   18,   14,   18, 14.5,   22,   15,   19, 18.5,   20],
	[ 9.5,   13, 11.5,    8,   13,    9, 16.5,   10,   13,   12, 14.5],
	[13.5, 16.5,   15, 12.5,   17,   12,   21, 14.5,   16,   15,   19],
	[   9,   12,   11,  7.5, 11.5,    8, 15.5,  8.5,   13,   12, 13.5],
	[11.5,   14, 12.5,   10,   15,  9.5, 18.5, 12.5, 13.5, 12.5, 16.5],
	[   9,   12, 11.5,    9,   12,    9, 15.5,    8,   15,   14, 13.5],
	[  10, 13.5, 12.5,    9, 13.5,  9.5,   17, 10.5,   14, 13.5,   15],
	[  15, 18.5,   18,   14,   18, 14.5, 21.5,   14,   19, 18.5,   20],
	[11.5,   14, 12.5,   10,   15,  9.5, 18.5, 12.5, 13.5, 12.5, 16.5]
  ],
  [
	[10.5, 12.5, 13.5,   13,   13, 11.5, 13.5,    9],
	[ 3.5,  6.5,    7,    7,  6.5,  5.5,  3.5,  3.5],
	[ 6.5,    9,   10,  9.5,    9,    8,  5.5,    8],
	[ 4.5,    6,    8,  6.5,    7,    5,  5.5,    3],
	[   4,    7,  7.5,  7.5,  6.5,    6,  3.5,  5.5],
	[   8,    9, 10.5,   10, 10.5,  7.5,  8.5,  5.5],
	[   5,  7.5,  8.5,    8,  7.5,  6.5,    5,    4],
	[10.5, 12.5, 13.5,   13,   13, 11.5, 11.5,    9],
	[   4,    7,  7.5,  7.5,  6.5,    6,  3.5,  5.5]
  ],
  [
	[13.5,  8.5,  8.5,   11,   11,   12,   11, 12.5, 13.5,   11,   10],
	[   8,  7.5,  7.5,   10,    7,    6,  6.5,  6.5, 10.5,   10,    8],
	[  13, 12.5, 12.5,   15,   12,  9.5,   11,   11,   15,   15,   13],
	[ 7.5,    5,    5,    8,    5,  5.5,    5,    6,  8.5,    8,  5.5],
	[10.5,   10,   10, 12.5,  9.5,    7,    9,  8.5, 12.5, 12.5,    8],
	[ 7.5,  2.5,  2.5,    5,  3.5,  8.5,    5,  7.5,  7.5,    5, 10.5],
	[   9,    7,    7,  9.5,    7,    7,  6.5,  7.5, 13.5,   10,  7.5],
	[13.5,  7.5,  7.5,   10,   10,   12,   11, 12.5, 13.5,  9.5,   10],
	[10.5,   10,   10, 12.5,  9.5,    7,    9,  8.5, 12.5, 12.5, 10.5]
  ],
  [
	[   0,    7, 11.5,  6.5,    9,  7.5,  5.5,    1,    9],
	[   7,    0,    5,    2,  2.5,  5.5,  1.5,    7,  2.5],
	[11.5,    5,    0,    7,  2.5, 10.5,    6, 12.5,  2.5],
	[ 6.5,    2,    7,    0,    5,  3.5,    2,    6,    5],
	[   9,  2.5,  2.5,    5,    0,    8,  3.5,  9.5,    0],
	[ 7.5,  5.5, 10.5,  3.5,    8,    0,  5.5,    7,    8],
	[ 5.5,  1.5,    6,    2,  3.5,  5.5,    0,  5.5,  3.5],
	[   1,    7, 12.5,    6,  9.5,    7,  5.5,    0,  9.5],
	[   9,  2.5,  2.5,    5,    0,    8,  3.5,  9.5,    0]
  ],
  [[[]]],
  [[[]]],
  [
	[  21,   21,   23,   18,   22,   21, 17.5,   24,   20],
	[23.5,   23, 25.5, 20.5,   24, 23.5,   20, 26.5, 22.5],
	[  18,   18,   20,   15,   19,   18, 14.5, 21.5, 17.5],
	[23.5, 23.5, 25.5, 20.5, 24.5, 23.5,   20,   27,   23],
	[  30, 30.5,   32,   27,   31,   30, 26.5, 33.5,   30],
	[  17,   17,   20,   14,   18,   17, 13.5, 21.5,   18],
	[23.5,   25, 25.5, 20.5,   24, 23.5,   20, 26.5,   23],
	[31.5, 29.5, 31.5, 26.5, 30.5, 29.5,   26, 32.5,   29],
	[26.5, 26.5, 28.5, 23.5, 27.5, 26.5,   23, 29.5, 26.5]
  ],
  [
	[  19, 22.5,   21,   16, 22.5, 18.5,   26,   19,   22, 21.5,   24],
	[21.5,   26, 17.5,   14, 24.5,   21, 28.5,   21,   25, 23.5, 26.5],
	[25.5,   19, 17.5,   14, 18.5, 14.5,   22, 15.5,   19, 18.5,   15],
	[  21,   24,   23, 21.5, 23.5, 20.5, 27.5, 22.5, 24.5,   24, 25.5],
	[  28,   31, 30.5, 26.5, 31.5, 27.5,   35, 28.5,   32,   31,   33],
	[  16,   19,   18, 14.5,   19,   15, 22.5,   16, 19.5,   19, 20.5],
	[20.5, 23.5, 22.5, 20.5, 23.5,   20,   27, 19.5, 24.5, 23.5,   25],
	[  28, 31.5,   30,   27, 31.5,   27,   35,   28,   31,   30,   33],
	[  28,   28,   27, 18.5,   28,   24,   32,   25,   28,   27,   30]
  ],
  [
	[  13, 15.5,   16,   16, 15.5, 14.5,   12,   13],
	[  15,   18, 18.5, 18.5,   18,   17, 14.5, 15.5],
	[  10, 12.5, 13.5,   13, 12.5, 11.5,   10,   10],
	[  15,   18,   19, 18.5,   18,   17, 15.5, 14.5],
	[  22, 24.5, 25.5, 25.5,   25, 24.5, 21.5,   22],
	[   9,   12, 12.5, 13.5,   13,   11,    9,  9.5],
	[  15,   18, 18.5,   18,   18,   17,   15, 14.5],
	[21.5,   24,   25,   25,   24,   23,   21,   22],
	[18.5,   21, 21.5, 21.5,   21,   20,   18,   19]
  ],
  [
	[  18,   15,   15, 17.5, 17.5,   16, 15.5, 16.5,   19, 17.5,   16],
	[  20, 17.5, 17.5,   20,   18,   18, 17.5, 18.5, 21.5, 19.5, 18.5],
	[  14, 11.5, 11.5, 14.5, 11.5,   12,   12, 12.5, 15.5,   14, 12.5],
	[20.5,   15,   15, 17.5,   16, 17.5,   17,   19, 18.5, 17.5, 15.5],
	[26.5, 22.5, 22.5,   25, 24.5, 24.5,   25,   25, 27.5,   25,   24],
	[14.5, 12.5, 12.5, 15.5, 12.5, 12.5, 12.5,   13, 15.5,   15,   13],
	[  19, 13.5, 13.5,   16,   16,   17, 16.5,   19, 18.5,   16,   15],
	[  27,   24,   24, 26.5, 26.5,   25, 24.5, 25.5,   29, 26.5,   26],
	[  24,   21,   21, 23.5,   23,   22, 21.5, 22.5,   26, 23.5, 22.5]
  ],
  [
	[ 6.5, 10.5,  6.5, 10.5,    9,   14,    9,  7.5,    9],
	[   9,   14,    9,   13,   11, 16.5, 11.5,   10,   11],
	[ 8.5,  6.5,  7.5,    7,    8, 10.5,    5,  4.5,    8],
	[   6,   12, 13.5, 12.5, 13.5, 12.5, 10.5,  7.5, 13.5],
	[13.5,   19,   16, 19.5,   18, 21.5, 17.5, 14.5,   18],
	[ 5.5,    7,  4.5,  7.5,    5,    9,  5.5,  6.5,    5],
	[ 5.5, 11.5,   13,   12, 13.5, 12.5, 10.5,  6.5, 13.5],
	[15.5, 19.5,   15, 19.5, 17.5,   23,   18,   16, 17.5],
	[12.5, 18.5,   12, 16.5, 14.5,   20,   15,   13, 14.5]
  ],
  [
	[   0,  2.5,  3.5,    5,  9.5,    5,  6.5,    9,    6],
	[ 2.5,    0,  5.5,  2.5,    7,  7.5,  4.5,  6.5,  3.5],
	[ 3.5,  5.5,    0,  7.5,   13,    3,  7.5, 12.5,    9],
	[   5,  2.5,  7.5,    0,    7,   10,  1.5,    9,    6],
	[ 9.5,    7,   13,    7,    0, 14.5,    9,    2,  3.5],
	[   5,  7.5,    3,   10, 14.5,    0,  9.5,   14,   11],
	[ 6.5,  4.5,  7.5,  1.5,    9,  9.5,    0, 10.5,    8],
	[   9,  6.5, 12.5,    9,    2,   14, 10.5,    0,    3],
	[   6,  3.5,    9,    6,  3.5,   11,    8,    3,    0]
  ],
  [[[]]],
  [
	[  22,   21,   24,   19,   23,   22, 18.5, 25.5, 20.5],
	[  28, 27.5,   30,   25,   28,   28, 24.5,   26, 27.5],
	[30.5,   29, 32.5, 27.5,   31,   30, 26.5, 33.5,   29],
	[  31, 30.5,   33,   28, 31.5,   31, 27.5,   34, 30.5],
	[27.5,   27, 29.5, 24.5,   28,   27, 23.5, 30.5, 26.5],
	[25.5, 28.5, 30.5, 25.5, 29.5, 28.5,   25, 31.5,   28],
	[  27,   30,   32,   27,   31,   30, 26.5, 33.5, 29.5],
	[31.5, 28.5, 32.5,   27, 30.5, 29.5,   26, 33.5, 28.5],
	[  31, 30.5,   33,   28, 31.5,   31, 27.5,   34, 30.5],
	[18.5, 18.5,   21, 16.5,   20,   19, 15.5,   22,   18]
  ],
  [
	[14.5,   19, 17.5, 15.5, 17.5, 15.5, 21.5,   13,   21, 20.5, 19.5],
	[  23, 26.5,   26,   24,   26, 24.5,   30, 21.5,   29,   28, 28.5],
	[  23,   26, 25.5, 23.5,   26, 23.5, 29.5,   21, 29.5, 28.5, 27.5],
	[  27, 30.5,   30,   27,   30,   27, 33.5,   26,   32,   31, 31.5],
	[  19, 22.5,   24,   19,   22, 21.5,   26, 17.5, 26.5, 26.5,   24],
	[  26, 29.5, 27.5, 24.5, 27.5,   25,   33,   25, 28.5,   28,   27],
	[  27,   31,   29,   26,   29, 26.5, 33.5,   26,   31, 30.5, 31.5],
	[22.5,   26, 25.5, 23.5, 25.5, 23.5,   29,   21,   28, 28.5,   27],
	[  27, 30.5,   30,   27,   30,   27, 33.5,   26,   32,   31, 31.5],
	[  13,   16, 15.5,   13,   16,   13, 19.5, 11.5, 18.5,   18, 17.5]
  ],
  [
	[  14, 15.5, 17.5,   17, 16.5,   15, 14.5,   12],
	[19.5, 22.5,   23, 22.5, 22.5, 21.5, 19.5,   19],
	[22.5, 23.5, 25.5,   24,   25, 22.5, 22.5, 20.5],
	[22.5, 25.5,   26, 26.5, 25.5, 24.5, 22.5,   22],
	[19.5,   21, 22.5, 21.5,   22,   20, 19.5,   18],
	[  20,   23, 23.5, 23.5,   23,   22, 20.5, 20.5],
	[  22, 24.5,   25,   25, 24.5, 23.5,   22,   21],
	[  22, 23.5,   25,   24, 24.5, 22.5,   23,   20],
	[22.5, 25.5,   29, 29.5, 25.5, 24.5, 22.5,   22],
	[  11, 12.5, 14.5,   14,   14, 11.5,   11,  9.5]
  ],
  [
	[  13,  6.5,  6.5,  8.5,   10,   15, 11.5, 13.5, 11.5,    6,  8.5],
	[23.5,   16,   16,   17,   19, 21.5,   21,   22,   20, 14.5,   17],
	[  21, 14.5, 14.5, 16.5, 18.5,   23, 19.5,   22, 19.5, 14.5, 16.5],
	[25.5, 19.5, 19.5,   21, 21.5, 24.5,   23, 25.5, 24.5,   19, 21.5],
	[17.5,   11,   11,   13,   16, 22.5, 17.5, 19.5,   16, 10.5,   13],
	[  23,   19,   19,   22, 21.5, 22.5, 20.5,   23,   22,   20,   21],
	[  24, 19.5, 19.5,   21, 21.5,   24,   22, 24.5, 23.5,   19, 21.5],
	[  21, 14.5, 14.5,   16,   18, 22.5,   19, 21.5, 19.5,   17, 16.5],
	[25.5, 19.5, 19.5,   21, 21.5, 24.5,   23, 25.5, 24.5,   19, 21.5],
	[11.5,    5,    5,    8,  7.5,   12,  8.5,   11,   10,    7,  6.5]
  ],
  [
	[ 7.5, 11.5, 16.5,  9.5,   14,    7, 11.5,    6,   14],
	[  10,   16, 17.5, 16.5,   18, 15.5,   15,   11,   18],
	[13.5, 19.5,   21, 17.5, 21.5,   15,   18, 13.5, 21.5],
	[13.5,   19, 20.5, 19.5,   21,   18, 17.5,   14,   21],
	[10.5,   17,   22,   15, 19.5, 12.5,   16,  9.5, 19.5],
	[11.5,   17,   15, 17.5,   19,   16, 15.5,   12,   19],
	[  13,   18,   20,   19, 20.5, 17.5,   17, 13.5, 20.5],
	[14.5, 20.5,   22, 17.5, 22.5, 14.5,   19, 13.5, 22.5],
	[13.5,   19, 20.5, 19.5,   21,   18, 17.5,   14,   21],
	[ 4.5,    9,   14,  6.5, 11.5,    4,  8.5,  3.5,   11]
  ],
  [
	[  14,   16,  9.5, 13.5,   20,   13, 12.5,   22,   20],
	[  11,    9,   12,    6, 13.5,   14,  4.5,   15,   17],
	[14.5,   12,   15,    9,   12, 17.5,    8, 13.5, 15.5],
	[  14,   12,   15,    9,    7, 17.5,    8,    9,   11],
	[  19, 16.5,   14,   14,   16,   16,   12,   18,   20],
	[  12,  9.5, 12.5,    7,  7.5, 15.5,  5.5,  9.5,   11],
	[13.5,   11,   14,  8.5,  6.5,   17,    7,  8.5,   10],
	[15.5,   13, 16.5,   11,   13, 18.5,    9,   15,   17],
	[  14,   12,   15,    9,    7, 17.5,    8,    9,   11],
	[  11, 13.5,    8,   11, 18.5,   11,  9.5, 20.5, 17.5]
  ],
  [
	[   0,   13,    8,   13,  4.5, 10.5,   12,    8,   13,  3.5],
	[  13,    0,    3,  6.5,  7.5,    8,  6.5,  4.5,  6.5,  9.5],
	[   8,    3,    0,  4.5,  4.5,    6,    5,  1.5,  4.5, 11.5],
	[  13,  6.5,  4.5,    0,    9,  2.5,    1,    6,    0, 14.5],
	[ 4.5,  7.5,  4.5,    9,    0, 10.5,    9,    4,    9,  8.5],
	[10.5,    8,    6,  2.5, 10.5,    0,  1.5,  8.5,  2.5, 15.5],
	[  12,  6.5,    5,    1,    9,  1.5,    0,  6.5,    1, 14.5],
	[   8,  4.5,  1.5,    6,    4,  8.5,  6.5,    0,    6,   11],
	[  13,  6.5,  4.5,    0,    9,  2.5,    1,    6,    0, 14.5],
	[ 3.5,  9.5, 11.5, 14.5,  8.5, 15.5, 14.5,   11, 14.5,    0]
  ]
]

var alphabetical_cities = {
  "NE": ["ALBANY", "BALTIMORE", "BOSTON", "BUFFALO", "NEW YORK", "PHILADELPHIA", "PITTSBURGH", "PORTLAND", "WASHINGTON"],
  "SE": ["ATLANTA", "CHARLESTON", "CHARLOTTE", "CHATTANOOGA", "JACKSONVILLE", "KNOXVILLE", "MIAMI", "MOBILE", "NORFOLK", "RICHMOND", "TAMPA"],
  "NC": ["CHICAGO", "CINCINNATI", "CLEVELAND", "COLUMBUS", "DETROIT", "INDIANAPOLIS", "MILWAUKEE", "ST LOUIS"],
  "SC": ["BIRMINGHAM", "DALLAS", "FORT WORTH", "HOUSTON", "LITTLE ROCK", "LOUISVILLE", "MEMPHIS", "NASHVILLE", "NEW ORLEANS", "SAN ANTONIO", "SHREVEPORT"],
  "P" : ["DENVER", "DES MOINES", "FARGO", "KANSAS CITY", "MINNEAPOLIS", "OKLAHOMA CITY", "OMAHA", "PUEBLO", "ST PAUL"],
  "NW": ["BILLINGS", "BUTTE", "CASPER", "POCATELLO", "PORTLAND", "RAPID CITY", "SALT LAKE CITY", "SEATTLE", "SPOKANE"],
  "SW": ["EL PASO", "LAS VEGAS", "LOS ANGELES", "OAKLAND", "PHOENIX", "RENO", "SACRAMENTO", "SAN DIEGO", "SAN FRANCISCO", "TUCUMCARI"]
}

#   
#    0  1  2  3  4  5  6
#    7  8  9 10 11 12 13
#   14 15 16 17 18 19 20
#   21 22 23 24 25 26 27
#   28 29 30 31 32 33 34
#   35 36 37 38 39 40 41
#   42 43 44 45 46 47 48
#   

# Called when the node enters the scene tree for the first time.
func _ready():
	choose_region.connect(find_parent("Main").find_children("RegionMenu")[1]._on_choose_region)
	home_cities_text_boxes = find_children("*HomeCitiesText")
	home_cities_text_regions = find_children("*HomeCityRegion")
	old_destination_text_boxes = find_children("*OldText")
	old_destination_text_regions = find_children("*OldRegion")
	destination_text_boxes = find_children("*DestinationText")
	destination_text_regions = find_children("*DestinationRegion")
	reward_text_boxes = find_children("*RewardText")
	
	for i in range(NUM_PLAYERS):
		home_cities_text_boxes[i].label_settings.font_size = 30
		home_cities_text_regions[i].label_settings.font_size = 10
		old_destination_text_boxes[i].label_settings.font_size = 30
		old_destination_text_regions[i].label_settings.font_size = 20
		destination_text_boxes[i].label_settings.font_size = 30
		destination_text_regions[i].label_settings.font_size = 20
		reward_text_boxes[i].label_settings.font_size = 30
	
	values[1] = make_transpose(values[7])
	values[2] = make_transpose(values[14])
	values[3] = make_transpose(values[21])
	values[4] = make_transpose(values[28])
	values[5] = make_transpose(values[35])
	values[6] = make_transpose(values[42])

	values[9] = make_transpose(values[15])
	values[10] = make_transpose(values[22])
	values[11] = make_transpose(values[29])
	values[12] = make_transpose(values[36])
	values[13] = make_transpose(values[43])

	values[17] = make_transpose(values[23])
	values[18] = make_transpose(values[30])
	values[19] = make_transpose(values[37])
	values[20] = make_transpose(values[44])

	values[25] = make_transpose(values[31])
	values[26] = make_transpose(values[38])
	values[27] = make_transpose(values[45])

	values[33] = make_transpose(values[39])
	values[34] = make_transpose(values[46])

	values[41] = make_transpose(values[47])

	payoff_chart = {}
	for i in range(len(keys)):
		payoff_chart[keys[i]] = values[i]
	
	for i in range(NUM_PLAYERS):
		home_cities.append(0)
		destinations.append(0)
		player_regions.append(0)
		returned_regions.append("NAR")
		assign_home_city(i)
		choose_destination(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assign_home_city(player):
	if home_cities_text_regions[player].text != "":
		home_cities_text_regions[player].text = ""
	var dice11 = rng.randi_range(1,6)
	var dice21 = rng.randi_range(1,6)
	var blackdice1 = rng.randi_range(0,1)
	var dice12 = rng.randi_range(1,6)
	var dice22 = rng.randi_range(1,6)
	var blackdice2 = rng.randi_range(0,1)
	var array1 = []
	array1.append(blackdice1)
	array1.append((dice11 + dice21))
	var array2 = []
	array2.append(blackdice2)
	array2.append((dice12 + dice22))
	player_regions[player] = region[array1]
	old_destination_text_regions[player].text = str("(", player_regions[player], ")")
	home_cities[player] = cities[region[array1]][array2]
	destinations[player] = home_cities[player]
	home_cities_text_boxes[player].text = home_cities[player]
	if home_cities[player] == "PORTLAND":
		home_cities_text_regions[player].text = str("(", player_regions[player], ")")


func choose_destination(player): 
	old_destination_text_boxes[player].text = destinations[player]
	old_destination_text_regions[player].text = str("(", player_regions[player], ")")
	var dice11 = rng.randi_range(1,6)
	var dice21 = rng.randi_range(1,6)
	var blackdice1 = rng.randi_range(0,1)
	var dice12 = rng.randi_range(1,6)
	var dice22 = rng.randi_range(1,6)
	var blackdice2 = rng.randi_range(0,1)
	var array1 = []
	array1.append(blackdice1)
	array1.append((dice11 + dice21))
	var array2 = []
	array2.append(blackdice2)
	array2.append((dice12 + dice22))
	var random_region = region[array1]
	# Choosing a region
	if random_region == player_regions[player]:
		choose_region.emit(player, NUM_PLAYERS)
		if returned_regions[player] == "NAR":
			print("waiting for emit")
			await response
		else:
			print("continuing")
		player_regions[player] = returned_regions[player]
		returned_regions[player] = "NAR"
	else:
		player_regions[player] = random_region
	print("player", player, "'s region is: ", player_regions[player])
	var old_city = destinations[player]
	var new_city = cities[player_regions[player]][array2]
	destination_text_regions[player].text = str("(", player_regions[player], ")")
	destinations[player] = new_city
	destination_text_boxes[player].text = destinations[player]
	reward_text_boxes[player].text = str(print_reward(old_city, new_city))

func print_reward(origin, destination):
	var origin_region = ""
	var origin_number = 0
	var i = 0
	for key in alphabetical_cities:
		var city_list = alphabetical_cities.get(key)
		if origin in city_list:
			origin_region = key
			origin_number = city_list.find(origin)
		i += 1
	var destination_region = ""
	var destination_number = 0
	i = 0
	for key in alphabetical_cities:
		var city_list = alphabetical_cities.get(key)
		if destination in city_list:
			destination_region = key
			destination_number = city_list.find(destination)
		i += 1
	var table_key = origin_region + destination_region
	var table = payoff_chart[table_key]
	return table[origin_number][destination_number]

func _input(event):
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_1:
		choose_destination(0)
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_2:
		choose_destination(1)
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_3:
		choose_destination(2)
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE:
		open_exit_menu.emit()

func _region_response(region, player):
	returned_regions[player] = region
	response.emit()
