dofile("$SURVIVAL_DATA/Scripts/game/survival_constants.lua")

-- Client side
ClientEffectManager = class( nil )

function ClientEffectManager.onCreate( self )
	self.effectCells = {}
end

function ClientEffectManager.onCellLoaded( self, x, y )
	--print("--- placing effects on cell " .. x .. ":" .. y .. " ---")
	local nodes = sm.cell.getNodesByTags( x, y, { "EFFECT", "~FIRE" } )
	--print(#nodes)
	if #nodes > 0 then
		self.effectCells[CellKey( x, y )] = {}
		for _,node in ipairs( nodes ) do
			local effect = sm.effect.createEffect( node.params.effect.name )
			effect:setPosition( node.position )
			effect:setRotation( node.rotation )
			effect:setScale( node.scale )
			if node.params.effect.params  then
				for k,v in kvpairs(node.params.effect.params) do
					effect:setParameter(k, v)
				end
			end
			local effectNode =
			{
				effect = effect,
				timeOfDay = node.params.effect.timeOfDay
			}

			--effect:start()
			table.insert( self.effectCells[CellKey( x, y )], effectNode )
		end
	end
end

function ClientEffectManager.onCellUnloaded( self, x, y )
	--print("--- removing effects on cell " .. x .. ":" .. y .. " ---")
	local effects = self.effectCells[CellKey( x, y )]
	if effects then
		for _, effectNode in ipairs( effects ) do
			effectNode.effect:destroy()
		end
	end
	self.effectCells[CellKey( x, y )] = nil
end

function ClientEffectManager.onFixedUpdate( self )

	local t = sm.render.getOutdoorLighting() -- value between 0 and 1
	for _, effects in pairs( self.effectCells ) do
		for _, effectNode in ipairs( effects ) do

			local effect = effectNode.effect
			local timeOfDay = effectNode.timeOfDay

			if timeOfDay then
				local min = timeOfDay[1]
				local max = timeOfDay[2]
				local inverse = timeOfDay[3]

				local s = t >= min and t <= max
				if inverse then
					s = not s
				end

				if s then
					if not effectNode.effect:isPlaying() then
						effectNode.effect:start()
					end
				else
					if effectNode.effect:isPlaying() then
						effectNode.effect:stop()
					end
				end
			else
				if not effectNode.effect:isPlaying() then
					effectNode.effect:start()
				end
			end
		end
	end
end
