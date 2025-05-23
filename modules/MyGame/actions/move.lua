local PointTarget = prism.Target:extend("PointTarget")

--- @param owner Actor
--- @param targetObject any
function PointTarget:validate(owner, targetObject)
   return targetObject:is(prism.Vector2) and owner:getRangeVec(targetObject) == 1
end

--- @class Move : Action
--- @field name string
--- @field targets Target[]
--- @field previousPosition Vector2
--- @overload fun(owner: Actor, destination: Vector2): Action
local Move = prism.Action:extend("Move")
Move.name = "move"
Move.targets = { PointTarget }

function Move:getRequirements()
   return prism.components.Controller, prism.components.Mover
end

--- @param level Level
--- @param destination Vector2
function Move:canPerform(level, destination)
   local mover = self.owner:expectComponent(prism.components.Mover)
   return level:getCellPassable(destination.x, destination.y, mover.mask)
end

--- @param level Level
--- @param destination Vector2
function Move:perform(level, destination)
   level:moveActor(self.owner, destination)
end

return Move
