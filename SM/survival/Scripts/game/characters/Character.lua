-- Character.lua --

Character = class( nil )

--[[ Callbacks ]]

function Character.client_onCreate( self ) end

-- Callback when character is destroyed
function Character.client_onDestroy( self ) end

-- Callback when script is updated
function Character.client_onRefresh( self ) end

-- Callback when character is updated
function Character.client_onUpdate( self, deltaTime ) end

function Character.client_onEvent( self, event ) end