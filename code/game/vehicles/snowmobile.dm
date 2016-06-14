/obj/structure/stool/bed/chair/snowmobile
	name = "Snowmobile"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "snowmobile_1"
	anchored = 0
	density = 1
	flags = OPENCONTAINER
	//copypaste sorry
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite

/obj/structure/stool/bed/chair/snowmobile/New()
	handle_rotation()
	icon_state = "snowmobile_[rand(1,3)]"

/obj/structure/stool/bed/chair/snowmobile/examine()
	set src in usr
	usr << "\icon[src] This pimpin' ride contains [reagents.total_volume] unit\s of liquid!"


/obj/structure/stool/bed/chair/snowmobile/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/key/snowmobile))
		user << "Hold [W] in one of your hands while you drive this pimpin' ride."


/obj/structure/stool/bed/chair/snowmobile/relaymove(mob/user, direction)
	if(istype(user.l_hand, /obj/item/key/snowmobile) || istype(user.r_hand, /obj/item/key/snowmobile))
		if(user.stat || user.stunned || user.weakened || user.paralysis)
			unbuckle()

		if(istype(user, /mob/living/carbon/human))
			var/mob/living/carbon/human/HH = user
			if(!istype(get_turf(src), /turf/simulated/floor/plating/airless/asteroid) && !locate(/obj/structure/snow,get_turf(src)) && HH.tractor_driver == 0)
				unbuckle()
				user.Weaken(3)
				user << "\red Snowmobile is jammed, dropping you down."
				step(src, direction)
				sleep(2)
				step(src, direction)
				sleep(4)
				step(src, direction)
				sleep(8)
				step(src, direction)

			else
				step(src, direction)
				update_mob()
				handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this pimpin' ride.</span>"

/obj/structure/stool/bed/chair/snowmobile/Move()
	..()
	if(buckled_mob)
		if(buckled_mob.buckled == src)
			buckled_mob.loc = loc

/obj/structure/stool/bed/chair/snowmobile/buckle_mob(mob/M, mob/user)
	if(M != user || !ismob(M) || get_dist(src, user) > 1 || user.restrained() || user.lying || user.stat || M.buckled || istype(user, /mob/living/silicon))
		return

	unbuckle()

	M.visible_message(\
		"<span class='notice'>[M] climbs onto the pimpin' ride!</span>",\
		"<span class='notice'>You climb onto the pimpin' ride!</span>")
	M.buckled = src
	M.loc = loc
	M.dir = dir
	M.update_canmove()
	buckled_mob = M
	update_mob()
	add_fingerprint(user)
	return

/obj/structure/stool/bed/chair/snowmobile/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = 0
		buckled_mob.pixel_y = 0
	..()

/obj/structure/stool/bed/chair/snowmobile/handle_rotation()
	if(dir == SOUTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

	if(buckled_mob)
		if(buckled_mob.loc != loc)
			buckled_mob.buckled = null //Temporary, so Move() succeeds.
			buckled_mob.buckled = src //Restoring

	update_mob()

/obj/structure/stool/bed/chair/snowmobile/proc/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 6
			if(WEST)
				buckled_mob.pixel_x = 2
				buckled_mob.pixel_y = 6
			if(NORTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 6
			if(EAST)
				buckled_mob.pixel_x = -2
				buckled_mob.pixel_y = 6

/obj/structure/stool/bed/chair/snowmobile/bullet_act(var/obj/item/projectile/Proj)
	if(buckled_mob)
		if(prob(65))
			return buckled_mob.bullet_act(Proj)
	visible_message("<span class='warning'>[Proj] ricochets off the pimpin' ride!</span>")

/obj/item/key/snowmobile
	name = "key"
	desc = "A keyring with a small steel key."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "seckeys"
	w_class = 1