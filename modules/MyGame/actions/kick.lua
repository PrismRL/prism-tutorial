--- @class KickTarget : Target
local KickTarget = prism.Target:extend("KickTarget")

function KickTarget:validate(owner, actor, targets)
   ---@cast actor Actor
   return actor:is(prism.Actor)
      and actor:hasComponent(prism.components.Collider)
      and owner:getRange(actor) == 1
end

--- @class KickAction : Action
local Kick = prism.Action:extend("KickAction")
Kick.name = "move"
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
   local direction = (kicked:getPosition() - self.owner:getPosition())

   -- our movetype mask for the kick, we'll give them the 'fly' movetype
   local mask = prism.Collision.createBitmaskFromMovetypes{ "fly" }

   local nextpos = kicked:getPosition()
   local finalpos = nextpos
   for _ = 1, 3 do
      nextpos = finalpos + direction
      if level:getCellPassable(nextpos.x, nextpos.y, mask) then
         finalpos = nextpos
      else
         break
      end
   end
   level:moveActor(kicked, finalpos)
end

return Kick
