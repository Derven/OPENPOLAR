/datum/job/vader
	title = "Lead Commander"
	flag = VADER
	department_flag = STARWARS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Emperor"
	selection_color = "#ffdddd"
	/*
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1
	access = list(access_security, access_sec_doors, access_brig, access_armory, access_court,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_armory, access_court,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_player_age = 14
	*/
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/clown_shoes(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/darth_vader(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/darth_vader_helm(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/weapon/melee/energy/sword/red(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain(H), slot_ears)
		var/obj/item/device/pda/heads/pda = new(H)
		pda.owner = H.real_name
		pda.ownjob = "Imperial Commander"
		pda.name = "PDA-[H.real_name] ([pda.ownjob])"

		H.equip_to_slot_or_del(pda, slot_r_store)

		var/obj/item/weapon/card/id/W = new(H)
		W.name = "[H.real_name]'s ID Card"
		W.icon_state = "centcom"
		W.access = get_all_accesses()
		W.assignment = "Imperial Commander"
		W.registered_name = H.real_name
		H.equip_to_slot_or_del(W, slot_wear_id)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		var/datum/organ/external/affected = H.organs_by_name["head"]
		affected.implants += L
		L.part = affected
		return 1

/datum/job/lordsith
	title = "Emperor"
	flag = LORDSITH
	department_flag = STARWARS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Dark Side"
	selection_color = "#ffdddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/lord_sith(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/weapon/melee/energy/sword/red(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain(H), slot_ears)
		var/obj/item/device/pda/heads/pda = new(H)
		pda.owner = H.real_name
		pda.ownjob = "Dark Side Lord"
		pda.name = "PDA-[H.real_name] ([pda.ownjob])"
		H.equip_to_slot_or_del(pda, slot_r_store)

		var/obj/item/weapon/card/id/W = new(H)
		W.name = "[H.real_name]'s ID Card"
		W.icon_state = "centcom"
		W.access = get_all_accesses()
		W.assignment = "Dark Lord"
		W.registered_name = H.real_name
		H.equip_to_slot_or_del(W, slot_wear_id)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		var/datum/organ/external/affected = H.organs_by_name["head"]
		affected.implants += L
		L.part = affected
		return 1

/datum/job/sith
	title = "Sith"
	flag = SITH
	department_flag = STARWARS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Dark Lord"
	selection_color = "#ffdddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate/tacticool(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/sith(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/sith_hood(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/weapon/dualsaber(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain(H), slot_ears)
		var/obj/item/device/pda/heads/pda = new(H)
		pda.owner = H.real_name
		pda.ownjob = "Emperior overseer"
		pda.name = "PDA-[H.real_name] ([pda.ownjob])"
		H.equip_to_slot_or_del(pda, slot_r_store)

		var/obj/item/weapon/card/id/W = new(H)
		W.name = "[H.real_name]'s ID Card"
		W.icon_state = "centcom"
		W.access = get_all_accesses()
		W.assignment = "Emperior overseer"
		W.registered_name = H.real_name
		H.equip_to_slot_or_del(W, slot_wear_id)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		var/datum/organ/external/affected = H.organs_by_name["head"]
		affected.implants += L
		L.part = affected
		return 1

/datum/job/commander
	title = "Imperial Commander"
	flag = COMMANDER
	department_flag = STARWARS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "Darth Vader, the Lead Commander"
	selection_color = "#ffdddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/hos(H), slot_ears)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/beret/centcom/officer(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/imperial_officer(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/laser/captain(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud(H), slot_glasses)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/gun(H), slot_s_store)
		var/obj/item/device/pda/heads/pda = new(H)
		pda.owner = H.real_name
		pda.ownjob = "Emperior commander"
		pda.name = "PDA-[H.real_name] ([pda.ownjob])"
		H.equip_to_slot_or_del(pda, slot_r_store)

		var/obj/item/weapon/card/id/W = new(H)
		W.name = "[H.real_name]'s ID Card"
		W.icon_state = "centcom"
		W.access = get_all_accesses()
		W.assignment = "Emperior commander"
		W.registered_name = H.real_name
		H.equip_to_slot_or_del(W, slot_wear_id)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		var/datum/organ/external/affected = H.organs_by_name["head"]
		affected.implants += L
		L.part = affected
		return 1

/datum/job/trooper
	title = "Imperial Trooper"
	flag = TROOPER
	department_flag = STARWARS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Emperial heads"
	selection_color = "#ffdddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/stormtrooper(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/stormtrooper_helmet(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate/tacticool(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat(H), slot_wear_mask)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(H), slot_ears)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/xray(H), slot_belt)

		var/obj/item/device/pda/heads/pda = new(H)
		pda.owner = H.real_name
		pda.ownjob = "Imperial trooper"
		pda.name = "PDA-[H.real_name] ([pda.ownjob])"

		H.equip_to_slot_or_del(pda, slot_r_store)

		var/obj/item/weapon/card/id/W = new(H)
//	[copytext(md5(H.real_name), 2, 6)]
	//	W.name = "[H.real_name]'s ID Card"
		W.name = "([rand()])'s ID Card"
	//	W.name = "[copytext(md5(H.real_name), 2, 6)]'s ID Card"
		W.icon_state = "centcom"
		W.access += list(access_security, access_sec_doors, access_brig, access_forensics_lockers, access_court, access_medical, access_morgue, access_maint_tunnels, access_engine, access_engine_equip,)
		W.assignment = "Imperial trooper"
	//	W.registered_name = "Trooper ([copytext(md5(H.real_name), 2, 6)])"
		W.registered_name = "Trooper ([rand()])"
		H.equip_to_slot_or_del(W, slot_wear_id)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		var/datum/organ/external/affected = H.organs_by_name["head"]
		affected.implants += L
		L.part = affected
		return 1

/datum/job/rebel
	title = "Rebel"
	flag = REBEL
	department_flag = STARWARS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Rebel forces"
	selection_color = "#fff5cc"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/rebel_helm(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rebel(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)

/datum/job/rebelpilot
	title = "Rebel pilot"
	flag = REBEL
	department_flag = STARWARS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Rebel forces"
	selection_color = "#fff5cc"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/head/rebel_pilot_helm(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rebel_pilot(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
		H.equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate(H), slot_wear_id)

/datum/job/hansolo
	title = "Han Solo"
	flag = HANSOLO
	department_flag = STARWARS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Rebel forces"
	selection_color = "#fff5cc"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/rebel_pilot_helm(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/det(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(H), slot_gloves)
		H.equip_if_possible(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/laser/captain(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/tie/holster/armpit(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/card/id/syndicate(H), slot_wear_id)

/datum/job/chubakka
	title = "Chewbacca"
	flag = CHUBAKKA
	department_flag = STARWARS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Rebel forces"
	selection_color = "#fff5cc"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/rebel_pilot_helm(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)


/datum/job/leia
	title = "Princess"
	flag = LEIA
	department_flag = STARWARS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "your own opinion"
	selection_color = "#dddddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)

/datum/job/jedi
	title = "Jedi"
	flag = JEDI
	department_flag = STARWARS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "Republic"
	selection_color = "#ffdddd"
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/color/grey(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/jedi(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/jedi_hood(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/weapon/melee/energy/sword/green(H), slot_l_hand)



