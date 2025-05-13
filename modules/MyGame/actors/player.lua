--- @class Player : Actor
local Player = prism.Actor:extend "PlayerActor"

function Player:initialize()
   return {
      prism.components.Drawable("@", prism.Color4.GREEN),
      prism.components.Collider(),
      prism.components.PlayerController(),
      prism.components.Senses(),
      prism.components.Sight { range = 64, fov = true },
      prism.components.Mover{ "walk" },
      prism.components.Health(10),
      prism.components.Attacker(1)
   }
end

return Player
