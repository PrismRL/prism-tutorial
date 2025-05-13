---@class Pit : Cell
local Pit = prism.Cell:extend("Pit")

function Pit:initialize()
   return {
      prism.components.Drawable(" "),
      prism.components.Collider({ allowedMovetypes = { "fly" }}),
      prism.components.Void()
   }
end

return Pit
