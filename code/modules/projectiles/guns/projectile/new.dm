/obj/item/weapon/gun/projectile/automatic/newgun
	name = "Ameise SMG"
	icon_state = "ap"
	mag_type = /obj/item/ammo_magazine/external/ap9mm
	force = 2 *5.0


	var/obj/item/weapon/gun/projectile/underslung/underslung
	var/use_underslung = 0
	var/use_silencer = 1
	alt_fire = 0

	AltFire(target, user)
		if(underslung)
			return underslung.Fire(target, user)


	update_icon()
		..()
		overlays.Cut()
		icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""]"
		if(underslung)
			overlays.Add("[initial(icon_state)]_grenade")
		if(istype(silenced, /obj/item))
			overlays.Add("[initial(icon_state)]_silencer")
		if(flashlight)
			if(flashlight.on)
				overlays.Add("[initial(icon_state)]_fl_on")
			else
				overlays.Add("[initial(icon_state)]_fl")
		return

/*	proc/toggle_fire_rate()
		set name = "Change Fire Rate"
		set category = "Object"
		set desc = "Click to change your gun's fire rate."

		var/mob/M = usr

		if(src && !M.stat && in_range(M,src) && can_burst)
			burst = !burst

			if(burst)
				usr << "You toggle [src] to single fire"
			else
				usr << "You toggle [src] to burst fire"*/


	verb/remove_attachments()
		set name = "Remove Attachments"
		set category = "Object"
		set desc = "Click to remove your gun's attachments."

		var/mob/M = usr

		if(src && !M.stat && in_range(M,src))
			var/list/attachments = list()
			if(underslung)
				attachments.Add(underslung)

			if(istype(silenced, /obj/item))
				attachments.Add(silenced)

			if(flashlight)
				attachments.Add(flashlight)

			if(attachments.len)
				attachments.Add("Cancel")
			else
				usr << "There is no attachments on [src]!"
				return

			var/obj/item/choice = input("Remove what?") in attachments
			if(choice && choice != "Cancel" && !M.stat && in_range(M,src))
				usr << "You detach [choice] from [src]"

				if(choice == underslung)
					underslung = null
					alt_fire = 0

				else if(choice == silenced)
					var/obj/item/weapon/silencer/S = silenced
					fire_sound = S.oldsound
					silenced = null

				else if(choice == flashlight)
					M.loc = get_turf(src)
					if(flashlight.on) flashlight.on = 0
					update_brightness(M)
					flashlight.update_brightness(M)
					verbs.Remove(/obj/item/weapon/gun/projectile/automatic/newgun/proc/toggle_flashlight)
					flashlight = null

				M.put_in_hands(choice)
				choice.update_icon()
				update_icon()

	proc/toggle_flashlight()
		set name = "Toggle Flashlight"
		set category = "Object"
		set desc = "Click to toggle your gun's flashlight."

		var/mob/M = usr

		if(src && !M.stat && in_range(M,src) && flashlight)
			flashlight.attack_self(M)
			update_brightness(M)


	proc/update_brightness(var/mob/user = null)
		if(flashlight)
			if(flashlight.on)
				if(loc == user)
					user.SetLuminosity(user.luminosity + flashlight.brightness_on)
				else if(isturf(loc))
					SetLuminosity(flashlight.brightness_on)
			else
				if(loc == user)
					user.SetLuminosity(user.luminosity - flashlight.brightness_on)
				else if(isturf(loc))
					SetLuminosity(0)
			update_icon()

	pickup(mob/user)
		if(flashlight && flashlight.on)
			user.SetLuminosity(user.luminosity + flashlight.brightness_on)
			SetLuminosity(0)

	dropped(mob/user)
		if(flashlight && flashlight.on)
			user.SetLuminosity(user.luminosity - flashlight.brightness_on)
			SetLuminosity(flashlight.brightness_on)


	attackby(var/obj/item/O as obj, mob/user as mob)
		if(!..())
			if(underslung)
				if(istype(O, /obj/item/ammo_casing) || istype(O, /obj/item/ammo_magazine))
					return underslung.attackby(O, user)

			else if(istype(O, /obj/item/weapon/gun/projectile/underslung) && use_underslung)
				user.drop_item()
				user << "You attach [O] to [src]"
				underslung = O
				O.loc = src
				alt_fire = 1
				update_icon()
				return 1

			if(istype(O, /obj/item/weapon/silencer) && !silenced)
				user.drop_item()
				user << "<span class='notice'>You screw [O] onto [src].</span>"
				silenced = O	//dodgy?
				var/obj/item/weapon/silencer/S = O
				S.oldsound = fire_sound
				fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
				S.loc = src		//put the silencer into the gun
				update_icon()
				return 1

			if(istype(O, /obj/item/device/flashlight/gun) && !flashlight)
				user.drop_item()
				user << "You attach [O] to [src]"
				flashlight = O
				flashlight.on = 0
				flashlight.update_brightness(user)

				O.loc = src
				verbs.Add(/obj/item/weapon/gun/projectile/automatic/newgun/proc/toggle_flashlight)
				update_icon()
				return 1



/obj/item/weapon/gun/projectile/automatic/newgun/ep
	name = "EP-12"
	icon_state = "ep"
	use_underslung = 1
	use_silencer = 0
	force = 2 *12
	desc = "A heavy semi-automatic shotgun"
	mag_type = /obj/item/ammo_magazine/external/saiga


/obj/item/weapon/gun/projectile/automatic/newgun/taiga
	name = "Taiga LAR"
	icon_state = "lar"
	use_underslung = 1
	use_silencer = 1
	force = 2 *10
	mag_type = /obj/item/ammo_magazine/external/a556x45