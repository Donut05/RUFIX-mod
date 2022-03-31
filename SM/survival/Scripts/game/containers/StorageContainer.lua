dofile "$SURVIVAL_DATA/Scripts/game/survival_items.lua"

StorageContainer = class()
StorageContainer.maxChildCount = 255

local ContainerSize = 5

function StorageContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container = self.shape:getInteractable():addContainer( 0, ContainerSize, self.data.stackSize )
	end
	if self.data.filterUid then
		local filters = { sm.uuid.new( self.data.filterUid ) }
		container:setFilters( filters )
	end
end

function StorageContainer.client_onCreate( self )
	self.gui = sm.gui.createContainerGui()
	self.gui:setText( "UpperName", "#{CONTAINER_TITLE_GENERIC}" )
	self.poseCounter = 0
end

function StorageContainer.client_canCarry( self )
	local container = self.shape.interactable:getContainer( 0 )
	if container and sm.exists( container ) then
		return not container:isEmpty()
	end
	return false
end

function StorageContainer.client_onInteract( self, character, state )
	if state == true then
		local container = self.shape.interactable:getContainer( 0 )
		if container then
			local shapeUuid = self.shape:getShapeUuid()
			if shapeUuid == obj_interactive_locker then
				self.gui:setText( "UpperName", "#{CHEST_TITLE_LOCKER}" )
			elseif shapeUuid == obj_interactive_filecabinet then
				self.gui:setText( "UpperName", "#{CHEST_TITLE_CABINET}" )
			elseif shapeUuid == obj_spaceship_microwave then
				self.gui:setText( "UpperName", "#{CHEST_TITLE_MICROWAVE}" )
			elseif shapeUuid == obj_survivalobject_ruinchest then
				self.gui:setText( "UpperName", "#{CHEST_TITLE_RUINDUMPSTER}" )
			end

			self.gui:setContainer( "UpperGrid", container )
			self.gui:setText( "LowerName", "#{INVENTORY_TITLE}" )
			self.gui:setContainer( "LowerGrid", sm.localPlayer.getInventory() )
			self.gui:open()
		end
	end
end

function StorageContainer.client_onUpdate( self, dt )
	local shapeUUID = self.shape:getShapeUuid()
	if shapeUUID == obj_interactive_filecabinet or shapeUUID == obj_survivalobject_ruinchest then
		if self.gui:isActive() then
			self.poseCounter = sm.util.clamp(self.poseCounter + dt*5, 0, 1)
		else
			self.poseCounter = sm.util.clamp(self.poseCounter - dt*5, 0, 1)
		end

		self.interactable:setPoseWeight( 0, self.poseCounter )
	end
end

function StorageContainer.client_onDestroy( self )
	self.gui:close()
end

--CLASSES
LockerContainer = class( StorageContainer )

CabinetContainer = class( StorageContainer )
CabinetContainer.poseWeightCount = 1

MicrowaveContainer = class( StorageContainer )

RuinContainer = class( StorageContainer )
RuinContainer.poseWeightCount = 1

--Storage functionalty
function LockerContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 4, 65535 )
	end
end

function CabinetContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 3, 65535 )
	end
end

function MicrowaveContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 1, 65535 )
	end
end

function RuinContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 6, 65535 )
	end
end