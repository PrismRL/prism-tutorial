--- @class LoseCondition : System
local LoseCondition = prism.System:extend "LoseCondition"


function LoseCondition:afterAction(level, actor, action)
   if not actor:hasComponent(prism.components.PlayerController) then return end
   if not action:is(prism.actions.Die) then return end

   -- It's the player and they're dying. Time to send a message.
   level:yield(prism.messages.GameOver())
end

return LoseCondition