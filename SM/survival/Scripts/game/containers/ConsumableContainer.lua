-- ConsumableContainer.lua --

dofile "$SURVIVAL_DATA/Scripts/game/survival_items.lua"

ConsumableContainer = class( nil )
ConsumableContainer.maxChildCount = 255

local ContainerSize = 5

function ConsumableContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container = self.shape:getInteractable():addContainer( 0, ContainerSize, self.data.stackSize )
	end
	if self.data.filterUid then
		local filters = { sm.uuid.new( self.data.filterUid ) }
		container:setFilters( filters )
	end	
end

function ConsumableContainer.client_canCarry( self )
	local container = self.shape.interactable:getContainer( 0 )
	if container and sm.exists( container ) then
		return not container:isEmpty()
	end
	return false
end

function ConsumableContainer.client_onInteract( self, character, state )
	if state == true then
		local container = self.shape.interactable:getContainer( 0 )
		if container then
			self.gui = nil
			
			local shapeUuid = self.shape:getShapeUuid()
			
			if shapeUuid == obj_container_ammo then
				self.gui = sm.gui.createAmmunitionContainerGui( true )
				
			elseif shapeUuid == obj_container_battery then
				self.gui = sm.gui.createBatteryContainerGui( true )
				
			elseif shapeUuid == obj_container_chemical then
				self.gui = sm.gui.createChemicalContainerGui( true )
				
			elseif shapeUuid == obj_container_fertilizer then
				self.gui = sm.gui.createFertilizerContainerGui( true )
				
			elseif shapeUuid == obj_container_gas then
				self.gui = sm.gui.createGasContainerGui( true )
				
			elseif shapeUuid == obj_container_seed then
				self.gui = sm.gui.createSeedContainerGui( true )
				
			elseif shapeUuid == obj_container_water then
				self.gui = sm.gui.createWaterContainerGui( true )
				
			elseif shapeUuid == obj_interactive_fridge then
				self.gui = sm.gui.createContainerGui( true ) --sm.gui.createGuiFromLayout ( "$GAME_DATA/Gui/Layouts/Interactable/Interactable_Chest.layout", true ) rip spaghetti code
				self.gui:setText( "UpperName", "#{CHEST_TITLE_FRIDGE}" )

			end
			
			if self.gui == nil then
				self.gui = sm.gui.createContainerGui( true )
				self.gui:setText( "UpperName", "#{CONTAINER_TITLE_GENERIC}" )
			end
			
			self.gui:setContainer( "UpperGrid", container )
			self.gui:setText( "LowerName", "#{INVENTORY_TITLE}" )
			self.gui:setContainer( "LowerGrid", sm.localPlayer.getInventory() )
			self.gui:open()
		end
	end	
end

function ConsumableContainer.client_onUpdate( self, dt )

	local container = self.shape.interactable:getContainer( 0 )
	if container then
		local quantities = sm.container.quantity( container )
		
		local quantity = 0
		for _,q in ipairs(quantities) do
			quantity = quantity + q
		end

		local frame = ContainerSize - math.ceil( quantity / self.data.stackSize )
		self.interactable:setUvFrameIndex( frame )
	end
end	

SeedContainer = class( ConsumableContainer )

function SeedContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 5, 65535 )
	end
	container:setFilters( sm.item.getPlantableUuids() )
end

function ConsumableContainer.client_onDestroy( self )
	self.gui:close()
end

WaterContainer = class( ConsumableContainer )
WaterContainer.connectionOutput = sm.interactable.connectionType.water
WaterContainer.colorNormal = sm.color.new( 0x84ff32ff )
WaterContainer.colorHighlight = sm.color.new( 0xa7ff4fff )

-- function WaterContainer.server_onProjectile( self, hitPos, hitTime, hitVelocity, projectileName, attacker, damage )
-- 	if projectileName == "water" and ( self.hitTick == nil or self.hitTick <= sm.game.getCurrentTick() - 4 ) then
-- 		local container = self.shape.interactable:getContainer( 0 )
-- 		if sm.container.beginTransaction() then
-- 			sm.container.collect( container, obj_consumable_water, 1, false )
-- 			sm.container.endTransaction()
-- 		end
-- 		self.hitTick = sm.game.getCurrentTick()
-- 	end
-- end

BatteryContainer = class( ConsumableContainer )
BatteryContainer.connectionOutput = sm.interactable.connectionType.electricity
BatteryContainer.colorNormal = sm.color.new( 0x84ff32ff )
BatteryContainer.colorHighlight = sm.color.new( 0xa7ff4fff )

GasolineContainer = class( ConsumableContainer )
GasolineContainer.connectionOutput = sm.interactable.connectionType.gasoline
GasolineContainer.colorNormal = sm.color.new( 0x84ff32ff )
GasolineContainer.colorHighlight = sm.color.new( 0xa7ff4fff )

AmmoContainer = class( ConsumableContainer )
AmmoContainer.connectionOutput = sm.interactable.connectionType.ammo
AmmoContainer.colorNormal = sm.color.new( 0x84ff32ff )
AmmoContainer.colorHighlight = sm.color.new( 0xa7ff4fff )

FoodContainer = class( ConsumableContainer )

local FoodUuids = {
	obj_plantables_banana,
	obj_plantables_blueberry,
	obj_plantables_orange,
	obj_plantables_pineapple,
	obj_plantables_carrot,
	obj_plantables_redbeet,
	obj_plantables_tomato,
	obj_plantables_broccoli,
	obj_plantables_potato,
	obj_consumable_sunshake,
	obj_consumable_carrotburger,
	obj_consumable_pizzaburger,
	obj_consumable_longsandwich,
	obj_consumable_milk,
	obj_resource_steak,
	obj_resource_corn,
}

function FoodContainer.server_onCreate( self )
	local container = self.shape.interactable:getContainer( 0 )
	if not container then
		container =	self.shape:getInteractable():addContainer( 0, 20, 65535 )
	end
	container:setFilters( FoodUuids )
end



FoodContainer.client_onUpdate = nil
