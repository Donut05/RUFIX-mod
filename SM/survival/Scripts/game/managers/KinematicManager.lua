dofile "$SURVIVAL_DATA/Scripts/game/survival_constants.lua"
dofile("$SURVIVAL_DATA/Scripts/util.lua")

KinematicManager = class( nil )

function KinematicManager.sv_onWorldCellLoaded( self, worldSelf, x, y )
	local cellKey = CellKey( x, y )
	local spawnedKinematics = self:sv_createKinematicsOnCell( x, y, sm.cell.getTags( x, y ) )
	local storage = { kinematics = spawnedKinematics }
	sm.storage.save( { STORAGE_CHANNEL_KINEMATIC_MANAGER, worldSelf.world.id, cellKey }, storage )
end

function KinematicManager.sv_onWorldCellReloaded( self, worldSelf, x, y )
	local cellKey = CellKey( x, y )
	local storage = sm.storage.load( { STORAGE_CHANNEL_KINEMATIC_MANAGER, worldSelf.world.id, cellKey } )
	if storage and storage.kinematics then
		for _, hvs in ipairs( storage.kinematics ) do
			if sm.exists( hvs ) then
				hvs:destroy()
			end
		end
	end

	local spawnedKinematics = self:sv_createKinematicsOnCell( x, y, sm.cell.getTags( x, y ) )
	storage = { kinematics = spawnedKinematics }
	sm.storage.save( { STORAGE_CHANNEL_KINEMATIC_MANAGER, worldSelf.world.id, cellKey }, storage )
end

function KinematicManager.sv_createKinematicsOnCell( self, x, y, tags )
	local kinematicSpawnNodes = sm.cell.getNodesByTag( x, y, "KINEMATIC_SPAWN" )
	local kinematicButtonNodes = sm.cell.getNodesByTag( x, y, "KINEMATIC_BUTTON" )
	local kinematicTransformNodes = sm.cell.getNodesByTag( x, y, "KINEMATIC_TRANSFORM" )
	local spawnedKinematics = {}
	local taggedKinematics = {}
	local usedConnectionIds = {}

	-- Create a lookup table for connected nodes
	local nodesByConnectionId = {}
	for _, transformNode in ipairs( kinematicTransformNodes ) do
		if transformNode.params and transformNode.params.connections then
			nodesByConnectionId[transformNode.params.connections.id] = transformNode
		end
	end
	for _, spawnNode in ipairs( kinematicSpawnNodes ) do
		if spawnNode.params and spawnNode.params.connections then
			nodesByConnectionId[spawnNode.params.connections.id] = spawnNode
		end
	end

	-- Setup kinematics from nodes
	for _, spawnNode in ipairs( kinematicSpawnNodes ) do
		if spawnNode.params and spawnNode.params.kinematic then
			local nodes = {}
			if spawnNode.params.connections then
				-- Traverse and save all connected kinematic transforms as spline nodes
				local currentConnectionId = spawnNode.params.connections.id
				while currentConnectionId do
					local currentNode = nodesByConnectionId[currentConnectionId]
					local savedNode = { position = currentNode.position, rotation = currentNode.rotation, time = 0.0 }
					if currentNode.params.time then
						savedNode.time = currentNode.params.time
					end
					nodes[#nodes+1] = savedNode
					usedConnectionIds[currentConnectionId] = true
					currentConnectionId = nil
					for _, nextId in pairs( currentNode.params.connections.otherIds ) do
						if not usedConnectionIds[nextId] then
							currentConnectionId = nextId
							break
						end
					end
				end
			else
				-- No connections, setup self as a spline node
				local savedNode = { position = spawnNode.position, rotation = spawnNode.rotation, time = 0.0 }
				if spawnNode.params.time then
					savedNode.time = spawnNode.params.time
				end
				nodes[#nodes+1] = savedNode
			end
			-- Spawn the kinematic with spline nodes as params
			local harvestable = sm.harvestable.create( spawnNode.params.kinematic.uuid, spawnNode.position, spawnNode.rotation )
			harvestable:setParams( { nodes = nodes } )
			spawnedKinematics[#spawnedKinematics+1] = harvestable

			-- Make it possible to lookup the spawned kinematic based on its activation tag
			if spawnNode.params.activationTag then
				if taggedKinematics[spawnNode.params.activationTag] == nil then
					taggedKinematics[spawnNode.params.activationTag] = {}
				end
				taggedKinematics[spawnNode.params.activationTag][#taggedKinematics[spawnNode.params.activationTag]+1] = harvestable
			end
		end
	end

	-- Setup activation buttons from nodes
	for _, buttonNode in ipairs( kinematicButtonNodes ) do
		if buttonNode.params and buttonNode.params.kinematic then
			-- Spawn the button and insert kinematics with the same activation tag as params
			local harvestable = sm.harvestable.create( buttonNode.params.kinematic.uuid, buttonNode.position, buttonNode.rotation )
			if buttonNode.params.activationTag then
				harvestable:setParams( { kinematics = taggedKinematics[buttonNode.params.activationTag] } )
			end
			spawnedKinematics[#spawnedKinematics+1] = harvestable
		end
	end
	return spawnedKinematics
end