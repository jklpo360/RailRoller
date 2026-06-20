Rail Roller is a comprehensive tabletop assistant to the board game Rail Baron.
 
![alt text][modernRailRoller]

## Installation

Use the [web version]() or download from the [github page](https://github.com/jklpo360/RailRoller/releases/) for releases on every platform.

## Getting started

![alt text][mainMenu]

To start a game with Rail Roller, press the Start button from the main menu.
This will open a prompt to enter the number of players, and after that is answered, the pre-game menu will open.

![alt text][preGameMenu]

In this menu, you can enter each player's name and pawn color, as well as setting which keys will give them a new destination.
After each player clicks their "Ready" button, the main gameplay assistant will appear on the screen.

## Options

The options menu can be opened from the main menu or at any time by pressing the Escape key.

![alt text][optionMenu]

 - The lanugage can manually be changed by in the 'select language' sub-menu.
 - The 'swap rule' option enables swapping a players home city and first destination before they take their first turn, which is a recommended rule in the [New Century ruleset](https://www.railgamefans.com/rbp/rb21rules.htm).
 - By default, regions are only shown for Portland, but the 'always show regions' option will make it so every city will have its regions shown.
This is useful when playing with people that are less familiar with US geography or the board in general.

## Main assistant

Right when the game starts, every player will be assigned a home city.
Multiple players can be assigned to the same home city as per the [New Century rules](https://www.railgamefans.com/rbp/rb21rules.htm).
The players are then rolled for their first destination, and in the event that a player rolls the same region as their home city, the region choice menu will pop up.

![alt text][regionMenu]

The player who is currently choosing their region will have their destination set to 'Choose a region' while the region choice is pending.
If it is unclear who the region selection menu popped up for, the menu can be minimized with the '-' button at the top right.

To roll for new destinations, press either of the keys assigned to each player during setup.
By default these are the 1-6 number keys, but its recommended to space the keys apart to prevent mis-presses and allow players to reach their own destination keys.

## Saving and loading

To save the state of the assistant, open the options menu and press the 'Save' button at the bottom.
This can be loaded at any future time from the load menu accessable from the main menu through the 'Load' button.

![alt text][loadMenu]

The load button(left) will load the saved assistant session, and the refresh button(right) will check for a new save file.
The save file is located in the same folder/directory as RailRoller.exe, and is named 'SaveFile.json'.

## Exiting

The once in the pre-game menu or main assistant, the options menu will have a 'Quit' button at the bottom.
When pressed, the assistant will immediately return back to the main menu without saving progress.
From the main menu, the 'Exit' Button can be pressed to close the assistant.

[modernRailRoller]: https://github.com/jklpo360/RailRoller/raw/main/images/modernrailroller.png "Example of Rail Roller in action"
[mainMenu]: https://github.com/jklpo360/RailRoller/raw/main/images/mainmenu.jpg "Main menu of Rail Roller"
[preGameMenu]: https://github.com/jklpo360/RailRoller/raw/main/images/pregamemenu.jpg "Pre-game setup menu"
[optionMenu]: https://github.com/jklpo360/RailRoller/raw/main/images/optionmenu.jpg "Options menu"
[regionMenu]: https://github.com/jklpo360/RailRoller/raw/main/images/regionmenu.jpg "Region choice menu"
[loadMenu]: https://github.com/jklpo360/RailRoller/raw/main/images/loadmenu.jpg "Loading menu"