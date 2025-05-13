--- @class GameOverState : GameState
--- A custom game level state responsible for initializing the level map,
--- handling input, and drawing the state to the screen.
---
--- @field display Display
--- @overload fun(display: Display): GameOverState
local GameOverState = spectrum.GameState:extend "GameOverState"

function GameOverState:__new(display)
   self.display = display
end

function GameOverState:draw()
   self.display:clear()
   self.display:putString(1, 1, "Game Over!")
   self.display:draw()
end

return GameOverState