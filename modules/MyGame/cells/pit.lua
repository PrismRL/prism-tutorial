---@class PitCell : Cell
local Pit = prism.Cell:extend("PitCell")
Pit.name = "Pit"

function Pit:initialize()
  return {
    prism.components.Drawable(string.byte(" ") + 1, prism.Color4.BLACK, prism.Color4.BLACK),
    prism.components.Collider({ allowedMovetypes = { "fly" }})
  }
end

return Pit
