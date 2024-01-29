--Frame sensitivity for humors
n_forget_frames = 300
n_humor_rate_max= 0.5 --rate per second

-- city
city=entity:extend({
	w=5,
	h=5,
	pool={},
	humor_type=1,
	humor_level=0,
	humor_treshold=1,
	humor_sensitivity={},
	seen_humors = {}, --humors seen
	
	init=function(_ENV)
		entity.init(_ENV)
		humor_level_per_type={0,0,0,0}
		seen_humors={}
		humor_level=0
		last_emitted_time=0
		max_timer=0
	end,

	update=function(_ENV)
		prune_seen_humors(_ENV) -- Remove any seen humours that have xpired

		max_timer = max(0,max_timer-1)

		-- decay humor level over time
		for i,l in ipairs(humor_level_per_type) do
			humor_level_per_type[i] -= humor_decay
			if humor_level_per_type[i] <0 then
				humor_level_per_type[i]=0
			end
		end
		
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
			add(likelihoods, l)
		end

		k,v = max_table(likelihoods, function(a,b) return a < b end)

		emit_humor_type = k
		if humor_level >= humor_treshold then
			-- printh("Got triggered, emitting from id: " .. id)
			-- printh(humor_level)
			if (max_timer == 0) then
				max_timer = n_humor_rate_max*30
				humor({
					x=x,
					y=y,
					type=emit_humor_type,
					max_size=rnd(20)+30,
					orig_id=id
				})
			end
		end	

	end,
	
	process_incoming_humor=function(_ENV, h, distance) 
		-- the humor that hit is weighted by sensitivity and distance/2
		assert(h.type >0)
		if (flr(h.type) > n_humor_types) then 
			printh("BUG!: ".. h.type)
			return --bug fix
		end
		humor_level_per_type[h.type] += humor_sensitivity[h.type]--/distance^1.5
		
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
					-- printh("Triggering h -- In city ".. id.. " Humor orig_id:" .. h.orig_id .. " humor id: " .. h.id)
					process_incoming_humor(_ENV, h, d)
				else
					-- printh("Ignoring h -- In city ".. id.. " Humor orig_id:" .. h.orig_id .. " humor id: " .. h.id)
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
			-- if humors is seen
			if h_check.id == h_seen.id then
				seen_index = i
				break
			end
		end
		if seen_index == -1 then
			-- printh("New humor added to seen id: " .. h_check.id)
			add(seen_humors,{id=h_check.id,frame=n_forget_frames})
		end

		return seen_index
	end,

	prune_seen_humors=function(_ENV)
		-- Decrease seen humor and check for expired framecounts
		for s in all(seen_humors) do
			s.frame -= 1
			if s.frame == 0 then
				printh("City id: "..id.. " Seen humor id: " .. s.id .. "removed, reason: Expired")
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