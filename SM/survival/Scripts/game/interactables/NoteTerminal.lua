-- NoteTerminal.lua --
dofile( "$SURVIVAL_DATA/Scripts/game/managers/QuestManager.lua" )

NoteTerminal = class( nil )
NoteTerminal.maxParentCount = 1
NoteTerminal.maxChildCount = 0
NoteTerminal.colorNormal = sm.color.new( 0xdeadbeef )
NoteTerminal.colorHighlight = sm.color.new( 0xdeadbeef )
NoteTerminal.connectionInput = sm.interactable.connectionType.logic
NoteTerminal.connectionOutput = sm.interactable.connectionType.none
NoteTerminal.poseWeightCount = 1

local UnfoldSpeed = 5

-- Client

function NoteTerminal.client_onCreate( self )
	self.cl = {}
	self.cl.unfoldWeight = 0
end

function NoteTerminal.client_canInteract( self )
	local parent = self.interactable:getSingleParent()
	if parent == nil or not parent.active then
		sm.gui.setCenterIcon( "Hit" )
		sm.gui.setInteractionText( "#{INFO_REQUIRES_POWER}" )
	end
	return false
end

function NoteTerminal.server_onFixedUpdate( self, timeStep )
	local parent = self.interactable:getSingleParent()
	if parent and parent.active then
		if Server_isQuestActive( quest_use_terminal ) then
			Server_completeQuest( quest_use_terminal )
			local logbookOffset = sm.vec3.new( 0, -0.375, 0.85 )
			local logbookPosition = self.shape.worldPosition + self.shape.worldRotation * logbookOffset
			sm.harvestable.create( hvs_loot_logbook, logbookPosition, sm.vec3.getRotation( sm.vec3.new( 0, 1, 0 ), sm.vec3.new( 0, 0, 1 ) ) )
		end
	end
end

function NoteTerminal.client_onInteract( self, character, state ) end

function NoteTerminal.client_onUpdate( self, deltaTime )
	local parent = self.interactable:getSingleParent()
	if parent and parent.active then
		if self.cl.unfoldWeight < 1.0 then
			self.cl.unfoldWeight = math.min( self.cl.unfoldWeight + deltaTime * UnfoldSpeed, 1.0 )
			self.interactable:setPoseWeight( 0, self.cl.unfoldWeight )
		end
	else
		if self.cl.unfoldWeight > 0.0 then
			self.cl.unfoldWeight = math.max( self.cl.unfoldWeight - deltaTime * UnfoldSpeed, 0.0 )
			self.interactable:setPoseWeight( 0, self.cl.unfoldWeight )
		end
	end
end