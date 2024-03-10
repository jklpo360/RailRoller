import random
import os

region = {
  (1,2): "P",
  (1,3): "SE",
  (1,4): "SE",
  (1,5): "SE",
  (1,6): "NC",
  (1,7): "NC",
  (1,8): "NE",
  (1,9): "NE",
  (1,10): "NE",
  (1,11): "NE",
  (1,12): "NE",

  (0,2): "SW",
  (0,3): "SC",
  (0,4): "SC",
  (0,5): "SC",
  (0,6): "SW",
  (0,7): "SW",
  (0,8): "P",
  (0,9): "NW",
  (0,10): "NW",
  (0,11): "P",
  (0,12): "NW"
}

cities = {

  "NE" : {
    (1,2): "NEW YORK",
    (1,3): "NEW YORK",
    (1,4): "NEW YORK",
    (1,5): "ALBANY",
    (1,6): "BOSTON",
    (1,7): "BUFFALO",
    (1,8): "BOSTON",
    (1,9): "PORTLAND",
    (1,10): "NEW YORK",
    (1,11): "NEW YORK",
    (1,12): "NEW YORK",

    (0,2): "NEW YORK",
    (0,3): "WASHINGTON",
    (0,4): "PITTSBURGH",
    (0,5): "PITTSBURGH",
    (0,6): "PHILADELPHIA",
    (0,7): "WASHINGTON",
    (0,8): "PHILADELPHIA",
    (0,9): "BALTIMORE",
    (0,10): "BALTIMORE",
    (0,11): "BALTIMORE",
    (0,12): "NEW YORK"
  },

  "SE" : {
    (1,2): "CHARLOTTE",
    (1,3): "CHARLOTTE",
    (1,4): "CHATTANOOGA",
    (1,5): "ATLANTA",
    (1,6): "ATLANTA",
    (1,7): "ATLANTA",
    (1,8): "RICHMOND",
    (1,9): "KNOXVILLE",
    (1,10): "MOBILE",
    (1,11): "KNOXVILLE",
    (1,12): "MOBILE",

    (0,2): "NORFOLK",
    (0,3): "NORFOLK",
    (0,4): "NORFOLK",
    (0,5): "CHARLESTON",
    (0,6): "MIAMI",
    (0,7): "JACKSONVILLE",
    (0,8): "MIAMI",
    (0,9): "TAMPA",
    (0,10): "TAMPA",
    (0,11): "MOBILE",
    (0,12): "NORFOLK"
  },

  "NC" : {
    (1,2): "CLEVELAND",
    (1,3): "CLEVELAND",
    (1,4): "CLEVELAND",
    (1,5): "CLEVELAND",
    (1,6): "DETROIT",
    (1,7): "DETROIT",
    (1,8): "INDIANAPOLIS",
    (1,9): "MILWAUKEE",
    (1,10): "MILWAUKEE",
    (1,11): "CHICAGO",
    (1,12): "MILWAUKEE",

    (0,2): "CINCINNATI",
    (0,3): "CHICAGO",
    (0,4): "CINCINNATI",
    (0,5): "CINCINNATI",
    (0,6): "COLUMBUS",
    (0,7): "CHICAGO",
    (0,8): "CHICAGO",
    (0,9): "ST LOUIS",
    (0,10): "ST LOUIS",
    (0,11): "ST LOUIS",
    (0,12): "CHICAGO"
  },

  "SC" : {
    (1,2): "MEMPHIS",
    (1,3): "MEMPHIS",
    (1,4): "MEMPHIS",
    (1,5): "LITTLE ROCK",
    (1,6): "NEW ORLEANS",
    (1,7): "BIRMINGHAM",
    (1,8): "LOUISVILLE",
    (1,9): "NASHVILLE",
    (1,10): "NASHVILLE",
    (1,11): "LOUISVILLE",
    (1,12): "MEMPHIS",

    (0,2): "SHREVEPORT",
    (0,3): "SHREVEPORT",
    (0,4): "DALLAS",
    (0,5): "NEW ORLEANS",
    (0,6): "DALLAS",
    (0,7): "SAN ANTONIO",
    (0,8): "HOUSTON",
    (0,9): "HOUSTON",
    (0,10): "FORT WORTH",
    (0,11): "FORT WORTH",
    (0,12): "FORT WORTH"
  },

  "P" : {
    (1,2): "KANSAS CITY",
    (1,3): "KANSAS CITY",
    (1,4): "DENVER",
    (1,5): "DENVER",
    (1,6): "DENVER",
    (1,7): "KANSAS CITY",
    (1,8): "KANSAS CITY",
    (1,9): "KANSAS CITY",
    (1,10): "PUEBLO",
    (1,11): "PUEBLO",
    (1,12): "OKL. CITY",

    (0,2): "OKLAHOMA CITY",
    (0,3): "ST PAUL",
    (0,4): "MINNEAPOLIS",
    (0,5): "ST PAUL",
    (0,6): "MINNEAPOLIS",
    (0,7): "OKLAHOMA CITY",
    (0,8): "DES MOINES",
    (0,9): "OMAHA",
    (0,10): "OMAHA",
    (0,11): "FARGO",
    (0,12): "FARGO"
  },

  "NW" : {
    (1,2): "SPOKANE",
    (1,3): "SPOKANE",
    (1,4): "SEATTLE",
    (1,5): "SEATTLE",
    (1,6): "SEATTLE",
    (1,7): "SEATTLE",
    (1,8): "RAPID CITY",
    (1,9): "CASPER",
    (1,10): "BILLINGS",
    (1,11): "BILLINGS",
    (1,12): "OKL. CITY",

    (0,2): "OKLAHOMA CITY",
    (0,3): "ST PAUL",
    (0,4): "MINNEAPOLIS",
    (0,5): "ST PAUL",
    (0,6): "MINNEAPOLIS",
    (0,7): "OKLAHOMA CITY",
    (0,8): "DES MOINES",
    (0,9): "OMAHA",
    (0,10): "OMAHA",
    (0,11): "FARGO",
    (0,12): "FARGO"
  },

  "SW" : {
    (1,2): "SAN DIEGO",
    (1,3): "SAN DIEGO",
    (1,4): "RENO",
    (1,5): "SAN DIEGO",
    (1,6): "SACREMENTO",
    (1,7): "LAS VEGAS",
    (1,8): "PHEONIX",
    (1,9): "EL PASO",
    (1,10): "TUCUMCARI",
    (1,11): "PHEONIX",
    (1,12): "PHEONIX",

    (0,2): "LOS ANGELES",
    (0,3): "OAKLAND",
    (0,4): "OAKLAND",
    (0,5): "OAKLAND",
    (0,6): "LOS ANGELES",
    (0,7): "LOS ANGELES",
    (0,8): "LOS ANGELES",
    (0,9): "SAN FRANCISCO",
    (0,10): "SAN FRANCISCO",
    (0,11): "SAN FRANCISCO",
    (0,12): "SAN FRANCISCO"
  }
}

region_names = {
  "NE": "NORTHEAST",
  "SE": "SOUTHEAST",
  "NC": "NORTH CENTRAL",
  "SC": "SOUTH CENTRAL",
  "P": "PLAINS",
  "NW": "NORTHWEST",
  "SW": "SOUTHWEST"
}

default_locomotive = 0
express = 1
superchief = 2
max_players = 6
min_players = 1


def init_home_cities():
  for i in range(player_count):
    dice11 = random.randint(1,6)
    dice21 = random.randint(1,6)
    blackdice1 = random.randint(0,1)
    dice12 = random.randint(1,6)
    dice22 = random.randint(1,6)
    blackdice2 = random.randint(0,1)
    home_cities[i] = cities[region[(blackdice1, dice11 + dice21)]][(blackdice2, dice12 + dice22)]

def init_player_names():
  for i in range(player_count):
    player_names[i] = "Player" + str(i+1)

def choose_destination(): 
  dice11 = random.randint(1,6)
  dice21 = random.randint(1,6)
  blackdice1 = random.randint(0,1)
  dice12 = random.randint(1,6)
  dice22 = random.randint(1,6)
  blackdice2 = random.randint(0,1)
  random_region = region[(blackdice1, dice11 + dice21)]
  # Choosing a region
  if random_region == player_regions[current_player]:
    while True:
      # take text as input for region and filter it 
      user_input = input("Choose a region (please enter \"NE\", \"SE\", \"NC\", \"SC\", \"P\", \"NW\", or \"SW\"):")
      if user_input in region_names:
        player_regions[current_player] = user_input
        break
      else:
        print("Invalid input")
  else:
    player_regions[current_player] = random_region
  print("Your new region is: " + region_names[player_regions[current_player]])
  destinations[current_player] = cities[player_regions[current_player]][(blackdice2, dice12 + dice22)]
  print("Your new destination is: " + destinations[current_player])

def pass_turn(current_player):
  os.system('cls')
  if current_player + 1 == player_count:
    return 0
  else:
    return current_player + 1

def print_destination():
  print("Your destination is: " + destinations[current_player])

def roll():

  if locomotives[current_player] == default_locomotive:
    dice1 = random.randint(1,6)
    dice2 = random.randint(1,6)
    if dice1 == dice2 and dice1 == 6:
      return dice1 + dice2 + random.randint(1, 6)
    else:
      return dice1 + dice2

  elif locomotives[current_player] == express:
    dice1 = random.randint(1,6)
    dice2 = random.randint(1,6)
    if dice1 == dice2:
      return dice1 + dice2 + random.randint(1, 6)
    else:
      return dice1 + dice2

  elif locomotives[current_player] == superchief:
    dice1 = random.randint(1,6)
    dice2 = random.randint(1,6)
    dice3 = random.randint(1,6)
    return dice1 + dice2 + dice3

def upgrade():
  if locomotives[current_player] == 2:
    print("You have already gotten all possible train upgrades")
  elif locomotives[current_player] == 1:
    user_input = input("Would you like to upgrade your Express into a Superchief (Y/n):")
    if user_input == "Y":
      locomotives[current_player] = 2
  elif locomotives[current_player] == 0:
    user_input = input("Would you like to upgrade your train into an Express or a Superchief? (E/S/n)")
    if user_input == "E":
      locomotives[current_player] = 1
    if user_input == "S":
      locomotives[current_player] = 2
  else:
    print("Invalid locomotion: " + locomotives[current_player])

def print_locomotive():
  if locomotives[current_player] == 0:
    print("Your train has no upgrades. You roll two dice and a third when you have rolled double sixes")
  elif locomotives[current_player] == 1:
    print("Your train has the Express upgrade. You roll two dice and a third when you have rolled doubles")
  elif locomotives[current_player] == 2:
    print("Your train has the Superchief upgrade. You roll three dice every turn")
  else:
    print("Invalid locomotion: " + locomotives[current_player])

def print_player_turn_message():
  print("                  " + player_names[current_player] + "'s turn                  ")

def print_home_city():
  print(home_cities[current_player])

def print_setup():
  for i in range(player_count):
    print(player_names[i] + "'s home city is: " + home_cities[i] + "\n")
  print("Place each player's pawns at their home city and deal them each $20,000.\n\n")

def print_help():
  #TODO finish help method
  print("                  COMMANDS LIST                  ")
  print("r     : Rolls the dice for your movement.")
  print("c     : Chooses a new destination.")
  print("p     : Passes your turn.")
  print("u     : Upgrades your locomotive.")
  print("d     : Prints your current destination.")
  print("l     : Prints your current locomotive.")
  print("h     : Prints your home city")
  print("n     : Changes your name")
  print("H/help: Prints this menu.")
  print("S/save: Saves the game to a file in the local directory.")
  print("L/load: Loads the game from a file in the local directory.")
  print("Q/quit: Quits the game.")

def save(save_file, player_names, player_regions, destinations, home_cities, locomotives, player_count): 
  with open(save_file, "w") as file:
      file.write(",".join(player_names) + "\n")
      file.write(",".join(player_regions) + "\n")
      file.write(",".join(destinations) + "\n")
      file.write(",".join(home_cities) + "\n")
      file.write(",".join(map(str, locomotives)) + "\n")
      file.write(str(player_count))

def load(save_file):
  with open(save_file, "r") as file:
    lines = file.readlines()
    player_names = lines[0].strip().split(",")
    player_regions = lines[1].strip().split(",")
    destinations = lines[2].strip().split(",")
    home_cities = lines[3].strip().split(",")
    locomotives = list(map(int, lines[4].strip().split(",")))
    player_count = int(lines[5])
    
    return player_names, player_regions, destinations, home_cities, locomotives, player_count


os.system('cls')
player_count = 0
while True:
  try:
    user_input = int(input("How many players? (2-6)"))
    if user_input <= max_players and user_input >= min_players:
      player_count = user_input
      break
  except KeyboardInterrupt:
    quit()
  except:
    print("Invalid number of players (2-6)")
player_names = ["none"]*player_count
player_regions = ["none"]*player_count
destinations = ["none"]*player_count
home_cities = ["none"]*player_count
locomotives = [0]*player_count
init_player_names()
os.system('cls')
init_home_cities()
print_setup()
try:
  input("Are you ready to start the game?")
except KeyboardInterrupt:
  quit()
os.system('cls')
current_player = 0
print_player_turn_message()

try:
  while True:
    print()
    userinput = input("Input (r/c/p/u/d/l/h/n/H/help/S/save/L/load/Q/quit): \n")
    if userinput == "r":
      print(roll())
    
    elif userinput == "c":
      choose_destination()

    elif userinput == "d":
      print_destination()
      
    elif userinput == "p":
      current_player = pass_turn(current_player)
      print_player_turn_message()

    elif userinput == "u":
      upgrade()
    
    elif userinput == "l":
      print_locomotive()

    elif userinput == "Q" or userinput == "quit":
      quit()
    
    elif userinput == "h":
      print_home_city()
    
    elif userinput == "H" or userinput == "help":
      print_help()
    
    elif userinput == "S" or userinput == "save":
      userinput = input("Which save file #: ")
      savefile = "save" + userinput + ".txt"
      save(savefile, player_names, player_regions, destinations, home_cities, locomotives, player_count)
    
    elif userinput == "L" or userinput == "load":
      userinput = input("Are you sure you want to overwrite current data?(Y/n): ")
      if userinput == "Y":
        userinput = input("Which save file #: ")
        savefile = "save" + userinput + ".txt"
        try:
          player_names, player_regions, destinations, home_cities, locomotives, player_count = load(savefile)
        except FileNotFoundError:
          print("No saved data in the file #")
    
    elif userinput == "n":
      userinput = input("Current name is: " + player_names[current_player] + ".\nWould you like to change it?(Y/n): ")
      if userinput == "Y":
        userinput = input("Enter your new name: ")
        player_names[current_player] = userinput
        print("Name changed to: " + userinput)

    else:
      print("Invalid input")

except KeyboardInterrupt:
  quit()