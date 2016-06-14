/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	caliber = ".357"
	projectile_type = /obj/item/projectile/bullet

/obj/item/ammo_casing/a50
	desc = "A .50AE bullet casing."
	caliber = ".50"
	projectile_type = /obj/item/projectile/bullet

/obj/item/ammo_casing/a418
	desc = "A .418 bullet casing."
	caliber = ".357"
	projectile_type = /obj/item/projectile/bullet/suffocationbullet


/obj/item/ammo_casing/a75
	desc = "A .75 bullet casing."
	caliber = ".75"
	projectile_type = /obj/item/projectile/bullet/gyro


/obj/item/ammo_casing/a666
	desc = "A .666 bullet casing."
	caliber = ".357"
	projectile_type = /obj/item/projectile/bullet/cyanideround


/obj/item/ammo_casing/c38
	desc = "A .38 R bullet casing."
	caliber = ".38"
	projectile_type = /obj/item/projectile/bullet/weakbullet

/obj/item/ammo_casing/c38/e
	desc = "A .38 bullet casing."
	projectile_type = /obj/item/projectile/bullet/midbullet


/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/bullet30

/obj/item/ammo_casing/c9mm/extra
	desc = "A 9mm E bullet casing."
	projectile_type = /obj/item/projectile/bullet/midbullet

/obj/item/ammo_casing/c9mm/r
	desc = "A 9mm R bullet casing."
	projectile_type = /obj/item/projectile/bullet/weakbullet

/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/midbullet


/obj/item/ammo_casing/a12mm
	desc = "A 12mm bullet casing."
	caliber = "12mm"
	projectile_type = /obj/item/projectile/bullet/midbullet

/obj/item/ammo_casing/none
	name = "dirty hack casing"
	desc = "A there-is-no-shell, for use in revolvers."

/obj/item/ammo_casing/g40mm
	name = "40mm grenade casing"
	desc = "A 40mm HE grenade casing."
	caliber = "40mm"
	icon_state = "40mm"
	projectile_type = /obj/item/projectile/bullet/u_grenade


	update_icon()
		pixel_x = rand(-6, 6)
		pixel_y = rand(-6, 6)
		desc = "[initial(desc)][BB ? "" : " This one is spent"]"
		if(BB)
			icon_state = "40mm"
		else
			icon_state = "40mm_empty"


/obj/item/ammo_casing/shotgun
	name = "shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	caliber = "12 gauge"
	projectile_type = /obj/item/projectile/bullet
	m_amt = 12500

	update_icon()
		pixel_x = rand(-6, 6)
		pixel_y = rand(-6, 6)
		desc = "[initial(desc)][BB ? "" : " This one is spent"]"
		overlays = list()
		if(!BB)
			overlays += icon('icons/obj/ammo.dmi', "shell_empty")

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "blshell"
	projectile_type = ""
	m_amt = 250


/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A weak beanbag shell."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	m_amt = 500


/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A stunning shell."
	icon_state = "stunshell"
	projectile_type = /obj/item/projectile/bullet/stunshot
	m_amt = 2500


/obj/item/ammo_casing/shotgun/dart
	name = "shotgun dart"
	desc = "A dart for use in shotguns."
	icon_state = "blshell" //someone, draw the icon, please.
	projectile_type = /obj/item/projectile/bullet/dart
	m_amt = 7500
	New()
		..()
		flags |= NOREACT
		create_reagents(50)

	attackby()
		return

	on_fired()
		if(BB)
			if(reagents && BB.reagents)
				reagents.trans_to(BB, reagents.total_volume)
				reagents.delete()

/obj/item/ammo_casing/shotgun/dartpreloaded
	name = "shotgun dart"
	desc = "A dart for use in shotguns."
	icon_state = "blshell" //someone, draw the icon, please.
	projectile_type = /obj/item/projectile/bullet/dart
	m_amt = 7500

/obj/item/ammo_casing/shotgun/dartpreloaded/metalfoam
	projectile_type = /obj/item/projectile/bullet/dart/metalfoam

/obj/item/ammo_casing/a762
	desc = "A 7.62 bullet casing."
	caliber = ".762"
	projectile_type = /obj/item/projectile/bullet


/obj/item/ammo_casing/a556x45
	desc = "A 5.56x45 bullet casing."
	caliber = "5.56x45"
	projectile_type = /obj/item/projectile/bullet/midbullet