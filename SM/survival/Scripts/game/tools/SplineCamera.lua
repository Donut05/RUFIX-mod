
dofile "$SURVIVAL_DATA/Scripts/game/survival_shapes.lua"
dofile "$SURVIVAL_DATA/Scripts/util.lua"
dofile "$SURVIVAL_DATA/Scripts/game/survival_constants.lua"

SplineCamera = class()

function SplineCamera.client_onCreate( self )
	self.cl = {}
	self.cl.playbackMode = false
	self.cl.recordedNodes = {}
	self.cl.resetTicks = 0
end

function SplineCamera.client_onUpdate( self, dt )
	if self.tool:isLocal() then
		
		--Håll vänsterklick för att resetta utplacerade noder
		--Högerklick för att växla till uppspelningsläge
		--Q för att placera en nod
		--R för att spara utplacerade noder till "$SURVIVAL_DATA/Scripts/game/tools/camera.json"
		
		-----------------------------
		-----TILL-TRAILER-FOLKET-----
		-----------------------------
		local cameraDirectionLerpSpeed = 0.167 	-- Hur hårt kameran följer sin direction räls, 0.0 så bryr den sig inte alls / 1.0 så följer den rälsen exakt
		local cameraPositionLerpSpeed = 1.0 	-- Hur hårt kameran följer sin position räls, 0.0 så bryr den sig inte alls / 1.0 så följer den rälsen exakt
		local playbackSpeed = 2.0 				-- Kamera rälsens hastighet i m/s
		local playbackFOV = 70.0 				-- Kamerans FOV vid uppspelning
		-----------------------------
		-----------------------------
		-----------------------------
		
		
		
		
		
		
		
		-----------------------------
		-------HERE-BE-DRAGONS-------
		--vVvVvVvVvVvVvVvVvVvVvVvVv--
		local debugPrefix = "cameraTool"
		sm.debugDraw.clear( debugPrefix )
		local stepLength = dt * playbackSpeed
		local points = {}
		local distances = {}
		local viewPoints = {}
		local viewDistances = {}
		for i, node in ipairs( self.cl.recordedNodes ) do
			points[#points+1] = node.position
			viewPoints[#viewPoints+1] = node.viewPosition
			sm.debugDraw.addSphere( debugPrefix..""..self.tool.id.."node"..i, node.position )
			sm.debugDraw.addSphere( debugPrefix..""..self.tool.id.."nodeV"..i, node.viewPosition )
		end
		
		-- Extract points and distances from the node
		if points and #points > 1 and viewPoints and #viewPoints > 1 then
			-- Used for spline calculation
			distances[1] = 0
			for i = 2, #points do
				distances[i] = distances[i - 1] + ( points[i] - points[i - 1] ):length()
			end
			viewDistances[1] = 0
			for i = 2, #viewPoints do
				viewDistances[i] = viewDistances[i - 1] + ( viewPoints[i] - viewPoints[i - 1] ):length()
			end
		end
		
		if #points > 1 and #viewPoints > 1 then
			-- Playback
			if self.cl.playbackMode then
				
				-- First frame special start
				local firstFrame = false
				if not self.cl.targetPosition or not self.cl.segmentLength or not self.cl.timeInSegment or not self.cl.progress then
					local closest = closestPointInLines( points, points[1] )
					self.cl.targetPosition = closest.pt
					self.cl.segmentLength = closest.len
					self.cl.timeInSegment = 0
					self.cl.progress = closest.i + closest.t
					firstFrame = true
				end
			
				-- Spline follow update
				local step = stepLength / self.cl.segmentLength
				if math.floor( self.cl.progress + step ) ~= math.floor( self.cl.progress ) then -- Next segment
					local i0 = math.floor( self.cl.progress + step )
					local rest = ( self.cl.progress + step - i0 ) * self.cl.segmentLength

					if i0 < #points then
						local i1 = i0 + 1
						self.cl.segmentLength = ( points[i1] - points[i0] ):length()
						self.cl.timeInSegment = rest / playbackSpeed
						self.cl.progress = i0 + rest / self.cl.segmentLength
						local offset = sm.vec3.new( 0, 0, 0.1 )
					else -- Arrived
						self.cl.segmentLength = 1
						self.cl.timeInSegment = 0
						self.cl.progress = i0
					end
				else -- Standard progress
					self.cl.progress = self.cl.progress + step
				end
				
				if self.cl.progress then
					-- Set camera position
					local camPos = spline( points, self.cl.progress, distances )
					if firstFrame then
						sm.camera.setPosition( camPos )
					else
						sm.camera.setPosition( magicPositionInterpolation( sm.camera.getPosition(), camPos, dt, cameraPositionLerpSpeed  ) )
					end
		
					-- Set camera direction
					local viewPos = spline( viewPoints, self.cl.progress, viewDistances )
					if ( viewPos - camPos ):length() >= FLT_EPSILON then
						local camDir = ( viewPos - camPos ):normalize()
						
						if firstFrame then
							sm.camera.setDirection( camDir )
						else
							sm.camera.setDirection( magicPositionInterpolation( sm.camera.getDirection(), camDir, dt, cameraDirectionLerpSpeed  ) )
						end
					end
					
					-- Set camera FOV
					self.tool:updateFpCamera( playbackFOV, sm.vec3.new( 0.0, 0.0, 0.0 ), 1, 0 )
				end
			else
				self.tool:updateFpCamera( sm.camera.getFov(), sm.vec3.new( 0.0, 0.0, 0.0 ), 0, 0 )
			end
			
			-- Debug splines
			for p = 1, #points - 0.1, 0.1 do
				local pt0 = spline( points, p, distances )
				local pt1 = spline( points, p + 0.1, distances )
				sm.debugDraw.addArrow( debugPrefix..""..self.tool.id.."_p"..p, pt0, pt1, sm.color.new( "00ff80" ) )
			end
			for p = 1, #viewPoints - 0.1, 0.1 do
				local pt0 = spline( viewPoints, p, viewDistances )
				local pt1 = spline( viewPoints, p + 0.1, viewDistances )
				sm.debugDraw.addArrow( debugPrefix..""..self.tool.id.."_pV"..p, pt0, pt1, sm.color.new( "ffff80" ) )
			end
			
		end
		
	end
end

function SplineCamera.client_onEquip( self ) end

function SplineCamera.client_onUnequip( self ) end

function SplineCamera.client_onToggle( self ) 
	sm.gui.displayAlertText( "Placed Node", 1.5 )
	local node = {}
	node.position = sm.camera.getPosition()
	node.viewPosition = node.position + sm.camera.getDirection()
	
	self.cl.recordedNodes[#self.cl.recordedNodes+1] = node
	return true
end

function SplineCamera.client_onReload( self )
	if #self.cl.recordedNodes > 0 then
		local jsonNodes = {}
		for _, node in ipairs( self.cl.recordedNodes ) do
			jsonNodes[#jsonNodes+1] = 	
			{ 
				pos = { x = node.position.x, y = node.position.y, z = node.position.z },
				view = { x = node.viewPosition.x, y = node.viewPosition.y, z = node.viewPosition.z } 
			}
		end
		sm.json.save( jsonNodes, "$SURVIVAL_DATA/Scripts/game/tools/camera.json" )
		print(jsonNodes)
		sm.gui.displayAlertText( "Saved nodes in $SURVIVAL_DATA/Scripts/game/tools/camera.json", 5.0 )
	else
		self.cl.recordedNodes = {}
		local jsonNodes = sm.json.open( "$SURVIVAL_DATA/Scripts/game/tools/camera.json" )
		for _, jNode in ipairs( jsonNodes ) do
			self.cl.recordedNodes[#self.cl.recordedNodes+1] = { position = sm.vec3.new( jNode.pos.x, jNode.pos.y, jNode.pos.z ), viewPosition = sm.vec3.new( jNode.view.x, jNode.view.y, jNode.view.z ) }
		end
		print(self.cl.recordedNodes)
		sm.gui.displayAlertText( "Loaded nodes from $SURVIVAL_DATA/Scripts/game/tools/camera.json", 5.0 )
	end
	return true
end

function SplineCamera.client_onEquippedUpdate( self, primaryState, secondaryState )
	
	local resetTickTime = 40 * 3.0 + 1
	if primaryState == sm.tool.interactState.start then
		if #self.cl.recordedNodes > 0 then
			self.cl.resetTicks = 1
		else
			sm.gui.displayAlertText( "No nodes to reset.", 1.5 )
		end
	elseif primaryState == sm.tool.interactState.hold and self.cl.resetTicks > 0 then
		self.cl.resetTicks = self.cl.resetTicks + 1
		sm.gui.displayAlertText( "Resetting nodes: "..((math.floor(( resetTickTime - self.cl.resetTicks ) * 0.25 ))/10).."s", 1.0 )
	elseif primaryState == sm.tool.interactState.stop then
		self.cl.resetTicks = 0
	end
	
	if self.cl.resetTicks > resetTickTime then
		-- Reset nodes
		print( self.cl.recordedNodes )
		self.cl.playbackMode = false
		self.cl.recordedNodes = {}
		self.cl.resetTicks = 0
		sm.gui.displayAlertText( "Nodes have been reset!", 5.0 )
	end
	
	if secondaryState == sm.tool.interactState.start then
		self.cl.playbackMode = not self.cl.playbackMode
		
		self.cl.targetPosition = nil
		self.cl.segmentLength = nil
		self.cl.timeInSegment = nil
		self.cl.progress = nil
		
		if self.cl.playbackMode then
			sm.gui.hideGui( true )
			sm.camera.setCameraState( sm.camera.state.cutsceneFP )
			sm.camera.setCameraPullback( 0, 0 )
		else
			sm.gui.hideGui( false )
			sm.camera.setCameraState( sm.camera.state.default )
		end
	end
	return true, true
	
end