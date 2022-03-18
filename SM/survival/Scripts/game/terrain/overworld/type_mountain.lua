--This file is generated! Don't edit here.

----------------------------------------------------------------------------------------------------
-- Data
----------------------------------------------------------------------------------------------------

local g_mountain = {} --Flags lookup table

-------------------------------
-- Bits                      --
-- dir | SE | SW | NW | NE | --
-- bit |  3 |  2 |  1 |  0 | --
-------------------------------

local function toMountainIndex( se, sw, nw, ne )
	return bit.bor( bit.lshift( se, 3 ), bit.lshift( sw, 2 ), bit.lshift( nw, 1 ), bit.tobit( ne ) )
end

function initMountainTiles()
	for i=0, 15 do
		g_mountain[i] = { tiles = {}, rotation = 0 }
	end
	g_mountain[toMountainIndex( 0, 0, 0, 1 )] = { tiles = { addTile( 7000101, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0001)_01.tile" ) }, rotation = 0 }
	g_mountain[toMountainIndex( 0, 0, 1, 0 )] = { tiles = { addTile( 7000101, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0001)_01.tile" ) }, rotation = 1 }
	g_mountain[toMountainIndex( 0, 0, 1, 1 )] = { tiles = { addTile( 7000301, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0011)_01.tile" ) }, rotation = 0 }
	g_mountain[toMountainIndex( 0, 1, 0, 0 )] = { tiles = { addTile( 7000101, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0001)_01.tile" ) }, rotation = 2 }
	g_mountain[toMountainIndex( 0, 1, 0, 1 )] = { tiles = { addTile( 7000501, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0101)_01.tile" ) }, rotation = 0 }
	g_mountain[toMountainIndex( 0, 1, 1, 0 )] = { tiles = { addTile( 7000301, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0011)_01.tile" ) }, rotation = 1 }
	g_mountain[toMountainIndex( 0, 1, 1, 1 )] = { tiles = { addTile( 7000701, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0111)_01.tile" ) }, rotation = 0 }
	g_mountain[toMountainIndex( 1, 0, 0, 0 )] = { tiles = { addTile( 7000101, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0001)_01.tile" ) }, rotation = 3 }
	g_mountain[toMountainIndex( 1, 0, 0, 1 )] = { tiles = { addTile( 7000301, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0011)_01.tile" ) }, rotation = 3 }
	g_mountain[toMountainIndex( 1, 0, 1, 0 )] = { tiles = { addTile( 7000501, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0101)_01.tile" ) }, rotation = 3 }
	g_mountain[toMountainIndex( 1, 0, 1, 1 )] = { tiles = { addTile( 7000701, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0111)_01.tile" ) }, rotation = 3 }
	g_mountain[toMountainIndex( 1, 1, 0, 0 )] = { tiles = { addTile( 7000301, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0011)_01.tile" ) }, rotation = 2 }
	g_mountain[toMountainIndex( 1, 1, 0, 1 )] = { tiles = { addTile( 7000701, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0111)_01.tile" ) }, rotation = 2 }
	g_mountain[toMountainIndex( 1, 1, 1, 0 )] = { tiles = { addTile( 7000701, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(0111)_01.tile" ) }, rotation = 1 }
	g_mountain[toMountainIndex( 1, 1, 1, 1 )] = { tiles = { addTile( 7001501, "$SURVIVAL_DATA/Terrain/Tiles/mountain/Mountain(1111)_01.tile" ) }, rotation = 0 }
end

----------------------------------------------------------------------------------------------------
-- Getters
----------------------------------------------------------------------------------------------------

function getMountainTileIdAndRotation( cornerFlags, variationNoise, rotationNoise )
	if cornerFlags > 0 then
		local item = g_mountain[cornerFlags]
		local tileCount = table.getn( item.tiles )

		if tileCount == 0 then
			return -1, 0 --error tile
		end

		local rotation = cornerFlags == 15 and ( rotationNoise % 4 ) or item.rotation

		return item.tiles[variationNoise % tileCount + 1], rotation
	end

	return 0, 0
end
