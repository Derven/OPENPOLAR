/obj/structure/stool/bed/holo_bed
	name = "Bed with sensors"
	var/forming_up = 0
	buckle_mob(mob/M as mob, mob/user as mob)
		..()
		if (!M:handcuffed)
			var/ask = input(M, "Do you want to put these sensors?", "Yes") in list("Yes", "No")
			if (ask == "No")
				return
			M << "\blue You have putted them over your entire body."
			var/test = input(M, "Choose a test to do.", null) in list("Enginnering", "Medicine", "Chemistry", "Solar", "Bar", "Singularity", "Virology", "Cancel")
			if (test == "Cancel")
				M << "\blue You've pulled off the sensors."
				return
			var/area/cyber_space/place/polygon = null
			for (var/area/cyber_space/place/A in world)
				if (!A.isTakenBy && !A.owner)
					polygon = A
					break
			if (polygon)
				M << "\blue Cyberspace is forming up... please, wait"
				M << "\red You've been restrained."
				forming_up = 1
				polygon.appear(test, src, M) << "\blue The polygon has been created."
				forming_up = 0
				return
			M << "\red \bold For unknown reason every polygon is busy. Try again later."
	manual_unbuckle(mob/user)
		if (!forming_up)
			..(user)
			return 1
		user << "\red You can't unbuckle [user], he's restrained to the bed!"
		return 0
	unbuckle()
		var/mob/living/carbon/human/S = buckled_mob
		if (S && S.controlling_a)
			var/mob/living/carbon/human/avatar/C = S.controlling_a
			C << "\red \bold You have been unbuckled in reality!"
			C.death()
		..()