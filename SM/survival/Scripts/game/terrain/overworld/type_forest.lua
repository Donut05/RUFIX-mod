--This file is generated! Don't edit here.

----------------------------------------------------------------------------------------------------
-- Data
----------------------------------------------------------------------------------------------------

local g_forest = {} --Flags lookup table

-------------------------------
-- Bits                      --
-- dir | SE | SW | NW | NE | --
-- bit |  3 |  2 |  1 |  0 | --
-------------------------------

local function toForestIndex( se, sw, nw, ne )
	return bit.bor( bit.lshift( se, 3 ), bit.lshift( sw, 2 ), bit.lshift( nw, 1 ), bit.tobit( ne ) )
end

function initForestTiles()
	for i=0, 15 do
		g_forest[i] = { tiles = {}, rotation = 0 }
	end
	g_forest[toForestIndex( 0, 0, 0, 1 )] = { tiles = { addTile( 2000101, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_01.tile" ), addTile( 2000102, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_02.tile" ), addTile( 2000103, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_03.tile" ), addTile( 2000104, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_04.tile" ), addTile( 2000105, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_05.tile" ) }, rotation = 0 }
	g_forest[toForestIndex( 0, 0, 1, 0 )] = { tiles = { addTile( 2000101, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_01.tile" ), addTile( 2000102, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_02.tile" ), addTile( 2000103, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_03.tile" ), addTile( 2000104, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_04.tile" ), addTile( 2000105, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_05.tile" ) }, rotation = 1 }
	g_forest[toForestIndex( 0, 0, 1, 1 )] = { tiles = { addTile( 2000301, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_01.tile" ), addTile( 2000302, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_02.tile" ), addTile( 2000303, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_03.tile" ), addTile( 2000304, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_04.tile" ), addTile( 2000305, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_05.tile" ) }, rotation = 0 }
	g_forest[toForestIndex( 0, 1, 0, 0 )] = { tiles = { addTile( 2000101, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_01.tile" ), addTile( 2000102, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_02.tile" ), addTile( 2000103, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_03.tile" ), addTile( 2000104, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_04.tile" ), addTile( 2000105, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_05.tile" ) }, rotation = 2 }
	g_forest[toForestIndex( 0, 1, 0, 1 )] = { tiles = { addTile( 2000501, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0101)_01.tile" ) }, rotation = 0 }
	g_forest[toForestIndex( 0, 1, 1, 0 )] = { tiles = { addTile( 2000301, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_01.tile" ), addTile( 2000302, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_02.tile" ), addTile( 2000303, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_03.tile" ), addTile( 2000304, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_04.tile" ), addTile( 2000305, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_05.tile" ) }, rotation = 1 }
	g_forest[toForestIndex( 0, 1, 1, 1 )] = { tiles = { addTile( 2000701, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0111)_01.tile" ) }, rotation = 0 }
	g_forest[toForestIndex( 1, 0, 0, 0 )] = { tiles = { addTile( 2000101, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_01.tile" ), addTile( 2000102, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_02.tile" ), addTile( 2000103, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_03.tile" ), addTile( 2000104, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_04.tile" ), addTile( 2000105, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0001)_05.tile" ) }, rotation = 3 }
	g_forest[toForestIndex( 1, 0, 0, 1 )] = { tiles = { addTile( 2000301, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_01.tile" ), addTile( 2000302, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_02.tile" ), addTile( 2000303, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_03.tile" ), addTile( 2000304, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_04.tile" ), addTile( 2000305, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_05.tile" ) }, rotation = 3 }
	g_forest[toForestIndex( 1, 0, 1, 0 )] = { tiles = { addTile( 2000501, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0101)_01.tile" ) }, rotation = 3 }
	g_forest[toForestIndex( 1, 0, 1, 1 )] = { tiles = { addTile( 2000701, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0111)_01.tile" ) }, rotation = 3 }
	g_forest[toForestIndex( 1, 1, 0, 0 )] = { tiles = { addTile( 2000301, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_01.tile" ), addTile( 2000302, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_02.tile" ), addTile( 2000303, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_03.tile" ), addTile( 2000304, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_04.tile" ), addTile( 2000305, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0011)_05.tile" ) }, rotation = 2 }
	g_forest[toForestIndex( 1, 1, 0, 1 )] = { tiles = { addTile( 2000701, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0111)_01.tile" ) }, rotation = 2 }
	g_forest[toForestIndex( 1, 1, 1, 0 )] = { tiles = { addTile( 2000701, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(0111)_01.tile" ) }, rotation = 1 }
	g_forest[toForestIndex( 1, 1, 1, 1 )] = { tiles = { addTile( 2001501, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(1111)_01.tile" ), addTile( 2001502, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(1111)_02.tile" ), addTile( 2001503, "$SURVIVAL_DATA/Terrain/Tiles/forest/Forest(1111)_03.tile" ) }, rotation = 0 }
end

----------------------------------------------------------------------------------------------------
-- Getters
----------------------------------------------------------------------------------------------------

function getForestTileIdAndRotation( cornerFlags, variationNoise, rotationNoise )
	if cornerFlags > 0 then
		local item = g_forest[cornerFlags]
		local tileCount = table.getn( item.tiles )

		if tileCount == 0 then
			return -1, 0 --error tile
		end

		local rotation = cornerFlags == 15 and ( rotationNoise % 4 ) or item.rotation

		return item.tiles[variationNoise % tileCount + 1], rotation
	end

	return 0, 0
end
