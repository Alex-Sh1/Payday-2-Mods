# Improved Offline Functionality

Latest version [v1.4](https://github.com/fragtrane/Payday-2-Mods/raw/master/Improved%20Offline%20Functionality/Improved_Offline_Functionality_v1.4.zip).

This mod can also be found on [Mod Workshop](https://modworkshop.net/mod/25511).

## Overview

This mod provides various improvements when playing without an internet connection. Key features and options:

- **Community Content:** Enable community and achievement content when offline. Some community content and achievement-locked content normally require an internet connection to use. This mod saves the state of these community groups/achievements so that you can continue to use this content even when there is no internet connection. The saved state is tied to your Steam ID so multiple accounts on the same computer are tracked separately and will all work properly.
- **Block Inventory Update:** Disable Steam inventory update when offline so that your skins don't disappear. Also suppresses inventory load failed dialog.
- **Offline Filters:** Show filter button in Crime.net Offline so that you can change the difficulty of the contracts that spawn.
- **Offline Chat:** Enable chat in single player mode.
- **No Interaction Interrupt:** Prevent pause menu and chat from interrupting interactions in single player mode.
- **No Armor Regen Bonus:** Disable the armor regeneration bonus in single player mode.
- **Enable Winters:** Allow Captain Winters to spawn in single player mode.

In order to prevent the locked outfit bug, the saved achievement state is now loaded even when there is an internet connection. In addition, achievements will not be removed from the saved state because there is no way to distinguish between a non-awarded achievement and an achievement that failed to load. Thus, in the unlikely event that you reset your achievements, you should also delete the state file for your Steam account:

```
saves/iof_<steamID64>.txt
```

Community group checking seem to work fine so those are still handled normally.

## Installation [BLT]

This mod requires [SuperBLT](https://superblt.znix.xyz) for automatic updates.

This is a BLT mod. Download [`Improved_Offline_Functionality_v1.4.zip`](https://github.com/fragtrane/Payday-2-Mods/raw/master/Improved%20Offline%20Functionality/Improved_Offline_Functionality_v1.4.zip) and extract the entire contents to your `mods` folder.

The location of the `mods` folder depends on where you installed the game; typically it can be found here:

```
C:\Program Files (x86)\Steam\steamapps\common\PAYDAY 2\mods
```

## Acknowledgments

Some parts of this mod (chat, armor regen, Winters) were inspired by Unknown Knight's [Simulate Online](https://modworkshop.net/mod/16175) mod.

## Contact

Steam: [id/fragtrane](https://steamcommunity.com/id/fragtrane)

Reddit: [/u/fragtrane](https://www.reddit.com/user/fragtrane)

## Changelog

**v1.4 - 2020-03-20**

- Fixed a bug where multiplayer lobbies would appear in Crime.net Offline (thanks realthelift).
- Unnecessary filter options removed from Crime.net Offline. The only option that remains is the difficulty filter.
- Reworked MenuCallbackHandler:is_multiplayer function to prevent unnecessary options from appearing in pause menu of Crime.net Offline.

**v1.3 - 2020-03-04**

- Reworked state loading to prevent locked outfit bug.

**v1.2 - 2020-02-29**

- Added support for the Repairman outfit.
- Added support for the Minstrel outfit and its variations.
- Added support for the PAYDAY 2 Secret.

**v1.1 - 2019-12-04**

- Fixed crash when buying assets (thanks Zed).
- Added support for new achievement-locked oufits.
- Compatibility fixes for update 198.

**v1.0 - 2019-08-15**

- Initial release.
