--[[
GGJ game main 
]]--

-- config
time_limit=100
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
	cls(2)
	
	-- scene
	scene.current:draw()

	-- ui
	rect(4,12,123,123,13)
	prints("score:"..pad(score.."00",8),4,4,7)
	prints("level:"..level,65,4,7)
	prints("time:"..pad(ceil(timer/30),2),97,4,7)
end

