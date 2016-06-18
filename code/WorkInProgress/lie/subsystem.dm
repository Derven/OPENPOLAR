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

// northern_man //На улице не мерзнешь. Норд нашего времени.
// alcoholic    //В руках спавнится бутылка рнадомного алкоголя. Повод выпить не нужен.
// contrabandist //В анусе спавнится что-то незаконное. Осторожнее с этим.
// tractor-driver //Катаясь на снегоходе по полу - не падаешь. Годы жизни в деревне сделали вас непревзойденным мастером гусеничной техники.
// runner   //Нет усталости от бега. Тот, кто бегал по утрам каждый день, а не с понедельника.
// parkour_expert //мгновенное и гарантированное перелезание через стол. Не зря тренировался.
// android //парочка рандомных имплантов. Почему бы и нет?
// schizophrenic //перманентные галлюцинации. Бим-бом-бам, где мой мясоцикл
// deft //ловкач (+5 к ловкости). Вы похоже работали жонглером в цирке.
// strong //сила (+5 к ловкости) Работали грузчиком в порту.

/mob
	var
		northern_man = 0
		alcoholic = 0
		contrabandist = 0
		tractor_driver = 0
		runner = 0
		setup_me = 0
		parkour_expert = 0
		deft = 0
		strong = 0
		android = 0
		schizophrenic = 0

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
		if("parkour_expert") parkour_expert = 1
		if("android") android = 1
		if("schizophrenic") schizophrenic = 1
		if("deft") deft = 1
		if("strong") strong = 1

	if(alcoholic == 1)
		var/alcohol = pick(/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla, /obj/item/weapon/reagent_containers/food/drinks/bottle/gin, /obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey, /obj/item/weapon/reagent_containers/food/drinks/bottle/vodka)
		equip_to_slot_or_del(new alcohol(back), slot_in_backpack)

	if(contrabandist == 1)
		var/contraband = pick(/obj/item/weapon/reagent_containers/pill/cyanide, /obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita, /obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/angel)
		anal = new contraband()

	if(deft == 1)
		agility += 5

	if(strong == 1)
		strength += 5

	if(android == 1)
		var/obj/item/bionics/flashlight/my_implant = pick(/obj/item/bionics/strength_system, /obj/item/bionics/agility_system, /obj/item/bionics/flashlight)
		var/obj/item/bionics/strength_system/my_implant_2 = pick(/obj/item/bionics/strength_system, /obj/item/bionics/agility_system, /obj/item/bionics/flashlight)
		my_implant = new()
		my_implant_2  = new()
		implants += my_implant.name
		implants += my_implant_2.name
		my_implant.add_effect(src)
		my_implant_2.add_effect(src)

	if(schizophrenic == 1)
		hallucination = 500