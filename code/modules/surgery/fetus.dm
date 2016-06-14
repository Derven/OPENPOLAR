//Procedures in this file: Abortion, Caseraen section
//////////////////////////////////////////////////////////////////
//							ABORTION							//
//////////////////////////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/fetus
	name = "Fetus"
	desc = "An fetus which looks perfectly healthy."
	icon = 'icons/mob/baby.dmi'
	icon_state = "fetus"
	origin_tech = "biotech=4"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		src.bitesize = 3

/datum/surgery_step/abortion/
	priority = 2
	can_infect = 1
	blood_level = 1
	var/newbaby
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (target_zone != "groin")
			return 0
		var/datum/organ/external/groin = target.get_organ("groin")
		if (!groin)
			return 0
		if (groin.open < 2)
			return 0
		return 1

/datum/surgery_step/abortion/cut_fetus
	var/barren = 40
	allowed_tools = list(
	/obj/item/weapon/scalpel = 100,		\
	/obj/item/weapon/kitchenknife = 75,	\
	/obj/item/weapon/shard = 50, 		\
	)

	min_duration = 90
	max_duration = 120

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		for(var/datum/disease/pregnancy/pregnancy in target.viruses)
			if(pregnancy.stage > 0)
				return ..() && target.op_stage.fetus == 0
			else
				return ..() && target.op_stage.fetus == 666

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		for(var/datum/disease/pregnancy/pregnancy in target.viruses)
			if(pregnancy.stage < 3)
				user.visible_message("[user] starts to separating [target]'s fetus from the abdominal wall with \the [tool].", \
				"You start to separating [target]'s fetus from the abdominal wall with \the [tool]." )
				target.custom_pain("The pain in your abdomen is living hell!",1)
			else
				user.visible_message("[user] starts to do a Caseraen section with \the [tool].", \
				"You start to do a Caseraen section with \the [tool]." )
				target.custom_pain("The pain in your abdomen is living hell!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		for(var/datum/disease/pregnancy/pregnancy in target.viruses)
			if(pregnancy.stage < 3)
				new /obj/item/weapon/reagent_containers/food/snacks/fetus(get_turf(target))
				if (prob(barren))
					user.visible_message("\blue [user] has separated [target]'s fetus with \the [tool]." , \
					"\blue You have separated [target]'s fetus with \the [tool].")
					del(pregnancy)
				else
					user.visible_message("\blue [user] has separated [target]'s fetus with \the [tool]." , \
					"\blue You have separated [target]'s fetus with \the [tool]. \red But [target] will never get pregnant again...")
					target.resistances += pregnancy
					del(pregnancy)
				target << "\red Another destroyed life.."

			else

				new /mob/living/simple_animal/baby(get_turf(target))

				if (prob(barren))
					user.visible_message("\blue [user] has cuts the cord and pulls out the baby." , \
					"\blue You cuts the cord and pulls out the baby.")
					del(pregnancy)
				else
					user.visible_message("\blue [user] has cuts the cord and pulls out the baby." , \
					"\blue You cuts the cord and pulls out the baby. \red But [target] will never get pregnant again...")
					target.resistances += pregnancy
					del(pregnancy)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/external/groin = target.get_organ("groin")
		user.visible_message("\red [user]'s hand slips, slicing an artery inside [target]'s abdomen with \the [tool]!", \
		"\red Your hand slips, slicing an artery inside [target]'s abdomen with \the [tool]!")
		groin.createwound(CUT, 50, 1)
		barren += 20