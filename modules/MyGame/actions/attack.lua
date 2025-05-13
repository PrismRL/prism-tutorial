local AttackTarget = prism.Target:extend("AttackTarget")

--- @param owner Actor
--- @param targetObject any
function AttackTarget:validate(owner, targetObject)
   return 
      targetObject:is(prism.Actor) and
      targetObject:getComponent(prism.components.Health) and
      owner:getRange(targetObject) == 1
end

---@class Attack : Action
local Attack = prism.Action:extend("Attack")
Attack.name = "attack"
Attack.targets = { AttackTarget }
Attack.requiredComponents = {
      prism.components.Controller,
      prism.components.Attacker
}

--- @param level Level
--- @param target Actor
function Attack:_perform(level, target)
   local health = target:expectComponent(prism.components.Health)
   local attacker = self.owner:expectComponent(prism.components.Attacker)
   health.hp = health.hp - attacker.damage

   if health.hp <= 0 then
      level:performAction(prism.actions.Die(target))
   end
end

return Attack