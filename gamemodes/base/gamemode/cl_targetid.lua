
--[[
    Improvement GM:HUDDrawTargetID
]]--

local alpha_120 = Color( 0, 0, 0, 120 )
local alpha_50 = Color( 0, 0, 0, 50 )

--[[---------------------------------------------------------
   Name: gamemode:HUDDrawTargetID( )
   Desc: Draw the target id (the name of the player you're currently looking at)
-----------------------------------------------------------]]
function GM:HUDDrawTargetID()

	local trace = LocalPlayer():GetEyeTrace()
	if ( not trace.Hit or not trace.HitNonWorld ) then return end

    local entity = trace.Entity
	if ( not entity:IsPlayer() ) then return end

    local text = entity:Nick()
	local font = "TargetID"

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	local MouseX, MouseY = input.GetCursorPos()
	if ( (MouseX == 0 and MouseY == 0) or not vgui.CursorVisible() ) then
		MouseX, MouseY = ScrW() / 2, ScrH() / 2
	end

	local x, y = MouseX - w / 2, MouseY + 30
    local color = self:GetTeamColor( entity )

	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( text, font, x + 1, y + 1, alpha_120 )
	draw.SimpleText( text, font, x + 2, y + 2, alpha_50 )
	draw.SimpleText( text, font, x, y, color )

	y = y + h + 5

	-- Draw the health
	text = string.format( "%i%%", entity:Health() )
	font = "TargetIDSmall"

	surface.SetFont( font )
	x = MouseX - surface.GetTextSize( text ) / 2

	draw.SimpleText( text, font, x + 1, y + 1, alpha_120 )
	draw.SimpleText( text, font, x + 2, y + 2, alpha_50 )
	draw.SimpleText( text, font, x, y, color )

end