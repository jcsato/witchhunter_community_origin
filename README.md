# Witchhunter Community Challenge Origin

A mod for the game Battle Brothers ([Steam](https://store.steampowered.com/app/365360/Battle_Brothers/), [GOG](https://www.gog.com/game/battle_brothers), [Developer Site](http://battlebrothersgame.com/buy-battle-brothers/)).

## Table of contents

-   [Features](#features)
-   [Requirements](#requirements)
-   [Installation](#installation)
-   [Uninstallation](#uninstallation)
-   [Compatibility](#compatibility)
-   [Building](#building)

## Features

Adds a new origin based on [The Witch Hunter](https://a.co/d/9m1VTYh), a standalone book written in the setting of Battle Brothers by the game's author, Casey Hollingshead. Created for a community challenge over on the game's Steam forums: https://steamcommunity.com/app/365360/discussions/0/6222330214305672079/

The origin sees you control Richter Von Dagentear, a witchhunter-cum-mercernary captain striking out on his own. As Richter straddles these two professions, both his company and his own skills will grow - or decay. This is tracked in the form of "ranks" that rise and fall over the course of the campaign. Additionally, as a new captain, Richter is only able to effectively command so many men. His roster is limited to 12 brothers, including himself, and if he dies the company goes with him.

There are two types of ranks, "Captain" and "Witchhunter".

**Captain** ranks affect the company as a whole, and Richter's confidence if he's unable to prove his ability to lead:
- Rank 0: 10% worse prices for buying and selling, -10 Resolve for Richter
- Rank 1: Contracts pay out 10% more
- Rank 2: Contracts pay out 10% more, tryouts are 10% cheaper
- Rank 3+: Contracts pay out 10% more, tryouts and recruits are 10% cheaper

You lose 1 rank every time you lose a man or fail a contract and gain 1 every time you succeed a contract.

**Witchhunter** ranks affect Richter personally:
- Rank 0: -5 Ranged Skill
- Rank 1: +5 Resolve
- Rank 2: +5 Resolve, +5 Melee Skill, +5 Ranged Skill
- Rank 3+: +10 Resolve, +5 Melee Skill, +5 Ranged Skill, +5 Melee Defense, +5 Ranged Defense

You lose 1 rank every 15 days and gain 2 every time the company slays a Hexe.

## Requirements

1) [Modding Script Hooks](https://www.nexusmods.com/battlebrothers/mods/42) (v20 or later)

## Installation

1) Download the mod from the [releases page](https://github.com/jcsato/witchhunter_community_origin/releases/latest)
2) Without extracting, put the `witchhunter_community_origin_*.zip` file in your game's data directory
    1) For Steam installations, this is typically: `C:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data`
    2) For GOG installations, this is typically: `C:\Program Files (x86)\GOG Galaxy\Games\Battle Brothers\data`

## Uninstallation

1) Remove the relevant `witchhunter_community_origin_*.zip` file from your game's data directory

## Compatibility

This should be fully save game compatible, i.e. you _should_ be safe to remove the mod at any time, provided the save in question does not use the new origin (obviously).

### Building

To build, run the appropriate `build.bat` script. This will automatically compile and zip up the mod and put it in the `dist/` directory, as well as print out compile errors if there are any. The zip behavior requires Powershell / .NET to work - no reason you couldn't sub in 7-zip or another compression utility if you know how, though.

Note that the build script references the modkit directory, so you'll need to edit it to point to that before you can use it. In general, the modkit doesn't play super nicely with spaces in path names, and I'm anything but a batch expert - if you run into issues, try to run things from a directory that doesn't include spaces in its path.

After building, you can easily install the mod with the appropriate `install.bat` script. This will take any existing versions of the mod already in your data directory, append a timestamp to the filename, and move them to an `old_versions/` directory in the mod folder; then it will take the built `.zip` in `dist/` and move it to the data directory.

Note that the install script references your data directory, so you'll need to edit it to point to that before you can use it.
