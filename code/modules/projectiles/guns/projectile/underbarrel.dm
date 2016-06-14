/obj/item/weapon/gun/projectile/underslung
	w_class = 2

	can_fire()
		if(!istype(loc, /obj/item/weapon/gun))
			return 0
		return ..()

/obj/item/weapon/gun/projectile/underslung/g40mm
	name = "grenade launcher"
	desc = "A 40mm under-slung grenade launcher."
	icon_state = "u_grenade"
	w_class = 2
	origin_tech = "combat=4;materials=2"
	mag_type = /obj/item/ammo_magazine/internal/grenade