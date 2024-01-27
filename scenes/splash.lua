--splash screen

splash_scene=scene:extend({
	init=function(_ENV)

	end,

	update=function(_ENV)
		entity:each("update")
	
		-- press button or auto go after 3 seconds to title screen
		if (t()-scene.start_time) > 3 or btnp(❎) then
			scene:load(title_scene)
		end
	end,

	draw=function()
		-- draw entities
		entity:each("draw")
		draw_sickhouse(44,20)
		printc("presents",80,7)
	end,
})