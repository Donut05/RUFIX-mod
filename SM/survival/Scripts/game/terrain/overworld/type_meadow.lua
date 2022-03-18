
----------------------------------------------------------------------------------------------------
-- Data
----------------------------------------------------------------------------------------------------

local g_meadowTiles = {}

function initMeadowTiles()
	g_meadowTiles = { 
		addTile( 1000001, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_01.tile" ),
		addTile( 1000002, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_02.tile" ),
		addTile( 1000003, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_03.tile" ),
		addTile( 1000004, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_04.tile" ),
		addTile( 1000005, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_05.tile" ),
		addTile( 1000006, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_06.tile" ),
		addTile( 1000007, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_07.tile" ),
		addTile( 1000008, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_08.tile" ),
		addTile( 1000009, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_09.tile" ),
		addTile( 1000010, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_10.tile" ),
		addTile( 1000011, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_11.tile" ),
		addTile( 1000012, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_12.tile" ),
		addTile( 1000013, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_13.tile" ),
		addTile( 1000014, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_14.tile" ),
		addTile( 1000015, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_15.tile" ),
		addTile( 1000016, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_16.tile" ),
		addTile( 1000017, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_17.tile" ),
		addTile( 1000018, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_18.tile" ),
		addTile( 1000019, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_19.tile" ),
		addTile( 1000020, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_20.tile" ),
		addTile( 1000021, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_21.tile" ),
		addTile( 1000022, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_22.tile" ),
		addTile( 1000023, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_23.tile" ),
		addTile( 1000024, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_24.tile" ),
		addTile( 1000025, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_25.tile" ),
		addTile( 1000026, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_26.tile" ),
		addTile( 1000027, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_27.tile" ),
		addTile( 1000028, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_28.tile" ),
		addTile( 1000029, "$SURVIVAL_DATA/Terrain/Tiles/meadow/Meadow_64(1111)_29.tile" )
	}
end

----------------------------------------------------------------------------------------------------
-- Getters
----------------------------------------------------------------------------------------------------

function getMeadowTileIdAndRotation( cornerFlags, variationNoise, rotationNoise )
	if cornerFlags == 15 then
		local tileCount = table.getn( g_meadowTiles )

		if tileCount == 0 then
			return -1, 0 --error tile
		end

		return g_meadowTiles[variationNoise % tileCount + 1], rotationNoise % 4
	end

	return 0, 0
end
