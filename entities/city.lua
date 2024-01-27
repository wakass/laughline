-- city
city=entity:extend({
	w=5,
	h=5,
	pool={},
	humor_type=0,
	humor_level=0,
	humor_treshold=100,
	humor_sensitivity=10,
	humor_decay=0,

	update=function(_ENV)
		-- decay humor level over time
		humor_level-=humor_decay
		
		-- increase humor level of touched by humor
		if true then
			humor_level+=humor_sensitivity
		end
		
		-- trigger humor
		if humor_level >= humor_treshold then
			humor({
				x=x,
				y=y,
				type=humor_type+8,
				max_size=rnd(20)+30,
			})
			humor_level = 0
		end	
	end,
	
	--Detect if within other humor 
	--not own humor!
	--If still within same bubble humor as before should also not trigger
	detect=function(_ENV, success_fun)
		for h in all(humor.pool) do
			printh("" ..h.x)
		end
	end,

	draw=function(_ENV)
		rectfill(x+2,y+2,x+4,y+3,humor_type+8)		
		print("⌂",x,y,1)
		--print(humor_level,x,y,7)
	end
})