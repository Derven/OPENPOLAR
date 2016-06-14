/obj/structure/snow
	name = "snow"
	desc = "An extremely toxic precipitation."
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow1"
	anchored = 1
	density = 0
	layer = 2.45
	var/mineral = "metal"

/obj/structure/snow/New()
	if(prob(25))
		icon_state = "snow[rand(1,4)]"
	relativewall_neighbours()
	..()

/obj/structure/snow/Del()

	var/temploc = src.loc

	spawn(10)
		for(var/obj/structure/snow/W in range(temploc,1))
			W.relativewall()
	relativewall_neighbours()
	..()


/obj/structure/snow/relativewall()

	var/junction = 0 //will be used to determine from which side the wall is connected to other walls

	for(var/obj/structure/snow/W in orange(src,1))
		if(abs(src.x-W.x)-abs(src.y-W.y)) //doesn't count diagonal walls
			if(src.mineral == W.mineral)
				junction |= get_dir(src,W)
	icon_state = "[mineral][junction]"
	return


/obj/structure/snow/relativewall_neighbours()
	for(var/obj/structure/snow/S in range(src,1))
		S.relativewall()
		S.update_icon()
	return

/obj/structure/snow/update_icon()//Calling icon_update will refresh the smoothwalls if it's closed, otherwise it will make sure the icon is correct if it's open
	..()
	icon_state = "[mineral]0"
	src.relativewall()

/obj/structure/snow/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if( istype(W, /obj/item/weapon/shovel) )
		var/turf/T = get_turf(src)
		for(var/obj/structure/snow/S in range(T,1))
			S.relativewall()
			S.update_icon()//Refreshes the snow to make sure the icons don't desync
		del(src)

