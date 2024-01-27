credits_scene=scene:extend({
	init=function(_ENV)

	end,

	update=function(_ENV)
		if (t()-scene.start_time) > 30 or btnp(❎) then
			scene:load(title_scene)
		end
	end,

	draw=function(_ENV)
		print_title("made by",32,7)
		printc("design: sickhouse team", 50,7)
		printc("art: sickhouse team", 60,7)
		printc("music: sickhouse team", 70,7)
		printc("programming: sickhouse team", 80,7)
		
		printc("❎ play again",96,7)
		
		draw_foo(10, 20, 2, 3)	
	end
})