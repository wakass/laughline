-- person
person=entity:extend({
	x=60,
	y=60,
	w=7,
	h=5,
	humor_type=1,
	energy=50,
	energy_move_costs=.1,
	energy_humor_costs=5,
	sprite_counter=0,
	dx=0,
	dy=0,
	
	update_energy=function(_ENV)
		-- give a little bit of energy
		energy+=.1
		-- take energy to move
		if dx!=0 or dy !=0 then
			energy-=energy_move_costs
		end
		-- limit energy to min and max
		energy=mid(0,energy,100)
	end,
		
	update=function(_ENV)
	
		update_energy(_ENV)
		
		dx,dy=0,0

		if (btn(⬆️)) dy-=1
		if (btn(⬇️)) dy+=1
		if (btn(⬅️)) dx-=1
		if (btn(➡️)) dx+=1

		if dx!=0 or dy !=0 then
			if energy > energy_move_costs then
				-- normalize movement
				local a=atan2(dx,dy)
				x+=cos(a)
				y+=sin(a)

				sprite_counter+=1
				if sprite_counter>2 then
					sprite_counter=0
				end
				-- spawn dust each 3/10 sec
				--if (t()*10)\1%3==0 then
				--	dust({
				--		x=x+rnd(3),
				--		y=y+4,
				--		frames=18+rnd(4),
				--	})
				--end
			end
		end
		
		-- place humor
		if (btnp(4)) then 
			if energy > energy_humor_costs then
				humor({
					x=x,
					y=y,
					type=humor_type,
					orig_id=id
				})
				energy-=energy_humor_costs
			end
		end
		
		-- select humor_type
		if (btnp(5)) then 
			humor_type+=1
			if (humor_type > n_humor_types) then
				humor_type = 1
			end
		end
		
		
		-- restrict movement
		x=mid(7,x,114)
		y=mid(15,y,116)
	end,

	draw=function(_ENV)
		--prints("😐",x,y,humor_type)

		circfill(x+3,y+3,5,humor_type+8)
		spr(1+((humor_type-1)*16)+sprite_counter,x-1,y-1)
		circ(x+3,y+3,5,0)
		
		local energy_x=2
		local energy_y=120
		local energy_w=123
		local energy_h=5
		rectfill(energy_x,energy_y,energy_x+energy_w,energy_y+energy_h,5)
		rectfill(energy_x,energy_y,energy_x+(energy_w*(energy/100)),energy_y+energy_h,6)
		for i=1,n_humor_types do
			rectfill(energy_x+(i*25),energy_y,energy_x+(i*25),energy_y+energy_h,8+i)	
		end
		rect(energy_x,energy_y,energy_x+energy_w,energy_y+energy_h,7)

	end,
})

