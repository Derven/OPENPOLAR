var/elevator_1_tickstomove = 5
var/elevator_1_moving = 0

var/elevator_1_location = 1 // 0 = station 13, 1 = mining station, 2 = new_level, 3 = 4etvertbIé level

var/to_loc = 1 // 0 = station 13, 1 = mining station, 2 = new_level, 3 = 4etvertbIé level

/area/shuttle/mining/outpost2
	icon_state = "shuttle"

/area/shuttle/mining/outpost3
	icon_state = "shuttle"

proc/move_elevator_1()
	if(elevator_1_moving)	return
	elevator_1_moving = 1
//	spawn(elevator_1_tickstomove*10)
	spawn(10)
		var/area/fromArea
		var/area/toArea
		var/area/BufferArea = locate(/area/shuttle/mining)

		if (elevator_1_location == 1)
			fromArea = locate(/area/shuttle/mining/station)

		if (elevator_1_location == 2)
			fromArea = locate(/area/shuttle/mining/outpost)

		if (elevator_1_location == 3)
			fromArea = locate(/area/shuttle/mining/outpost2)

		if (elevator_1_location == 0)
			fromArea = locate(/area/shuttle/mining/outpost3)

		if (to_loc == 0 && to_loc != elevator_1_location)
			toArea = locate(/area/shuttle/mining/outpost3)

		if (to_loc == 1 && to_loc != elevator_1_location)
			toArea = locate(/area/shuttle/mining/station)

		if (to_loc == 2 && to_loc != elevator_1_location)
			toArea = locate(/area/shuttle/mining/outpost)

		if (to_loc == 3 && to_loc != elevator_1_location)
			toArea = locate(/area/shuttle/mining/outpost2)



		//else
		//	fromArea = locate(/area/shuttle/mining/outpost)
		//	toArea = locate(/area/shuttle/mining/station)

		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			//if(istype(T, /turf/simulated))
			//	del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		for(var/mob/living/simple_animal/pest in toArea) // And for the other kind of bug...
			pest.gib()

/////////////////////////////////HERE
		fromArea.move_contents_to(BufferArea)
		toArea.move_contents_to(fromArea)
		BufferArea.move_contents_to(toArea)
		if (to_loc != 13)
			elevator_1_location = to_loc
			to_loc = 13
	//	else
	//		to_loc = elevator_1_location
	//		elevator_1_location = 13


		for(var/mob/M in toArea)
			if(M.client)
				spawn(0)
					if(M.buckled)
						shake_camera(M, 3, 1) // buckled, not a lot of shaking
					else
						shake_camera(M, 10, 1) // unbuckled, HOLY SHIT SHAKE THE ROOM
			if(istype(M, /mob/living/carbon))
				if(!M.buckled)
					M.Weaken(3)

		elevator_1_moving = 0
	return

/obj/machinery/computer/elevator_1
	name = "Elevator console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "shuttle"
	req_access = list(access_mining)
	circuit = "/obj/item/weapon/circuitboard/elevator_1"
	var/hacked = 0
	var/location = 0 //0 = station, 1 = mining base

/obj/machinery/computer/elevator_1/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat = text("<center>Mining elevator:<br> <b><A href='?src=\ref[src];move=0'>To ZERO LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=1'>To FIRST LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=2'>To SECOND LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=3'>To THIRD LEVEL</A></b></center>")
	user << browse("[dat]", "window=miningshuttle;size=200x100")

/obj/machinery/computer/elevator_1/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)

	if(z == 1)
		elevator_1_location = 1

	if(z == 2)
		elevator_1_location = 2

	if(z == 3)
		elevator_1_location = 3

	if(z == 4)
		elevator_1_location = 0

	if(text2num(href_list["move"]) == 0)
		//if(ticker.mode.name == "blob")
		//	if(ticker.mode:declared)
		//		usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
		//		return

		if (!elevator_1_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			to_loc = 0
			move_elevator_1()
		else
			usr << "\blue Elevator is already moving."

	if(text2num(href_list["move"]) == 1)
		if (!elevator_1_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			to_loc = 1
			move_elevator_1()
		else
			usr << "\blue Elevator is already moving."

	if(text2num(href_list["move"]) == 2)
		if (!elevator_1_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			to_loc = 2
			move_elevator_1()
		else
			usr << "\blue Elevator is already moving."

	if(text2num(href_list["move"]) == 3)
		if (!elevator_1_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			to_loc = 3
			move_elevator_1()
		else
			usr << "\blue Elevator is already moving."

/obj/machinery/computer/elevator_1/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/card/emag))
		src.req_access = list()
		hacked = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"