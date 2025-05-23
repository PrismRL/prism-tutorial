--- @class Kobold : Actor
local Kobold = prism.Actor:extend("Kobold")
Kobold.name = "Kobold"

function Kobold:initialize()
   return {
      prism.components.Drawable(string.byte("k") + 1, prism.Color4.RED),
      prism.components.Collider(),
      prism.components.Senses(),
      prism.components.Sight { range = 12, fov = true },
      prism.components.Mover { "walk" },
      prism.components.KoboldController(),
   }
end

return Kobold
