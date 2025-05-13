---@class Die : Action
local Die = prism.Action:extend("Die")

function Die:_perform(level)
   level:removeActor(self.owner)
end

return Die