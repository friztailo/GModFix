
--[[
	If you want to bring back sky editing use this
	vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	local meta = FindMetaTable( "Entity" )

	local GetDTVector = meta.GetDTVector
	local GetDTFloat = meta.GetDTFloat
	local GetDTBool = meta.GetDTBool
	local GetDTInt = meta.GetDTInt
	local GetDTAngle = meta.GetDTAngle
	local GetDTString = meta.GetDTString

	meta = FindMetaTable( "IMaterial" )

	local SetVector = meta.SetVector
	local SetFloat = meta.SetFloat
	local SetInt = meta.SetInt
	local SetTexture = meta.SetTexture

	matproxy.Add( {
		name = "SkyPaint",

		init = function( self, mat, values )
		end,

		bind = function( self, mat, ent )

			local skyPaint = g_SkyPaint
			if not IsValid( skyPaint ) then return end

			SetVector( mat, "$TOPCOLOR", GetDTVector( skyPaint, 0 ) )
			SetVector( mat, "$BOTTOMCOLOR", GetDTVector( skyPaint, 1 ) )
			SetVector( mat, "$DUSKCOLOR", GetDTVector( skyPaint, 4 ) )
			SetFloat( mat, "$DUSKSCALE", GetDTFloat( skyPaint, 2 ) )
			SetFloat( mat, "$DUSKINTENSITY", GetDTFloat( skyPaint, 3 ) )
			SetFloat( mat, "$FADEBIAS", GetDTFloat( skyPaint, 0 ) )
			SetFloat( mat, "$HDRSCALE", GetDTFloat( skyPaint, 1 ) )

			SetVector( mat, "$SUNNORMAL", GetDTVector( skyPaint, 2 ) )
			SetVector( mat, "$SUNCOLOR", GetDTVector( skyPaint, 3 ) )
			SetFloat( mat, "$SUNSIZE", GetDTFloat( skyPaint, 4 ) )

			if GetDTBool( skyPaint, 0 ) then
				SetInt( mat, "$STARLAYERS", GetDTInt( skyPaint, 0 ) )

				local star = GetDTAngle( skyPaint, 0 )
				SetFloat( mat, "$STARSCALE", star[1] )
				SetFloat( mat, "$STARFADE", star[2] )
				SetFloat( mat, "$STARPOS", star[3] * RealTime() )

				SetTexture( mat, "$STARTEXTURE",	GetDTString( skyPaint, 0 ) )
			else
				SetInt( mat, "$STARLAYERS", 0 )
			end

		end
	} )
]]--

matproxy.Add( {
	name = "SkyPaint",

	init = function( self, mat, values )
	end,

	bind = function( self, mat, ent )

		local skyPaint = g_SkyPaint
		if not IsValid( skyPaint ) then return end

		mat:SetVector( "$TOPCOLOR", skyPaint:GetDTVector( 0 ) )
		mat:SetVector( "$BOTTOMCOLOR", skyPaint:GetDTVector( 1 ) )
		mat:SetVector( "$DUSKCOLOR", skyPaint:GetDTVector( 4 ) )
		mat:SetFloat( "$DUSKSCALE", skyPaint:GetDTFloat( 2 ) )
		mat:SetFloat( "$DUSKINTENSITY", skyPaint:GetDTFloat( 3 ) )
		mat:SetFloat( "$FADEBIAS", skyPaint:GetDTFloat( 0 ) )
		mat:SetFloat( "$HDRSCALE", skyPaint:GetDTFloat( 1 ) )

		mat:SetVector( "$SUNNORMAL", skyPaint:GetDTVector( 2 ) )
		mat:SetVector( "$SUNCOLOR", skyPaint:GetDTVector( 3 ) )
		mat:SetFloat( "$SUNSIZE", skyPaint:GetDTFloat( 4 ) )

		if ( skyPaint:GetDTBool( 0 ) ) then
			mat:SetInt( "$STARLAYERS", skyPaint:GetDTInt( 0 ) )

			local star = skyPaint:GetDTAngle( 0 )
			mat:SetFloat( "$STARSCALE", star[1] )
			mat:SetFloat( "$STARFADE", star[2] )

			local STARPOS = star[3]
			mat:SetFloat( "$STARPOS", STARPOS * RealTime() )

			mat:SetTexture( "$STARTEXTURE", skyPaint:GetDTString( 0 ) )

			self.bind = function( self, mat, ent )

				local skyPaint = g_SkyPaint
				if not IsValid( skyPaint ) then return end
	
				mat:SetFloat( "$STARPOS", STARPOS * RealTime() )

			end
		else
			mat:SetInt( "$STARLAYERS", 0 )

			self.bind = nil
		end

	end
} )