--- @class Kobold : Actor
local Kobold = prism.Actor:extend("Kobold")
Kobold.name = "Kobold"

function Kobold:initialize()
   return {
      prism.components.Drawable(string.byte("k") + 1, prism.Color4.RED),
      prism.components.Collider(),
      prism.components.Senses(),
      prism.components.Sight{ range = 12, fov = true },
      prism.components.Mover{ "walk" },
      prism.components.KoboldController(),
      prism.components.Health(3),
      prism.components.Attacker(1),
   }
end

return Kobold