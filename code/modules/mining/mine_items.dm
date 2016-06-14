/**********************Light************************/

//this item is intended to give the effect of entering the mine, so that light gradually fades
/obj/effect/light_emitter
	name = "Light-emtter"
	anchored = 1
	unacidable = 1
	luminosity = 8

/**********************Miner Lockers**************************/

/obj/structure/closet/secure_closet/miner
	name = "miner's equipment"
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_broken = "miningsecbroken"
	icon_off = "miningsecoff"
	req_access = list(access_mining)

/obj/structure/closet/secure_closet/miner/New()
	..()
	sleep(2)
	if(prob(50))
		new /obj/item/weapon/storage/backpack/industrial(src)
	else
		new /obj/item/weapon/storage/backpack/satchel_eng(src)
	new /obj/item/device/radio/headset/headset_cargo(src)
	new /obj/item/clothing/under/rank/miner(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/device/analyzer(src)
	new /obj/item/weapon/storage/bag/ore(src)
	new /obj/item/device/flashlight/lantern(src)
	new /obj/item/weapon/shovel(src)
	new /obj/item/weapon/pickaxe(src)
	new /obj/item/clothing/glasses/meson(src)


/**********************Shuttle Computer**************************/

var/mine_elevator_tickstomove = 10
var/mine_elevator_moving = 0
var/mine_elevator_location = 0
var/choice = 0

/area/shuttle/mining/outpost/outpost2

proc/move_mine_elevator_1()
	if(mine_elevator_moving)	return
	mine_elevator_moving = 1
	spawn(mine_elevator_tickstomove*5)
		var/area/fromArea
		var/area/toArea

		var/area/toArea1 = locate(/area/shuttle/mining/station)

		if (mine_elevator_location == 1)
			fromArea = locate(/area/shuttle/mining/outpost)
			toArea = toArea1
		else
			fromArea = toArea1
			toArea = locate(/area/shuttle/mining/outpost)



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
					AM.throw
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		for(var/mob/living/simple_animal/pest in toArea) // And for the other kind of bug...
			pest.gib()

		fromArea.move_contents_to(toArea)

		if (mine_elevator_location)
			mine_elevator_location = 0
		else
			mine_elevator_location = 1

		mine_elevator_moving = 0

		if(choice == 1)
			move_mine_elevator_2()
	return

proc/move_mine_elevator_2()
	if(mine_elevator_moving)	return
	mine_elevator_moving = 1
	spawn(mine_elevator_tickstomove*5)
		var/area/froomArea
		var/area/tooArea

		var/area/toArea1 = locate(/area/shuttle/mining/station)
		var/area/toArea2 = locate(/area/shuttle/mining/outpost2)

		if (mine_elevator_location == 1)
			froomArea = toArea1
			tooArea = toArea2
		else
			froomArea = toArea2
			tooArea = toArea1

		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in tooArea)
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
					AM.throw
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in tooArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		for(var/mob/living/simple_animal/pest in tooArea) // And for the other kind of bug...
			pest.gib()

		froomArea.move_contents_to(tooArea)

		world << "wait..."
//		if (mine_elevator_location)
//			mine_elevator_location = 0
//		else
		//	mine_elevator_location = 1

		mine_elevator_moving = 0
//	return

/obj/machinery/computer/mine_elevator
	name = "Mining Elevator Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "miningelevator"
	req_access = list(access_mining)
	circuit = "/obj/item/weapon/circuitboard/mine_elevator"
	density = 0
	var/hacked = 0
	var/location = 0

/obj/machinery/computer/mine_elevator/attack_hand(user as mob)
	src.add_fingerprint(usr)
	var/dat = "<center>Mining elevator: <b><A href='?src=\ref[src];move=1'>Send to SECOND LEVEL</A></b></center><br>"
	dat += "<center><b><A href='?src=\ref[src];move=2'>Send to THIRD LEVEL</A></b></center><br>"

	user << browse("[dat]", "window=elevator;size=200x100")

/obj/machinery/computer/mine_elevator/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if(text2num(href_list["move"]) == 1)
		//if(ticker.mode.name == "blob")
		//	if(ticker.mode:declared)
		//		usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
		//		return
		choice = 0

		if (!mine_elevator_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			move_mine_elevator_1()
		else
			usr << "\blue Elevator is already moving."

	if(text2num(href_list["move"]) == 2)
		//if(ticker.mode.name == "blob")
		//	if(ticker.mode:declared)
		//		usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
		//		return
		choice = 1

		if (!mine_elevator_moving)
			usr << "\blue Elevator recieved message and will be sent shortly."
			move_mine_elevator_1()
		else
			usr << "\blue Elevator is already moving."

/obj/machinery/computer/mine_elevator/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/card/emag))
		var/obj/item/weapon/card/emag/E = W
		if(E.uses)
			E.uses--
		else
			return
		src.req_access = list()
		hacked = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"
/*
	else if(istype(W, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
			var/obj/item/weapon/circuitboard/mine_elevator/M = new /obj/item/weapon/circuitboard/mine_elevator( A )
			for (var/obj/C in src)
				C.loc = src.loc
			A.circuit = M
			A.anchored = 1

			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				new /obj/item/weapon/shard( src.loc )
				A.state = 3
				A.icon_state = "3"
			else
				user << "\blue You disconnect the monitor."
				A.state = 4
				A.icon_state = "4"

			del(src)
*/
/******************************Lantern*******************************/

/obj/item/device/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	desc = "A mining lantern."
	brightness_on = 6			// luminosity when on

/*****************************Pickaxe********************************/

/obj/item/weapon/pickaxe
	name = "pickaxe"
	icon = 'icons/obj/items.dmi'
	icon_state = "pickaxe"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 2 *15.0
	throwforce = 2 *4.0
	item_state = "pickaxe"
	w_class = 4.0
	m_amt = 3750 //one sheet, but where can you make them?
	var/digspeed = 40 //moving the delay to an item var so R&D can make improved picks. --NEO
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	var/drill_verb = "picking"

	var/excavation_amount = 100

	hammer
		name = "sledgehammer"
		//icon_state = "sledgehammer" Waiting on sprite
		desc = "A mining hammer made of reinforced metal. You feel like smashing your boss in the face with this."

	silver
		name = "silver pickaxe"
		icon_state = "spickaxe"
		item_state = "spickaxe"
		digspeed = 30
		origin_tech = "materials=3"
		desc = "This makes no metallurgic sense."

	drill
		name = "mining drill" // Can dig sand as well!
		icon_state = "handdrill"
		item_state = "jackhammer"
		digspeed = 30
		origin_tech = "materials=2;powerstorage=3;engineering=2"
		desc = "Yours is the drill that will pierce through the rock walls."

	jackhammer
		name = "sonic jackhammer"
		icon_state = "jackhammer"
		item_state = "jackhammer"
		digspeed = 20 //faster than drill, but cannot dig
		origin_tech = "materials=3;powerstorage=2;engineering=2"
		desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."

	gold
		name = "golden pickaxe"
		icon_state = "gpickaxe"
		item_state = "gpickaxe"
		digspeed = 20
		origin_tech = "materials=4"
		desc = "This makes no metallurgic sense."

	plasmacutter
		name = "plasma cutter"
		icon_state = "plasmacutter"
		item_state = "gun"
		w_class = 3.0 //it is smaller than the pickaxe
		damtype = "fire"
		digspeed = 20 //Can slice though normal walls, all girders, or be used in reinforced wall deconstruction/ light thermite on fire
		origin_tech = "materials=4;plasmatech=3;engineering=3"
		desc = "A rock cutter that uses bursts of hot plasma. You could use it to cut limbs off of xenos! Or, you know, mine stuff."

	diamond
		name = "diamond pickaxe"
		icon_state = "dpickaxe"
		item_state = "dpickaxe"
		digspeed = 10
		origin_tech = "materials=6;engineering=4"
		desc = "A pickaxe with a diamond pick head, this is just like minecraft."

	diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
		name = "diamond mining drill"
		icon_state = "diamonddrill"
		item_state = "jackhammer"
		digspeed = 5 //Digs through walls, girders, and can dig up sand
		origin_tech = "materials=6;powerstorage=4;engineering=5"
		desc = "Yours is the drill that will pierce the heavens!"

	borgdrill
		name = "cyborg mining drill"
		icon_state = "diamonddrill"
		item_state = "jackhammer"
		digspeed = 15
		desc = ""

/*****************************Shovel********************************/

/obj/item/weapon/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/items.dmi'
	icon_state = "shovel"
	flags = FPRINT | TABLEPASS| CONDUCT
	slot_flags = SLOT_BELT
	force = 2 *8.0
	throwforce = 2 *4.0
	item_state = "shovel"
	w_class = 3.0
	m_amt = 50
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")

/obj/item/weapon/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	force = 2 *5.0
	throwforce = 2 *7.0
	w_class = 2.0


/**********************Mining car (Crate like thing, not the rail car)**************************/

/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon = 'icons/obj/storage.dmi'
	icon_state = "miningcar"
	density = 1
	icon_opened = "miningcaropen"
	icon_closed = "miningcar"

