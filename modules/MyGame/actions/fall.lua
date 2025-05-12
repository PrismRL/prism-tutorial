--- @class Fall : Action
local Fall = prism.Action:extend "Fall"

--- @param level Level
function Fall:_canPerform(level)
   local x, y = self.owner:getPosition():decompose()
   local cell = level:getCell(x, y)

   -- We can only fall on cells that are voids.
   if not cell:hasComponent(prism.components.Void) then return false end

   local cellMask = cell:getCollisionMask()
   local mover = self.owner:getComponent(prism.components.Mover)
   local mask = mover and mover.mask or 0 -- default to the immovable mask

   -- We have a Void component on the cell. If the actor CAN'T move here
   -- then they fall.
   return not prism.Collision.checkBitmaskOverlap(cellMask, mask)
 end

--- @param level Level
function Fall:_perform(level)
   level:removeActor(self.owner) -- into the depths with you!
end

return Fall