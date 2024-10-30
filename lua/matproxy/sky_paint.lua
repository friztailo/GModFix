
--[[
    https://github.com/Facepunch/garrysmod/pull/2107

    Improvement sky_paint matproxy
    Significant reduction in garbage creation
]]--

local meta = FindMetaTable( "Entity" )

local GetDTVector = meta.GetDTVector
local GetDTFloat = meta.GetDTFloat
local GetDTBool = meta.GetDTBool
local GetDTInt = meta.GetDTInt
local GetDTAngle = meta.GetDTAngle
local GetDTString = meta.GetDTString

matproxy.Add( {
	name = "SkyPaint",

	init = function( self, mat, values )
	end,

	bind = function( self, mat, ent )

		local skyPaint = g_SkyPaint
		if ( not IsValid( skyPaint ) ) then return end

		mat:SetVector( "$TOPCOLOR", GetDTVector( skyPaint, 0 ) )
		mat:SetVector( "$BOTTOMCOLOR", GetDTVector( skyPaint, 1 ) )
		mat:SetVector( "$DUSKCOLOR", GetDTVector( skyPaint, 4 ) )
		mat:SetFloat( "$DUSKSCALE", GetDTFloat( skyPaint, 2 ) )
		mat:SetFloat( "$DUSKINTENSITY", GetDTFloat( skyPaint, 3 ) )
		mat:SetFloat( "$FADEBIAS", GetDTFloat( skyPaint, 0 ) )
		mat:SetFloat( "$HDRSCALE", GetDTFloat( skyPaint, 1 ) )

		mat:SetVector( "$SUNNORMAL", GetDTVector( skyPaint, 2 ) )
		mat:SetVector( "$SUNCOLOR", GetDTVector( skyPaint, 3 ) )
		mat:SetFloat( "$SUNSIZE", GetDTFloat( skyPaint, 4 ) )

		if ( not GetDTBool( skyPaint, 0 ) ) then
			return mat:SetInt( "$STARLAYERS", 0 )
		end

		mat:SetInt( "$STARLAYERS", GetDTInt( skyPaint, 0 ) )

		local star = GetDTAngle( skyPaint, 0 )
		mat:SetFloat( "$STARSCALE", star.p )
		mat:SetFloat( "$STARFADE", star.y )
		mat:SetFloat( "$STARPOS", star.r * RealTime() )

		mat:SetTexture( "$STARTEXTURE",	GetDTString( skyPaint, 0 ) )

	end
} )