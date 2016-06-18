//qiuck bionics
/obj/item/bionics
	icon = 'icons/obj/device.dmi'
	icon_state = "motion2"
	name = "quickbionic corp"

	proc/add_effect(var/mob/living/carbon/human/H)

	attack_self()
		usr << "\blue You attach [src] into yourself"
		if(istype(usr, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = usr
			H.implants += name
			H.drop_item()
			Move(H)
			add_effect(H)

/obj/item/bionics/strength_system
	name = "strength implant"
	add_effect(var/mob/living/carbon/human/H)
		H.strength += 6

/obj/item/bionics/agility_system
	name = "agility implant"
	add_effect(var/mob/living/carbon/human/H)
		H.agility += 6

/obj/item/bionics/CO2_filter
	name = "CO2_filter implant"
	add_effect(var/mob/living/carbon/human/H)
		H.CO2_filter = 1

/obj/item/bionics/flashlight
	name = "flashlight"
	add_effect(var/mob/living/carbon/human/H)
		H.implants += /obj/item/device/flashlight/bionic



mob/living/carbon/human
	var
		xray = 0
		night = 0
		sun = 0
		unstun = 0
		CO2_filter = 0

/obj/item/bionics/xray

	add_effect(var/mob/living/carbon/human/H)
		H.sight |= SEE_TURFS|SEE_MOBS|SEE_OBJS
		H.xray = 1

/obj/item/bionics/night

	add_effect(var/mob/living/carbon/human/H)
		H.see_in_dark = 5
		if(!H.druggy)
			H.see_invisible = SEE_INVISIBLE_MINIMUM
		H.night = 1

/obj/item/bionics/unstun
	add_effect(var/mob/living/carbon/human/H)
		H.unstun = 1