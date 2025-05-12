--- @class Fall : Action
local Fall = prism.Action:extend "Fall"

local flyMask = prism.Collision.createBitmaskFromMovetypes({"fly"})
--- @param level Level
function Fall:_canPerform(level)
   local x, y = self.owner:getPosition():decompose()
   local cellMask = level:getCell(x, y):getCollisionMask()
   local mover = self.owner:getComponent(prism.components.Mover)
   local mask = mover and mover.mask or 0 -- default to the immovable mask

   local isCellFlying = prism.Collision.checkBitmaskOverlap(flyMask, cellMask)
   local canActorMoveHere = prism.Collision.checkBitmaskOverlap(cellMask, mask)
   return isCellFlying and not canActorMoveHere
 end

--- @param level Level
function Fall:_perform(level)
   level:removeActor(self.owner) -- into the depths with you!
end

return Fall