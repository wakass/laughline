--Frame sensitivity for humors
n_forget_frames = 30

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
	seen_humors = {}, --humors seen

	update=function(_ENV)
		-- decay humor level over time
		humor_level-=humor_decay
		
		-- increase humor level of touched by humor
		if true then
			humor_level+=humor_sensitivity
		end
		
		-- trigger humor
		-- if humor_level >= humor_treshold then
		-- 	humor({
		-- 		x=x,
		-- 		y=y,
		-- 		type=humor_type+8,
		-- 		max_size=rnd(20)+30,
		-- 	})
		-- 	humor_level = 0
		-- end	

		prune_seen_humors(_ENV) -- Remove any seen humours that have xpired
	end,
	
	--Detect if within other humor 
	--not own humor!
	--If still within same bubble humor as before should also not trigger

		-- Loop over placed humors, 
		-- Check circle diameter and orign
		-- If coordinates of certain city in circle, city is hit
		-- Feed-forward event to city
		-- humor:each
		-- city:each("detect")

	detect=function(_ENV, success_fun)
		for h in all(humor.pool) do
			-- Calculate distance between city and initiated humor,
			-- distance should 
			x0 = {x=h.x,y=h.y}
			x1 = {x=x, y=y}

			d = sqrt((x1.x-x0.x)^2 + (x1.y-x0.y)^2)
			if (d < h.size and h.orig_id != id) then
				if (process_seen(_ENV, h) == -1) then
					printh("Didnt see it yet" .. h.id)

					-- trigger humor
					humor({
						x=x,
						y=y,
						type=humor_type+8,
						max_size=rnd(20)+30,
						orig_id=id
					})
				else
					-- Ignore already seen humor
					-- printh("Already saw humor".. h.id)
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
		rectfill(x+2,y+2,x+4,y+3,humor_type+8)		
		print("⌂",x,y,1)
		--print(humor_level,x,y,7)
	end
})