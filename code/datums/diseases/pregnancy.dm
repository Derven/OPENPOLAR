/datum/disease/pregnancy
	form = "Condition"
	name = "Pregnancy"
	max_stages = 4
	spread = "None"
	spread_type = SPECIAL
	cure = "Surgery"
	agent = "Fetus"
	affected_species = list("Human")
	permeability_mod = 1
	contagious_period = 9001 //slightly hacky, but hey! whatever works, right?
	desc = "If left untreated the subject will become very weak, and may vomit often."
	severity = "Medium"
	longevity = 1000
	hidden = list(0, 1)
	stage_minimum_age = 160 // at least 200 life ticks per stage

/datum/disease/pregnancy/stage_act()
	..()
	if(stage == 1)
		if(prob(5))
			affected_mob << "\blue You feel a light pain in your abdomen!"
			affected_mob.emote("me",1,"winces slightly.")
	if(stage == 2)
		if(prob(3))
			affected_mob << "\blue You feels something in your abdomen..."
			affected_mob.emote("me",1,"winces painfully.")
	if(stage == 3)
		if(prob(1))
			if (affected_mob.nutrition > 100)
				affected_mob << "\red I think it's a time for me to have taken birth.. HOLD ON, MEDBAY!"
				var/mob/living/carbon/human/H = affected_mob
				H.vomit()
			else
				affected_mob << "\red You gag as you want to throw up, but there's nothing in your stomach!"
				affected_mob.Weaken(10)
				affected_mob.adjustToxLoss(3)
	if(stage > 3)
		if(prob(3) && ishuman(affected_mob))
			var/mob/living/carbon/human/H = affected_mob
			H << "\red You feels, that you ready to give birth! Its a time to have a childbirth or have a Caserean section!"
			H.Weaken(5)
			if(prob(15) && ishuman(affected_mob))
				H << "\red AAAAAAAAAAAGGGGGGGGGGHHHH!!!..."
				H.visible_message("\blue [H] gave birth!" , \
					"\blue You just give a birth..")
				new /mob/living/simple_animal/baby(get_turf(H))
				for(var/datum/disease/pregnancy/pregnancy in H.viruses)
					del(pregnancy)
