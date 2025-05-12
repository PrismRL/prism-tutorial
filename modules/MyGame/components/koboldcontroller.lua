--- @class KoboldController : Controller
--- @overload fun(): KoboldController
local KoboldController = prism.components.Controller:extend("KoboldController")
KoboldController.name = "KoboldController"

function KoboldController:act(level, actor)
   local senses = actor:getComponent(prism.components.Senses)
   if not senses then return prism.actions.Wait() end -- we can't see!
   local player = senses:query(prism.components.PlayerController):first()
   if not player then return prism.actions.Wait() end
   local mover = actor:getComponent(prism.components.Mover)
   if not mover then return prism.actions.Wait() end

   local path = level:findPath(actor:getPosition(), player:getPosition(), 1, mover.mask)

   if path then
      local move = prism.actions.Move(actor, path:pop())
      if move:canPerform(level) then
         return move
      end
   end

   return prism.actions.Wait()
end

return KoboldController