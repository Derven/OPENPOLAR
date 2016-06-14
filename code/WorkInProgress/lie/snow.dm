/mob/living/carbon/human/proc/check_my_snow()
	var/turf/T = src.loc
	if(istype(T, /turf/simulated/floor/plating/airless/asteroid))
		if(!istype(T, /turf/simulated/floor/plating/airless/asteroid/cave))
			snow.alpha = 128
	else
		snow.alpha = 0