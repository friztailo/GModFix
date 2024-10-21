local functions = {}

local CLIENT, SERVER = CLIENT, SERVER

do
    local pMeta = FindMetaTable( "Player" )

    local FrameNumber = FrameNumber
    local TraceEndpos = Vector()
    local TraceConfig = { endpos = TraceEndpos }

    --[[
        Improvement util.GetPlayerTrace()
    ]]--

    function util.GetPlayerTrace(ply, direction)
        local startpos = ply:EyePos()

        direction = direction and Vector( direction ) or ply:GetAimVector()
        direction:Mul( 32768 )
        direction:Add( startpos )

        return {
            start = startpos,
            endpos = direction,
            filter = ply,
        }
    end

    --[[
        Improvement util.QuickTrace()
    ]]--

    function util.QuickTrace( origin, direction, filter )
        TraceConfig.start = origin
        TraceConfig.filter = filter
        TraceConfig.output = nil

        TraceEndpos:Set( origin )
        TraceEndpos:Add( direction )

        return util.TraceLine( TraceConfig )
    end

    --[[
        Improvement Player:GetEyeTrace()
    ]]--

    function pMeta:GetEyeTrace()
        local tbl = self:GetTable()

        if CLIENT then
            local Frame = FrameNumber()
            if ( Frame == tbl.LastPlayerTrace ) then
                tbl.LastPlayerTrace = Frame
                return tbl.PlayerTrace
            end

            local startpos = self:EyePos()
            TraceConfig.start = startpos
            TraceConfig.filter = self

            TraceEndpos:Set( self:GetAimVector() )
            TraceEndpos:Mul( 32768 )
            TraceEndpos:Add( startpos )

            -- Very effective solution how to get rid of creating TraceResult tables.
            -- But in some cases it can cause problems. It is stated in README.
            TraceConfig.output = tbl.PlayerTrace

            local PlayerTrace = util.TraceLine( TraceConfig )
            tbl.PlayerTrace = PlayerTrace
            return PlayerTrace
        end

        local startpos = self:EyePos()
        TraceConfig.start = startpos
        TraceConfig.filter = self

        TraceEndpos:Set( self:GetAimVector() )
        TraceEndpos:Mul( 32768 )
        TraceEndpos:Add( startpos )

        return util.TraceLine( TraceConfig )
    end

    --[[
        Improvement Player:GetEyeTraceNoCursor()
    ]]--

    function pMeta:GetEyeTraceNoCursor()
        local tbl = self:GetTable()

        if CLIENT then
            local Frame = FrameNumber()
            if ( Frame == tbl.LastPlayerAimTrace ) then
                tbl.LastPlayerAimTrace = Frame
                return tbl.PlayerAimTrace
            end

            local startpos = self:EyePos()
            TraceConfig.start = startpos
            TraceConfig.filter = self

            TraceEndpos:Set( self:EyeAngles():Forward() )
            TraceEndpos:Mul( 32768 )
            TraceEndpos:Add( startpos )

            -- Very effective solution how to get rid of creating TraceResult tables.
            -- But in some cases it can cause problems. It is stated in README.
            TraceConfig.output = tbl.PlayerAimTrace

            local PlayerAimTrace = util.TraceLine( TraceConfig )
            tbl.PlayerAimTrace = PlayerAimTrace
            return PlayerAimTrace
        end

        local startpos = self:EyePos()
        TraceConfig.start = startpos
        TraceConfig.filter = self

        TraceEndpos:Set( self:EyeAngles():Forward() )
        TraceEndpos:Mul( 32768 )
        TraceEndpos:Add( startpos )

        return util.TraceLine( TraceConfig )
    end
end

if CLIENT then
    --[[
        Detour of wiremod fix ENT:BeingLookedAtByLocalPlayer
    ]]--

    functions[#functions + 1] = function()
        local scripted_ent = scripted_ents.GetStored("base_wire_entity")
        if scripted_ent == nil then return end
        local ENT = scripted_ent.t

        hook.Remove("Think", "wire_base_lookedatbylocalplayer")

        local wire_drawoutline = GetConVar("wire_drawoutline")
        function ENT:DoNormalDraw(nohalo, notip)
            local looked_at = self:BeingLookedAtByLocalPlayer()
            if not looked_at then return self:DrawModel() end

            if not nohalo and wire_drawoutline:GetBool() then
                self:DrawEntityOutline()
            end

            self:DrawModel()

            if not notip then
                self:AddWorldTip()
            end
        end
    end
end

do
    if GAMEMODE then
        for index = 1, #functions do functions[index]() end
    else
        hook.Add( "PostGamemodeLoaded", string.format( "%p", {} ), function()
            for index = 1, #functions do functions[index]() end
        end )
    end
end