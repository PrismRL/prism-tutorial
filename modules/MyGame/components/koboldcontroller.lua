--- @class KoboldControllerComponent : ControllerComponent
--- @field blackboard table|nil
--- @overload fun(): KoboldControllerComponent
--- @type KoboldControllerComponent
local KoboldController = prism.components.Controller:extend("KoboldController")
KoboldController.name = "KoboldController"

---@param level Level
---@param actor Actor
---@return Action
function KoboldController:act(level, actor)
   local senses = actor:getComponent(prism.components.Senses)
   local player = senses.actors:getActorByType(prism.actors.Player)
   if not player then return prism.actions.Wait() end

   local mover = actor:getComponent(prism.components.Mover)
   local path = level:findPath(actor:getPosition(), player:getPosition(), 1, mover.mask)

   -- If a valid path is found, attempt to move along it.
   if path and path:length() > 0 then
      local move = prism.actions.Move(actor, {path:pop()})
      if move:canPerform(level) then
         return move
      end
   end

   return prism.actions.Wait()
end

return KoboldController
