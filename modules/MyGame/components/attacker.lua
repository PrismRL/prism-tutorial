--- @class Attacker : Component
local Attacker = prism.Component:extend("Attacker")

function Attacker:__new(damage)
   self.damage = damage
end

return Attacker