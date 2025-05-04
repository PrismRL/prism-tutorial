if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
   require("lldebugger").start()
end

if os.getenv "LOCAL_LUA_DEBUGGER_VSCODE" == "1" then
   local lldebugger = require "lldebugger"
   lldebugger.start()
   local run = love.run
   --- @diagnostic disable-next-line
   function love.run(...)
       local f = lldebugger.call(run, false, ...)
       return function(...) return lldebugger.call(f, false, ...) end
   end
end

require "prism"

prism.loadModule("prism/spectrum")
prism.loadModule("modules/Sight")
prism.loadModule("modules/MyGame")

-- build a basic test map
local mapbuilder = prism.MapBuilder(prism.cells.Wall())
mapbuilder:drawRectangle(0, 0, 16, 16, prism.cells.Wall())
mapbuilder:drawRectangle(1, 1, 15, 15, prism.cells.Floor())
mapbuilder:drawRectangle(2, 2, 4, 4, prism.cells.Wall())
mapbuilder:drawRectangle(1, 6, 15, 9, prism.cells.Pit())
mapbuilder:drawRectangle(7, 6, 8, 9, prism.cells.Floor())
mapbuilder:drawRectangle(10, 11, 14, 14, prism.cells.Wall())
mapbuilder:drawRectangle(11, 12, 13, 13, prism.cells.Floor())
mapbuilder:set(10, 12, prism.cells.Floor())
mapbuilder:addActor(prism.actors.Kobold(), 13, 12)

-- create and add the player
mapbuilder:addActor(prism.actors.Player(), 6, 4)

-- bake the map down
local map, actors = mapbuilder:build()

-- initialize the level
local sensesSystem = prism.systems.Senses()
local sightSystem = prism.systems.Sight()
local level = prism.Level(map, actors, { sensesSystem, sightSystem })

-- spin up our state machine
local manager = spectrum.StateManager()

-- Grab our level state and sprite atlas.
local MyGameLevelState = require "gamestates.MyGamelevelstate"
love.graphics.setDefaultFilter("nearest", "nearest")
local spriteAtlas = spectrum.SpriteAtlas.fromGrid("display/wanderlust_16x16.png", 16, 16)
local display = spectrum.Display(spriteAtlas, prism.Vector2(16, 16), level)

-- we put out levelstate on top here, but you could create a main menu
--- @diagnostic disable-next-line
function love.load()
   manager:hook()
   manager:push(MyGameLevelState(level, display))
end
