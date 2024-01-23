# Curved Strike

## General Information

Curved Strike is a map inspired by the love for the Direct Strike map. It features a large number of configurable parameters at the start of the game and extensive statistics during gameplay. The game mode is Mix only.

## Configurable Parameters:
- **Global**:
   - **Wave interval each players** - Wave release interval between players. The total interval for each player between their turns will be the product of the number of players and the interval)
   - **Wave interval all players** - The interval for the next wave after all players have launched waves and a full cycle has passed for the team
   - **Base HP** - Maximum health capacity of the team's main base
   - **Tower HP** - Maximum health capacity of the team's tower
- **Economy**
   - **Start gold** - Initial amount of gold with which players start the game
   - **Base income/min** - Starting amount of income
   - **Added inc for each mine** - Additional income awarded to the player for each mine upgrade
   - **Added inc for controlling center** - Additional income for team control of the center
   - **Price first mine** - Cost of the first upgrade for the mine
   - **Price diff for each next mine** - Price increase for each subsequent mine upgrade
   - **Gold for killing the tower** - Amount of gold awarded to each team member for destroying an enemy tower
   - **Gold for killing units** - Amount of gold earned for killing enemy units, calculated as a percentage of their cost
   - **Upkeep** - No Upkeep (0-50 Food: 100% income); Low Upkeep (51-100 Food: 80% income); High Upkeep (101+ Food: 60% income)
- **Units**
   - **Available units** - Select units that will be available for random distribution among players
   - **Mirror units** - Distribute identical random units to players of opposing teams in corresponding positions
   - **Max lifespan of unit in waves** - Number of waves after a unit's deployment, upon which the unit will disappear
- **Heroes**
   - **Available heroes** - Select heroes that will be available for random distribution among players
   - **Max heroes** - Maximum possible number of heroes for each player (0 - 7)
   - **Selectable hero count** - Number of random heroes available for a player to choose from when summoning each subsequent hero
   - **Item capacity** - Maximum number of items that a hero can carry
   - **Start hero level** - The initial level of the hero after construction
 
## In-Game Real-Time Statistics:
- **Players statistic:**
   - **Name** - Player's name
   - **Wave** - Time until the player's wave is released
   - **Inc/min** - Current income per minute
   - **Gold total** - Total amount of gold earned
   - **Gold kill** - Gold earned from kills (Displayed only if the Gold for Killing Units option is active)
   - **Kills** - Number of kills
   - **Damage** - Amount of damage dealt
   - **Tier** - Player's tier
   - **Army** - Size of the army
   - **Heroes** - Icons of built heroes
- **Heroes statistic:**
   - **P** - Hero's rank based on the damage dealt
   - **Name** - Hero's icon and name
   - **Kills** - Number of kills by the hero
   - **Damage** - Amount of damage dealt by the hero

## External Dependencies

- The map's basis includes unit characteristics, heroes, and prices from the [Direct Strkike](https://www.hiveworkshop.com/threads/direct-strike-reforged-open-source.335961/)
- Map building using [cheapack](https://github.com/nazarpunk/cheapack)
- [Total Initialization](https://www.hiveworkshop.com/threads/total-initialization.317099/)
- Logic debugging [Debug Utils](https://www.hiveworkshop.com/threads/debug-utils-ingame-console-etc.330758/)
- Item store [TasItemshop](https://www.hiveworkshop.com/threads/tasitemshop.328382/)


## Build

To compile, run (details in [cheapack](https://github.com/nazarpunk/cheapack)):
- run-unix-release.lua - Build the version without the debug library and debug triggers
- run-unix-with-debug.lua - Build the version with the debug library and triggers.

I have modified the [cheapack](https://github.com/nazarpunk/cheapack) scripts for Unix compatibility. If you need to compile on Windows, please contact me or make a pull request yourself.

