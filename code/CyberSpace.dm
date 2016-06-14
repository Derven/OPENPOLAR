//True-holodeck. V2.0
/obj/effect/landmark/SP

/area/cyber_space
	icon_state = "Holodeck"
	luminosity = 1
	requires_power = 0
	var/holo = 0 //Real?
	Enter(stupid, hisloc)
		if (!holo) //WTF
			if (!istype(stupid, /mob/dead/observer))
				del(stupid)
				return 0
		if (!istype(stupid, /mob/living/carbon/human/avatar) || !istype(stupid, /mob/dead/observer))
			stupid << "\blue You can't do that shit, bro, you can't."
			return 0
		return 1

	New()
		..()
		if (type == "/area/cyber_space")
			del(src) //Abstract class simulation.

/area/cyber_space/place
	var/obj/structure/stool/bed/holo_bed/isTakenBy = null
	var/mob/living/carbon/human/avatar/owner = null

	proc/process()
		if (isTakenBy && owner && owner in src)
			spawn(1)	.()
			return
		//Something wrong
		disappear()

	proc/disappear()
		if (owner)
			owner.death()
		for (var/atom/A in src)
			if (!istype(A, /area))
				del(A) //Everything except area.
		isTakenBy = null
		owner = null

	proc/appear(var/test, var/obj/structure/stool/bed/holo_bed/user, var/mob/living/toSend)
		disappear()
		var/area/cyber_space/chosen
		switch(test)
			if ("Enginnering")
				for (var/area/cyber_space/eng/E in world)
					if (!E.holo) //Do not take zones, that using already.
						chosen = E
			if ("Medicine")
				for (var/area/cyber_space/med/E in world)
					if (!E.holo)
						chosen = E
			if ("Chemistry")
				for (var/area/cyber_space/chem/E in world)
					if (!E.holo)
						chosen = E
			if ("Solar")
				for (var/area/cyber_space/solar/E in world)
					if (!E.holo)
						chosen = E
			if ("Singularity")
				for (var/area/cyber_space/sing/E in world)
					if (!E.holo)
						chosen = E
			if ("Bar")
				for (var/area/cyber_space/bar/E in world)
					if (!E.holo)
						chosen = E
			if ("Virology")
				for (var/area/cyber_space/virus/E in world)
					if (!E.holo)
						chosen = E
		holocopy(chosen, src, 1)
		var/obj/effect/landmark/SP/S = locate(/obj/effect/landmark/SP) in src
		owner = create_avatar(toSend, S)
		isTakenBy = user
		process()
		return owner

/area/cyber_space/med

/area/cyber_space/eng

/area/cyber_space/eng/apc_test
	requires_power = 1
	luminosity = 0

/area/cyber_space/chem

/area/cyber_space/solar

/area/cyber_space/sing

/area/cyber_space/virus

/area/cyber_space/bar

/proc/DOb(var/atom/alpha, var/turf/place)
	if (isturf(place))
		var/atom/beta = new alpha.type(place)
		for(var/V in beta.vars)
			if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key","x","y","z", "contents")))
				beta.vars[V] = alpha.vars[V]
		return beta

/proc/holocopy (var/area/from_area, var/area/to_area, delay)
	var/fmx = world.maxx
	var/fmy = world.maxy
	var/tmx = world.maxx
	var/tmy = world.maxy
	var/fmax = 0
	var/fmay = 0
	var/fz = 0
	var/tz = 0
	for (var/turf/T in from_area)
		if (T.x < fmx)	fmx = T.x
		if (T.y < fmy)	fmy = T.y
		if (T.x > fmax)	fmax = T.x
		if (T.y > fmay)	fmay = T.y
		fz = T.z

	for (var/turf/T in to_area)
		if (T.x < tmx)	tmx = T.x
		if (T.y < tmy)	tmy = T.y
		tz = T.z

	var/x_off = tmx - fmx
	var/y_off = tmy - fmy

	for (var/turf/FT in block(locate(fmx,fmy,fz), locate(fmax,fmay,fz)))
		var/turf/TT = locate(FT.x + x_off, FT.y + y_off, tz) //To_zone Turf
		if (FT && TT) //Sanity
			if ( (FT in from_area) && (TT in to_area) )
				DOb(FT, TT)

	for (var/turf/FT in block(locate(fmx,fmy,fz), locate(fmax,fmay,fz)))
		var/turf/TT = locate(FT.x + x_off, FT.y + y_off, tz) //To_zone Turf
		if (FT && TT) //Sanity
			if ( (FT in from_area) && (TT in to_area) )
				for (var/obj/alpha in FT)
					DOb(alpha, TT)

				for (var/mob/living/alpha in FT)
					DOb(alpha, TT)
		sleep(delay)