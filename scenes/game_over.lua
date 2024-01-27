game_over_scene=scene:extend({
	init=function(_ENV)
		sfx(2)
	end,
	
	update=function(_ENV)
		if btnp(❎) then
			scene:load(title_scene)
		end
		
		if (t()-scene.start_time) > 3 then
			scene:load(credits_scene)
		end
	end,

	draw=function(_ENV)
		print_title("times up!",32,7)
		printc("❎ play again",96,7)
	end
})