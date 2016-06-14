/verb/end_avatar()
	set name = "End control"
	set category = "IC"

	usr << "\blue You've ended controlling."
	usr:death()

/mob/living
	var/mob/living/carbon/human/avatar/controlling_a = null

	death(gibbed)
		..(gibbed)
		if (controlling_a) //Is he in avatar?
			controlling_a << "\red You feel your consciousness fading away, like a leaf, carried by an autumn wind, uncaring and cold"
			controlling_a.death(0)

/mob/living/carbon/human/avatar
	name = "Avatar"
	var/mob/living/carbon/human/master_mob = null

	death(gibbed)
		if (master_mob && master_mob.stat != 2) //Does the first body exists and alive?
			transfer_control(src, master_mob)
		else
			ghostize( (master_mob ? master_mob : null ) )
		for (var/mob/A in oviewers(src))
			A << "\blue [src] has disappeared!"
		del(src)

	Life()
		nutrition = 600 //Always full.
		..()

/proc/transfer_control(first, second)
	var/mob/living/F = first
	var/mob/living/carbon/human/avatar/S = second
	if (F && S) //They're both exist.
		if (F.client && F.ckey) //First has client inside
			if (F.mind)
				S << "\red Your feel that something has kicked out you"
				F.mind.transfer_to(S)
				F.controlling_a = S
				S.master_mob = F
				return 1
	return 0

/proc/create_avatar(mob, place)
	place = get_turf(place)
	if (isturf(place))
		if (ismob(mob))
			var/mob/living/carbon/human/avatar/A = new /mob/living/carbon/human/avatar(place)
			if (!transfer_control(mob, A))
				del (A) //Exception?
				return 0
			A.verbs += /verb/end_avatar
			return A
		return 0
	return 0