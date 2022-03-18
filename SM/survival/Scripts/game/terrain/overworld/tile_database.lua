
----------------------------------------------------------------------------------------------------
-- Tile database
----------------------------------------------------------------------------------------------------

local g_idToTilePath = {}

function addTile( id, tileName )
	local path = g_idToTilePath[id]
	if path == nil then
		path = tileName
		g_idToTilePath[id] = path
	end
	return id
end

function getTile( id )
	return g_idToTilePath[id]
end

function addPoiTile( type, variation, tileName )
	return addTile( type * 100 + variation, tileName )
end

function getPoiId( type, variation )
	return type * 100 + variation
end

function getPoiType( id )
	local poiType = math.floor( id / 100 )
	if poiType < 10000 then
		return poiType
	end
	return nil
end
