--This file is generated! Don't edit here.

----------------------------------------------------------------------------------------------------
-- Data
----------------------------------------------------------------------------------------------------

local g_desert = {} --Flags lookup table

-------------------------------
-- Bits                      --
-- dir | SE | SW | NW | NE | --
-- bit |  3 |  2 |  1 |  0 | --
-------------------------------

local function toDesertIndex( se, sw, nw, ne )
	return bit.bor( bit.lshift( se, 3 ), bit.lshift( sw, 2 ), bit.lshift( nw, 1 ), bit.tobit( ne ) )
end

function initDesertTiles()
	for i=0, 15 do
		g_desert[i] = { tiles = {}, rotation = 0 }
	end
	g_desert[toDesertIndex( 0, 0, 0, 1 )] = { tiles = { addTile( 3000101, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0001)_01.tile" ) }, rotation = 0 }
	g_desert[toDesertIndex( 0, 0, 1, 0 )] = { tiles = { addTile( 3000101, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0001)_01.tile" ) }, rotation = 1 }
	g_desert[toDesertIndex( 0, 0, 1, 1 )] = { tiles = { addTile( 3000301, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_01.tile" ), addTile( 3000302, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_02.tile" ) }, rotation = 0 }
	g_desert[toDesertIndex( 0, 1, 0, 0 )] = { tiles = { addTile( 3000101, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0001)_01.tile" ) }, rotation = 2 }
	g_desert[toDesertIndex( 0, 1, 0, 1 )] = { tiles = { addTile( 3000501, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0101)_01.tile" ) }, rotation = 0 }
	g_desert[toDesertIndex( 0, 1, 1, 0 )] = { tiles = { addTile( 3000301, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_01.tile" ), addTile( 3000302, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_02.tile" ) }, rotation = 1 }
	g_desert[toDesertIndex( 0, 1, 1, 1 )] = { tiles = { addTile( 3000701, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0111)_01.tile" ) }, rotation = 0 }
	g_desert[toDesertIndex( 1, 0, 0, 0 )] = { tiles = { addTile( 3000101, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0001)_01.tile" ) }, rotation = 3 }
	g_desert[toDesertIndex( 1, 0, 0, 1 )] = { tiles = { addTile( 3000301, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_01.tile" ), addTile( 3000302, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_02.tile" ) }, rotation = 3 }
	g_desert[toDesertIndex( 1, 0, 1, 0 )] = { tiles = { addTile( 3000501, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0101)_01.tile" ) }, rotation = 3 }
	g_desert[toDesertIndex( 1, 0, 1, 1 )] = { tiles = { addTile( 3000701, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0111)_01.tile" ) }, rotation = 3 }
	g_desert[toDesertIndex( 1, 1, 0, 0 )] = { tiles = { addTile( 3000301, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_01.tile" ), addTile( 3000302, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0011)_02.tile" ) }, rotation = 2 }
	g_desert[toDesertIndex( 1, 1, 0, 1 )] = { tiles = { addTile( 3000701, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0111)_01.tile" ) }, rotation = 2 }
	g_desert[toDesertIndex( 1, 1, 1, 0 )] = { tiles = { addTile( 3000701, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(0111)_01.tile" ) }, rotation = 1 }
	g_desert[toDesertIndex( 1, 1, 1, 1 )] = { tiles = { addTile( 3001501, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_01.tile" ), addTile( 3001502, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_02.tile" ), addTile( 3001503, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_03.tile" ), addTile( 3001504, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_04.tile" ), addTile( 3001505, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_05.tile" ), addTile( 3001506, "$SURVIVAL_DATA/Terrain/Tiles/desert/Desert(1111)_06.tile" ) }, rotation = 0 }
end

----------------------------------------------------------------------------------------------------
-- Getters
----------------------------------------------------------------------------------------------------

function getDesertTileIdAndRotation( cornerFlags, variationNoise, rotationNoise )
	if cornerFlags > 0 then
		local item = g_desert[cornerFlags]
		local tileCount = table.getn( item.tiles )

		if tileCount == 0 then
			return -1, 0 --error tile
		end

		local rotation = cornerFlags == 15 and ( rotationNoise % 4 ) or item.rotation

		return item.tiles[variationNoise % tileCount + 1], rotation
	end

	return 0, 0
end
