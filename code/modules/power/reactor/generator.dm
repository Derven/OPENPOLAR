/////SINGULARITY SPAWNER
/obj/machinery/the_singularitygen/
	name = "Core"
	desc = "An Odd Device which produces energy."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "TheSingGen"
	anchored = 0
	density = 1
	use_power = 0
	var/energy = 0
	var/gen_stat_n = 0
	var/gen_stat_s = 0
	var/gen_stat_w = 0
	var/gen_stat_e = 0

/obj/machinery/the_singularitygen/process()
	var/turf/T = get_turf(src)

	var/turf/L
	if(istype(get_step(src, EAST), /obj/machinery/core_field_e))
		L = get_step(src, EAST)
		for(var/obj/machinery/core_field_e/E in L)
			if(E.energy >=50)
				gen_stat_e = 1
	if(istype(get_step(src, NORTH), /obj/machinery/core_field_n))
		L = get_step(src, NORTH)
		for(var/obj/machinery/core_field_n/N in L)
			if(N.energy >= 75)
				gen_stat_n = 1
	if(istype(get_step(src, WEST), /obj/machinery/core_field_w))
		L = get_step(src, WEST)
		for(var/obj/machinery/core_field_w/W in L)
			if(W.energy >= 100)
				gen_stat_w = 1
	if(istype(get_step(src, SOUTH), /obj/machinery/core_field_s))
		L = get_step(src, SOUTH)
		for(var/obj/machinery/core_field_s/S in L)
			if(S.energy >= 130)
				gen_stat_s = 1

//	if(src.energy >= 200)
	if((gen_stat_n == 1)||(gen_stat_s == 1)||(gen_stat_w == 1)||(gen_stat_e == 1))
		new /obj/machinery/singularity/(T, 50)
		if(src) del(src)

/obj/machinery/the_singularitygen/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/wrench))
		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
		if(anchored)
			user.visible_message("[user.name] secures [src.name] to the floor.", \
				"You secure the [src.name] to the floor.", \
				"You hear a ratchet")
		else
			user.visible_message("[user.name] unsecures [src.name] from the floor.", \
				"You unsecure the [src.name] from the floor.", \
				"You hear a ratchet")
		return
	return ..()

/obj/machinery/core_field_n/
	name = "Protective field generator"
	desc = "An Odd Device which produces energy field."
	icon = 'icons/obj/machines/reactor.dmi'
	icon_state = "prot_off_n"
	anchored = 1
	density = 1
	use_power = 0
	var/energy = 0

/obj/machinery/core_field_n/process()
	get_turf(src)
	if(src.energy >= 75)
		icon_state = "prot_on_n"
		playsound(src.loc, 'sound/weapons/flash.ogg', 75, 1)

/obj/machinery/core_field_s/
	name = "Protective field generator"
	desc = "An Odd Device which produces energy field."
	icon = 'icons/obj/machines/reactor.dmi'
	icon_state = "prot_off_s"
	anchored = 1
	density = 1
	use_power = 0
	var/energy = 0

/obj/machinery/core_field_s/process()
	get_turf(src)
	if(src.energy >= 130)
		icon_state = "prot_on_s"
		playsound(src.loc, 'sound/weapons/flash.ogg', 75, 1)

/obj/machinery/core_field_w/
	name = "Protective field generator"
	desc = "An Odd Device which produces energy field."
	icon = 'icons/obj/machines/reactor.dmi'
	icon_state = "prot_off_w"
	anchored = 1
	density = 1
	use_power = 0
	var/energy = 0

/obj/machinery/core_field_w/process()
	get_turf(src)
	if(src.energy >= 100)
		icon_state = "prot_on_w"
		playsound(src.loc, 'sound/weapons/flash.ogg', 75, 1)

/obj/machinery/core_field_e/
	name = "Protective field generator"
	desc = "An Odd Device which produces energy field."
	icon = 'icons/obj/machines/reactor.dmi'
	icon_state = "prot_off_e"
	anchored = 1
	density = 1
	use_power = 0
	var/energy = 0

/obj/machinery/core_field_e/process()
	get_turf(src)
	if(src.energy >= 50)
		icon_state = "prot_on_e"
		playsound(src.loc, 'sound/weapons/flash.ogg', 75, 1)


