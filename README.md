# Description:

Cataclysm-DDA-LUA is collection of LUA mods for [Dark Days Ahead](http://en.cataclysmdda.com/).

## dda-lua

Shared library mod for easier creation of LUA mods.

## dda-lua-achievements

Mod that adds following achievements:

- *not implemented yet*.

## dda-lua-items

Mod that adds following items:

- `atomic_entity_scanner` - highlights items and creatures around player character;
- `atomic_earthquake_generator` - makes rubbles around player character.

## dda-lua-mapgen

Mod that adds following mapgen:

- *not implemented yet*.

## dda-lua-skills

Mod that adds following skills:

- `athletics` - gives speed bonus based on `squares_walked`.

## dda-lua-traits

Mod that adds following traits:

- `TOURETTE` - shouts bad words when not under medication (`xanax`);
- `NIGHTMARES` - you see bad dreams when not under medication (`ambien`);
- `NUDIST` - +2 to all attributes when naked.

## dda-lua-fun

Mod that adds following fun:

- *not implemented yet*.

# Todo list:

## dda-lua

- enhance capabilities (add `mapgen`, `menu`, `config`);
- implement figlet/ascii intro;
- implement global configuration menu;
- optimize `figlet` data;
- make profiling and optimize code.

## dda-lua-achievements

- add achievements infrastructure to `dda-lua-achievements`;
- add achievements (`squares_walked`, `cash`, `damage_taken`, `damage_healed`, `headshots`, `skill_level`, `attribute`, `recipes_known`, `get_naked`, `speed`).

## dda-lua-items

- rewrite code to make use of `dda-lua`;
- implement solar powered items;
- implement ascii photo-gallery for camera.


## dda-lua-mapgen

- add mapgen infrastructure to `dda-lua-mapgen`;
- rewrite code to make use of `dda-lua`;
- implement some buildings (merge from http://smf.cataclysmdda.com/index.php?topic=14231.msg300728#msg300728);
- implement building degradation (merge from http://smf.cataclysmdda.com/index.php?topic=14825.0).

## dda-lua-skills

- change `athletics` skill to control `stamina` and/or `fatigue`;
- rebalance `athletics` skill practice amount per `squares_walked`.

## dda-lua-traits

- change `NUDIST` trait to affect morale;
- change `NIGHTMARES` trait to affect morale after awake;
- add more nightmare images to `NIGHTMARES` trait.
- add `ALHOHOLIC` trait - Every time you find alcohol, your character has a % chance to automatically pick it up and start drinking - http://smf.cataclysmdda.com/index.php?topic=3310.msg300936#msg300936.
- add `HYPOCHONDRIA` trait - Whenever physically injured or affected by Flu, Infection, Poison or Shroom sickness, character gains a -50 morale penalty until their condition improves to normal. - http://smf.cataclysmdda.com/index.php?topic=3310.msg302481#msg302481
- add `DEAF` trait - http://smf.cataclysmdda.com/index.php?topic=3310.msg302708#msg302708
- add `BLIND` trait

## dda-lua-fun

- implement selection of nationality on character selection screen or new player creation (American, British, German, French, Scottish, etc. Get starting items related to nationality (Germans get beer, Frenchies get baguettes French maid hats, Scotsmen get a bagpipe and a kilt, Norwegians start with viking stuff, etc.) - see http://smf.cataclysmdda.com/index.php?topic=3310.msg303300#msg303300;
- rotting food and corpses create stench clouds that reduce morale. Wearing mouth protection reduces the effect. Perfume and incense can be used for an opposite effect - see http://smf.cataclysmdda.com/index.php?topic=3310.msg300514#msg300514.