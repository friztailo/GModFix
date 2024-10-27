## GModFix
You'll have to take my word for it that it will improve the damn game. 🦷

## Сhanges List
- Improved Ray-Tracing functions ( Player:GetEyeTrace(), Player:GetEyeTraceNoCursor(), etc. )
- Improved ENT:BeingLookedAtByLocalPlayer base_gmodentity ( automatic replace wiremod fix )
- Improved sky_paint matproxy ( significant reduction in garbage creation )
- Improved GM:HUDDrawTargetID ( using Player:GetEyeTrace() and minor changes )

## About Player:GetEyeTrace() and Player:GetEyeTraceNoCursor()
For best performance of these functions I use previous tables to prevent creating new ones. But this can cause conflict in some cases. 

If this happens, just remove the line that forces the use of the previous table `TraceConfig.output = ...`. 
