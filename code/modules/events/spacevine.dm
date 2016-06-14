/var/global/spacevines_spawned = 0

/datum/event/spacevine
	oneShot			= 1

/datum/event/spacevine/start()
	//biomass is basically just a resprited version of space vines
	if(prob(50))
		biomass_infestation()
	//	spacevine_infestation()
	else
		biomass_infestation()
	spacevines_spawned = 1
