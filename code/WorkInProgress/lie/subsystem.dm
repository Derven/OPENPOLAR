/mob
	var/stamina = 1200

/mob/living/carbon/human
	var/strength = 0 //bonus to strength
	var/speed = 0 //run_delay
	var/agility = 0 //bonus to agility

/obj/thrower
	icon = 'icons/thrower.dmi'
	layer = 10

/mob/living/carbon/human/proc/check_throw()
	var/obj/thrower/T = new()
	overlays -= T
	if(in_throw_mode == 1)
		overlays += T

//features

// northern_man //На улице не мерзнешь
// alcoholic    //В руках спавнится бутылка рнадомного алкоголя
// contrabandist //В анусе спавнится что-то незаконное
// tractor-driver //Катаясь на снегоходе по полу - не падаешь
// runner   //Нет усталости от бега

/mob/living/carbon/human
	var
		northern_man = 0
		alcoholic = 0
		contrabandist = 0
		tractor_driver = 0
		runner = 0
		setup_me = 0

//     Mood
		mood = 0

/mob/living/carbon/human/proc/SETUP_BASE()
	setup_me = 1
	switch(client.prefs.feature)
		if("northern") northern_man = 1
		if("alcoholic") alcoholic = 1
		if("contrabandist") contrabandist = 1
		if("tractor_driver") tractor_driver = 1
		if("runner") runner = 1

	if(alcoholic == 1)
		var/alcohol = pick(/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla, /obj/item/weapon/reagent_containers/food/drinks/bottle/gin, /obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey, /obj/item/weapon/reagent_containers/food/drinks/bottle/vodka)
		equip_to_slot_or_del(new alcohol(back), slot_in_backpack)

	if(contrabandist == 1)
		var/contraband = pick(/obj/item/weapon/reagent_containers/pill/cyanide, /obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita, /obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/angel)
		anal = new contraband()