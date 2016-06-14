/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "helmet"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/head/helmet/warden
	name = "warden's hat"
	desc = "It's a special helmet issued to the Warden of a securiy force. Protects the head from impacts."
	icon_state = "policehelm"
	flags_inv = 0

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	armor = list(melee = 82, bullet = 15, laser = 5,energy = 5, bomb = 5, bio = 2, rad = 0)
	flags_inv = HIDEEARS
	siemens_coefficient = 0.7

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "They're often used by highly trained Swat Members."
	icon_state = "swat"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "swat"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.5

/obj/item/clothing/head/helmet/stormtrooper_helmet
	name = "\improper stormtrooper helmet"
	desc = "They're often used by highly trained Stormtroopers."
	icon_state = "stormtrooper_helmet"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "stormtrooper_helmet"
	armor = list(melee = 8, bullet = 5, laser = 5,energy = 2, bomb = 5, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	siemens_coefficient = 0.5


/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	icon_state = "thunderdome"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "thunderdome"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/orderlyhelm
	name = "orderly riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "orderly_helm"
	item_state = "orderly_helm"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	armor = list(melee = 50, bullet = 15, laser = 5,energy = 5, bomb = 5, bio = 2, rad = 0)
	flags_inv = HIDEEARS
	siemens_coefficient = 0.7

/obj/item/clothing/head/rebel_helm
	name = "Rebel helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "rebel_helm"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "rebel_helm"
	armor = list(melee = 50, bullet = 15, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/head/rebel_pilot_helm
	name = "Rebel helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "rebel_pilot_helm"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "rebel_pilot_helm"
	armor = list(melee = 50, bullet = 15, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/head/jedi_hood
	name = "Jedi Knight hood"
	desc = "Jedi Knight traditional hood."
	icon_state = "jedi_hood"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "jedi_hood"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/head/sith_hood
	name = "Sith hood"
	desc = "Sith traditional hood."
	icon_state = "sith_hood"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "sith_hood"
	armor = list(melee = 50, bullet = 15, laser = 50,energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/head/darth_vader_helm
	name = "Lord Vader's helmet"
	desc = "Lord Vader's personal helmet."
	icon_state = "darth_vader_helm"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "darth_vader_helm"
	armor = list(melee = 50, bullet = 15, laser = 70,energy = 60, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECITON_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	siemens_coefficient = 0.7

