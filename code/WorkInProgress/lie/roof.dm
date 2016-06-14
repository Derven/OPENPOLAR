var/COVER_LAYER = 10
var/global/list/roofs = list()

/roof
	parent_type = /obj
	alpha = 128

	var
		id_ = "roof"

		image/IMAGE

	icon = 'icons/obj/roof.dmi'
	icon_state = "roof_1"

	New()
		roofs += src

/roof/hydropolar
	icon = 'icons/obj/roof.dmi'
	icon_state = "roof_hydro"

	id_ = "hydro"


/mob/proc/r00f()// ch3c|< r00f
	var/roof_here = 0
	for(var/roof/F in src.loc)
		roof_here = 1

		if(roof_here == 1)
			for(var/roof/R in roofs)
				if(R.id_ == F.id_)
					R.IMAGE=image('icons/nothing.dmi',R)
					R.IMAGE.override = TRUE
					R.IMAGE.alpha = 1
					usr << R.IMAGE

		else
			for(var/roof/R in roofs)
				if(R.id_ == R.id_)
					R.IMAGE=image(R,R,R.icon_state,dir = R.dir)
					R.IMAGE.override = TRUE
					R.IMAGE.alpha = 128
					usr << R.IMAGE