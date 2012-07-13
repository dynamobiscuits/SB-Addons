

ENT.Type 			= "anim"
ENT.Base 			= "base_rd_entity"

ENT.PrintName		= "Nitrous Oxide Thruster"
ENT.Author			= "Syncaidius"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

function ENT:GetOverlayText()
	local force = self:NetGetForce()
	local nitrous = self:GetNetworkedInt(8)
	local txt = (self.PrintName).."\nForce: " 
	if (self:IsOn()) then
		txt = txt .. ( force * self:NetGetMul() )
	else
		txt = txt .. "off"
	end
	txt = txt .. "\nMul: " ..force
	txt = txt .. "\nNitrous Oxide: "..(nitrous)
	
	if (not SinglePlayer()) then
		local PlayerName = self:GetPlayerName()
		txt = txt .. "\n(" .. PlayerName .. ")"
	end
	if(name and name ~= "") then
	    if (txt == "") then
	        return "- "..name.." -"
	    end
	    return "- "..name.." -\n"..txt
	end
	return txt
end

function ENT:SetEffect( name )
	self:SetNetworkedString( "Effect", name )
end
function ENT:GetEffect( name )
	return self:GetNetworkedString( "Effect" )
end

function ENT:SetOn( boolon )
	self:SetNetworkedBool( "On", boolon, true )
end
function ENT:IsOn( name )
	return self:GetNetworkedBool( "On" )
end

function ENT:SetOffset( v )
	self:SetNetworkedVector( "Offset", v, true )
end
function ENT:GetOffset( name )
	return self:GetNetworkedVector( "Offset" )
end

function ENT:NetSetForce( force )
	self:SetNetworkedInt(4, math.floor(force*100))
end
function ENT:NetGetForce()
	return self:GetNetworkedInt(4)/100
end

local Limit = .1
local LastTime = 0
local LastTimeA = 0
function ENT:NetSetMul( mul )
	if (CurTime() < LastTimeA + .05) then
		LastTimeA = CurTime()
		return
	end
	LastTimeA = CurTime()
	
	if (CurTime() > LastTime + Limit) then
		self:SetNetworkedInt(5, math.floor(mul*100))
		LastTime = CurTime()
	end
end

function ENT:NetGetMul()
	return self:GetNetworkedInt(5)/100
end