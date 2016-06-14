//Terribly sorry for the code doubling, but things go derpy otherwise.
/obj/machinery/door/airlock/multi_tile
	width = 2

/obj/machinery/door/airlock/multi_tile/glass
	name = "Glass Airlock"
	icon = 'icons/obj/doors/Door2x1glass.dmi'
	opacity = 0
	glass = 1
	assembly_type = "obj/structure/door_assembly/multi_tile"

/obj/machinery/door/airlock/multi_tile/glass_ext
	name = "Glass Airlock"
	icon = 'icons/obj/doors/Door2x1ext_glass.dmi'
	opacity = 0
	glass = 1
	assembly_type = "obj/structure/door_assembly/multi_tile"


/obj/machinery/door/airlock/multi_tile/vault
	name = "Glass Airlock"
	icon = 'icons/obj/doors/Door2x1Vault.dmi'
	opacity = 1
	assembly_type = "obj/structure/door_assembly/multi_tile"


/obj/machinery/door/airlock/multi_tile/external
	name = "Airtight Airlock"
	icon = 'icons/obj/doors/Door2x1ext.dmi'
	opacity = 1
	assembly_type = "obj/structure/door_assembly/multi_tile"

/obj/machinery/door/airlock/multi_tile/vault/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/device/detective_scanner))
		return
	if(src.operating || isrobot(user))	return //borgs can't attack doors open because it conflicts with their AI-like interaction with them.
	src.add_fingerprint(user)
	if(!src.requiresID())
		user = null
	if(src.density && (istype(I, /obj/item/weapon/card/emag)||istype(I, /obj/item/weapon/melee/energy/blade)))
		return
	if(src.allowed(user))
		if(src.density)
			user << "\blue There isn't any buttons or something else!"
		else
			user << "\blue There isn't any buttons or something else!"
		return
	if(src.density)
		flick("door_deny", src)
	return