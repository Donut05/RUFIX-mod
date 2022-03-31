--StorageContainer.lua--

dofile "$SURVIVAL_DATA/Scripts/game/survival_items.lua"

StorageContainer = class( nil )
StorageContainer.maxChildCount = 255

local ContainerSize = 5
local gui

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
			gui = nil
			
			local shapeUuid = self.shape:getShapeUuid()
			
			if shapeUuid == obj_interactive_locker then
				gui = sm.gui.createContainerGui( true )
				gui:setText( "UpperName", "#{CHEST_TITLE_LOCKER}" )
				
			elseif shapeUuid == obj_interactive_filecabinet then
				gui = sm.gui.createContainerGui( true )
				gui:setText( "UpperName", "#{CHEST_TITLE_CABINET}" )
				gui:setOnCloseCallback("gui_close")
				self.interactable:setPoseWeight( 0, 1 )
				
			elseif shapeUuid == obj_spaceship_microwave then
				gui = sm.gui.createContainerGui( true )
				gui:setText( "UpperName", "#{CHEST_TITLE_MICROWAVE}" )
				
			elseif shapeUuid == obj_survivalobject_ruinchest then
				gui = sm.gui.createContainerGui( true )
				gui:setText( "UpperName", "#{CHEST_TITLE_RUINDUMPSTER}" )
				gui:setOnCloseCallback("gui_close")
				self.interactable:setPoseWeight( 0, 1 )
				
			end
			
			if gui == nil then
				gui = sm.gui.createContainerGui( true )
				gui:setText( "UpperName", "#{CONTAINER_TITLE_GENERIC}" )
			end
			
			gui:setContainer( "UpperGrid", container )
			gui:setText( "LowerName", "#{INVENTORY_TITLE}" )
			gui:setContainer( "LowerGrid", sm.localPlayer.getInventory() )
			self.guiOpened = true
			gui:open()
		end
	end	
end

function StorageContainer:gui_close()
	self.guiOpened = false
	self.interactable:setPoseWeight( 0, -1 )
end

function StorageContainer.client_onUpdate( self, dt )
	
end

function StorageContainer.client_onDestroy( self )
	gui:close()
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
		container =	self.shape:getInteractable():addContainer( 0, 4, 65535 )
	end
end