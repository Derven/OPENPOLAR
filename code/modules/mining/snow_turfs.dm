
/**********************Snow**************************/

/turf/simulated/snowwall //wall piece
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "gravsnow"
	oxygen = 0
	nitrogen = 0
	opacity = 0
	density = 1
	blocks_air = 1
	temperature = T0C-27

/turf/simulated/snowwall/Del()
	return

/turf/simulated/snowwall/New()
//	var/proper_name = name
	..()
	name = "snow"
//	if(prob(20))
	icon_state = "snow"
	//	icon_state = "snow[rand(0,12)]"


/turf/simulated/snowwal/ex_act(severity)
	switch(severity)
		if(1.0)
			src.ChangeTurf(/turf/simulated/floor/plating/airless/asteroid)
		if(2.0)
			src.ChangeTurf(/turf/simulated/floor/plating/airless/asteroid)
		if(3.0)
			src.ChangeTurf(/turf/simulated/floor/plating/airless/asteroid)
	return

/turf/simulated/snowwall/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if(!W || !user)
		return 0

	if ((istype(W, /obj/item/weapon/shovel)))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		user << "\red You start digging."
		playsound(src.loc, 'sound/effects/rustle1.ogg', 50, 1) //russle sounds sounded better

		sleep(40)
		if ((user.loc == T && user.get_active_hand() == W))
			user << "\blue You removed some snow."
			src.ChangeTurf(/turf/simulated/floor/plating/airless/asteroid)
			var/turf/simulated/floor/plating/airless/asteroid/L = ChangeTurf(/turf/simulated/floor/plating/airless/asteroid)
			L.fullUpdateMineralOverlays()


	else
		..(W,user)
	return
