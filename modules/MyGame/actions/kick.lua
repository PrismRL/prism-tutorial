--- @class KickTarget : Target
local KickTarget = prism.Target:extend("KickTarget")

--- @param owner Actor
---@param actor any
---@param targets any[]
function KickTarget:validate(owner, actor, targets)
   return actor:is(prism.Actor)
      and actor:hasComponent(prism.components.Collider)
      and owner:getRange(actor) == 1
end

---@class KickAction : Action
local Kick = prism.Action:extend("KickAction")
Kick.name = "Kick"
Kick.targets = { KickTarget }
Kick.requiredComponents = {
   prism.components.Controller
}

function Kick:_canPerform(level)
   return true
end

--- @param level Level
--- @param kicked Actor
function Kick:_perform(level, kicked)
   print "YA"
   local direction = (kicked:getPosition() - self.owner:getPosition())

   local mask = prism.Collision.createBitmaskFromMovetypes{ "fly" }

   local nextpos = kicked:getPosition()
   for _ = 1, 3 do
      nextpos = nextpos + direction
      if level:getCellPassable(nextpos.x, nextpos.y, mask) then
         level:moveActor(kicked, nextpos)
      else
         break
      end
   end
end

return Kick