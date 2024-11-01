
--[[
    https://github.com/Facepunch/garrysmod/pull/2107

    Improvement sky_paint matproxy
    Significant reduction in garbage creation
]]--

--[[
	if you don't give a fuck about sky, use this and it will take you to heaven!!!!!!!
	vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

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
				mat:SetFloat( "$STARPOS", star[3] * RealTime() )

				mat:SetTexture( "$STARTEXTURE", skyPaint:GetDTString( 0 ) )
			else
				mat:SetInt( "$STARLAYERS", 0 )
			end

			self.bind = nil

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

		local SetVector = mat.SetVector
		local SetFloat = mat.SetFloat
		local SetInt = mat.SetInt
		local SetTexture = mat.SetTexture

		self.bind = function( self, mat, ent )

			SetVector( mat, "$TOPCOLOR", skyPaint:GetDTVector( 0 ) )
			SetVector( mat, "$BOTTOMCOLOR", skyPaint:GetDTVector( 1 ) )
			SetVector( mat, "$DUSKCOLOR", skyPaint:GetDTVector( 4 ) )
			SetFloat( mat, "$DUSKSCALE", skyPaint:GetDTFloat( 2 ) )
			SetFloat( mat, "$DUSKINTENSITY", skyPaint:GetDTFloat( 3 ) )
			SetFloat( mat, "$FADEBIAS", skyPaint:GetDTFloat( 0 ) )
			SetFloat( mat, "$HDRSCALE", skyPaint:GetDTFloat( 1 ) )

			SetVector( mat, "$SUNNORMAL", skyPaint:GetDTVector( 2 ) )
			SetVector( mat, "$SUNCOLOR", skyPaint:GetDTVector( 3 ) )
			SetFloat( mat, "$SUNSIZE", skyPaint:GetDTFloat( 4 ) )

			if ( skyPaint:GetDTBool( 0 ) ) then
				SetInt( mat, "$STARLAYERS", skyPaint:GetDTInt( 0 ) )

				local star = skyPaint:GetDTAngle( 0 )
				SetFloat( mat, "$STARSCALE", star[1] )
				SetFloat( mat, "$STARFADE", star[2] )
				SetFloat( mat, "$STARPOS", star[3] * RealTime() )
	
				SetTexture( mat, "$STARTEXTURE", skyPaint:GetDTString( 0 ) )
			else
				SetInt( mat, "$STARLAYERS", 0 )
			end

		end

	end
} )