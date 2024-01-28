--Frame sensitivity for humors
n_forget_frames = 300

-- city
city=entity:extend({
	w=5,
	h=5,
	pool={},
	humor_type=1,
	humor_level=0,
	humor_treshold=1,
	humor_sensitivity={},
	humor_level_per_type={0,0,0,0},
	humor_decay=0,
	seen_humors = {}, --humors seen
	
	init=function(_ENV)
		entity.init(_ENV)
		humor_level_per_type={0,0,0,0}
	end,

	update=function(_ENV)
		-- decay humor level over time
		humor_level-=humor_decay
		
		-- increase humor level of touched by humor
		-- if true then
		-- 	humor_level+=humor_sensitivity
		-- end
		
		-- Find total humor level and possible trigger
		-- Make a squares weight for humor level
		local level = 0 
		for i,l in ipairs(humor_level_per_type) do
			level += l^2
		end
		humor_level = sqrt(level)
		
		-- More likely to emit humor it likes
		likelihoods = {}
		for i,n in ipairs(humor_sensitivity) do
			l = n*rnd()
			-- printh(l)
			add(likelihoods, l)
		end

		local max_index = 0
		local max_value = 0
		for idx,val in ipairs(likelihoods) do
			if (val > max_value) then
				max_value = val
				max_index = idx
			end
		end

		emit_humor_type = idx
		-- printh("city id :" .. id .. "h: ".. k .. "level:" .. humor_level_per_type[3])
		
		if humor_level >= humor_treshold then
			humor({
				x=x,
				y=y,
				type=emit_humor_type,
				max_size=rnd(20)+30,
			})
			humor_level = 0
		end	

		prune_seen_humors(_ENV) -- Remove any seen humours that have xpired
	end,
	
	process_incoming_humor=function(_ENV, h, distance) 
		-- the humor that hit is weighted by sensitivity and distance/2
		printh("Process humor type: ".. h.type .. "city id: " .. id)
		assert(h.type >0)
		if (flr(h.type) > n_humor_types) then 
			printh("BUG!: ".. h.type)
			return --bug fix
		end
		humor_level_per_type[h.type] += humor_sensitivity[h.type]/distance^2
		
	end,

	detect=function(_ENV)
		for h in all(humor.pool) do
			-- Calculate distance between city and initiated humor,
			-- distance should 
			x0 = {x=h.x,y=h.y}
			x1 = {x=x, y=y}

			d = sqrt((x1.x-x0.x)^2 + (x1.y-x0.y)^2)
			if (d < h.size and h.orig_id != id) then
				if (process_seen(_ENV, h) == -1) then
					-- Humor not seen yet, processing..
					process_incoming_humor(_ENV, h, d)
				else
					-- Ignore already seen humor
				end
			end
		end
	end,
	
	-- checks if humor is seen already, 
	process_seen=function(_ENV, h_check)
		local seen_index = -1
		local j, n = 1, #seen_humors;

		for i=1,n do
			h_seen = seen_humors[i]
			-- if humors is seen, reduce framecount
			if h_check.id == h_seen.id then
				h_seen.frame -= 1
				seen_index = i
				break
			end
		end
		if seen_index == -1 then
			add(seen_humors,{id=h_check.id,frame=n_forget_frames})
		end

		return seen_index
	end,

	prune_seen_humors=function(_ENV)
		-- Check for expired framecounts
		for s in all(seen_humors) do
			if s.frame == 0 then
				del(seen_humors,s)
			end
		end
	end,

	

	draw=function(_ENV)
		rectfill(x+2, y+2, x+4, y+3, humor_type+8)		
		print("⌂", x, y, 1)

		print("h:" .. humor_level,x-6,y-6,1)
		
		
		--- Draw humor level viz
		fullscale = 8 -- fullscale pixels for humor level
		x_offset = 8
		y_offset = 8
		height_max = 8
		width_bar = 1
		width_max = n_humor_types*width_bar
		width_border = 1

		-- offset right, humor level per type
		-- draw black bg 
		rectfill(x + x_offset - width_border,
				 y + y_offset + width_border,
				x + x_offset + width_max  + width_border*2,
				y + y_offset - height_max + width_border*2,
			0)

		for i,v in ipairs(humor_level_per_type) do
			rectfill(x + x_offset +width_bar*(i-1),
					y + y_offset,
					x + x_offset + width_bar*i,
					y + y_offset- height_max*v, 
					i+8)
		end
		--- Draw overall humor level
		  rectfill(x + x_offset + width_border,
					y + y_offset +10,
					x + x_offset + flr(width_max*humor_level),
					y + y_offset +10 - width_border*2, 
					9)

		-- offset left, humor sensitivity per type
		-- draw black bg 
		rectfill(x - x_offset - width_border,
				 y + y_offset + width_border,
				x - x_offset + width_max + width_border*2,
				y + y_offset - height_max + width_border*2,
			0)

		for i,v in ipairs(humor_sensitivity) do
			rectfill(x - x_offset +width_bar*(i-1), --lua sucks
					y + y_offset,
					x - x_offset + width_bar*i,
					y + y_offset - height_max*v, 
					i+8)
		end

		

		-- print(humor_level_per_type,0,0)
		--print(humor_level,x,y,7)
	end
})