--- @class FallSystem : System
local FallSystem = prism.System:extend "FallSystem"


--- @param level Level
--- @param actor Actor
function FallSystem:onMove(level, actor)
   local fall = prism.actions.Fall(actor)

   if fall:canPerform(level) then
      level:performAction(fall)
   end
end

return FallSystem