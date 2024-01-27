-- person
person=entity:extend({
	x=60,
	y=60,
	w=7,
	h=5,
	humor_type=8,

	dx=0,
	dy=0,

	update=function(_ENV)
		dx,dy=0,0

		if (btn(⬆️)) dy-=1
		if (btn(⬇️)) dy+=1
		if (btn(⬅️)) dx-=1
		if (btn(➡️)) dx+=1
		

		if dx!=0 or dy !=0 then
			-- normalize movement
			local a=atan2(dx,dy)
			x+=cos(a)
			y+=sin(a)

			-- spawn dust each 3/10 sec
			if (t()*10)\1%3==0 then
				dust({
					x=x+rnd(3),
					y=y+4,
					frames=18+rnd(4),
				})
			end
		end
		
		-- place humor
		if (btnp(4)) then 
			humor({
				x=x,
				y=y,
				type=humor_type,
			})
		end
		
		-- select humor_type
		if (btnp(5)) then 
			humor_type+=1
			if (humor_type>=8+n_humor_types) then
				humor_type = 8
			end
		end
		
		
		-- restrict movement
		x=mid(7,x,114)
		y=mid(15,y,116)
	end,

	draw=function(_ENV)
		prints("😐",x,y,humor_type)
		
	end,
})

