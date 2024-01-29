-- humor
humor=entity:extend({
	size=0,
	max_size=50,
	type=0,
	pool={},
	orig_id=0, --who originated the humor
	muted=false,
	text_px = 0,
	text_py = 0,
	text_id = 0,
	text_fade = 30,

	init=function(_ENV)
		
		entity.init(_ENV)
		-- orig_id=orig_id
		-- printh("Humor create? orig_id:" .. orig_id .. ", id:"..id)
	end,
	
	update=function(_ENV)
		if not muted then
			if (size==0) then
				note=make_note(rnd(63),type,7,0)	-- pitch,instrument,vol,effect
				set_note(0,1,note)
				set_speed(0,10)
				sfx(0)
			end
		end
		
		size+=1
		
		if size > max_size then
			destroy(_ENV)
		end
		
		text_fade = text_fade - 1
		
		if (text_fade < 1) then			
			-- circle diameter is size * 2 + 1
			text_px   = x + flr(rnd(size * 2 + 1)) - size - 1
			text_py   = y + flr(rnd(size * 2 + 1)) - size - 1		
			text_id   = ceil(rnd(4))	
			text_fade = 30
		end
	end,
	
	draw=function(_ENV)
		color = type+8
		circ(x+4,y+4,size,0) -- 'shadow'
		circ(x+3,y+3,size,color)
		

		
		if (text_px < 1) or (text_py < 1) then 
			return 
		end
		
		    if (text_id == 1) then prints("haha", text_px, text_py, color)
		elseif (text_id == 2) then prints("hihi", text_px, text_py, color)
		elseif (text_id == 3) then prints("lol",  text_px, text_py, color)
		elseif (text_id == 4) then prints("kek",  text_px, text_py, color)
		else                       
			printh("humor text_id: " .. text_id)
		end	
	end,
})