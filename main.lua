--[[
GGJ game main 
]]--

-- config
time_limit=999
n_humor_types=4
n_cities=4

-- globals
score=0
timer=0
level=1


printh("Hello and welcome..to zombo.com")

-- game loop
function _init()
	scene:load(splash_scene)
end

function _update()
	scene.current:update()
end

function _draw()
	-- background
	cls()
	
	-- scene
	scene.current:draw()

	-- ui
	rect(0,0,127,127,13)
	prints("score:"..pad(score,6),4,4,7)
	prints("level:"..level,59,4,7)
	prints("time:"..pad(ceil(timer/30),3),93,4,7)
end

