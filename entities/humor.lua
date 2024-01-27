-- humor
humor=entity:extend({
	size=0,
	max_size=50,
	type=0,
	pool={},
	
	update=function(_ENV)
		if (size==0) then
			note=make_note(rnd(63),type,7,0)	-- pitch,instrument,vol,effect
			set_note(0,1,note)
			set_speed(0,10)
			sfx(0)
		end
		size+=1
		if size > max_size then
			destroy(_ENV)
		end
	end,
	
	draw=function(_ENV)
		circ(x+3,y+3,size,type)
	end,
})