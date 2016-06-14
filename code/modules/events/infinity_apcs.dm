/datum/event/iapc
	announceWhen	= 0
	oneShot			= 1


/datum/event/iapc/announce()
	// Don't do anything, we want to pack the announcement with the actual event

/datum/event/iapc/start()
	spawn()
		for(var/obj/machinery/power/apc/apc)
			apc.cell = new/obj/item/weapon/cell/infinite(apc)
			apc.invisibility=101