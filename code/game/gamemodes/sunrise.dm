//***********************************************************
//SUN
//***********************************************************

/obj/effect/sunlight
	name = "sunlight"
	desc = "You can see it? Damn..."
	icon = 'icons/turf/areas.dmi'
	icon_state = "dk_yellow"
	anchored = 1
	density = 0
	layer = 10
	invisibility = 100
	luminosity = 6
	pass_flags = PASSTABLE | PASSGRILLE
//	var/energy = 0


/proc/sun_rise() // -- Ralph_Hesher
	var/start_x_sun
	var/start_y_sun
	var/sun_top
	var/sun_side
	for(var/obj/effect/landmark/S in world)
		if(S.name == "sunshine")
			if(start_y_sun!=119)
				sun_side=1
			else
				break
			for(start_x_sun=sun_side, start_x_sun<127, start_x_sun=start_x_sun+5)
				S.x = start_x_sun
			//	message_admins("Spawning, x = [start_x_sun]",1)
				sun_top=1
				for(start_y_sun=sun_top, start_y_sun<129, start_y_sun=start_y_sun+5)
					S.y = start_y_sun
					if(istype(S.loc, /turf/simulated/floor/plating/airless/asteroid))
						new /obj/effect/sunlight(S.loc)
				sleep(30)
			if(start_x_sun<128)
				sun_rise()


/proc/sun_set()
	var/start_x_sun
	var/start_y_sun
	var/sun_top
	var/sun_side
	for(var/obj/effect/landmark/S in world)
		if(S.name == "sunshine")
			if(start_x_sun!=119)
				sun_side=1
			else
				break
			for(start_x_sun=sun_side, start_x_sun<127, start_x_sun=start_x_sun+5)
				S.x = start_x_sun
				//if(!(istype(S.loc, /turf/simulated/mineral))&&(istype(S.loc, /turf/simulated/wall)))
				//	if(istype(S.loc, /area/mine/explored)||istype(S.loc, /area/mine/unexplored))
			//	message_admins("Deleted at , x = [start_x_sun]",1)
				sun_top=1
				for(start_y_sun=sun_top, start_y_sun<129, start_y_sun=start_y_sun+5)
					S.y = start_y_sun
					for(var/atom/O in S.loc)
						if(istype(O, /obj/effect/sunlight))
							del(O)
				sleep(30)
			if(start_x_sun<128)
				sun_set()





//**********************************************************
