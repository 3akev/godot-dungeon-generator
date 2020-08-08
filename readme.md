# Dungeon generator

A room-based dungeon generation algorithm I originally wrote for [waterblade](https://github.com/ChemicalInk/waterblade), an unfinished game jam entry.

What the model code does is generate a dungeon represented as a bunch of `Rect2` objects, defining rooms and tunnels. `DungeonPlacer.gd` shows how this may be used to place tiles according to the generated dungeon, which is my original use case. Theoretically one can utilize it as one sees fit.

To try it out as-is, open up `Dungeon.tscn`, define a tileset with a `Floor` tile and a `Wall` tile, and play with the parameters.

Apart from the model code, consider this a template. If you ever end up improving the tile placing code, I'd appreciate a PR.

MIT license.