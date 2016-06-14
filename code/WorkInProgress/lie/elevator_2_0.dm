var/global/list/elevator_commanders = list()

/obj/machinery/computer/elevator_control
	name = "elevator control console"
	icon_state = "elevator"
	var/where = 1

/obj/machinery/computer/elevator_control/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat = text("<center>Elevator's contol:<br> <b><A href='?src=\ref[src];move=0'>0 : Technical floor</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=1'>G : Cargo docs</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=2'>1 : Central level</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=3'>2 : Command quarters</A></b></center>")
	user << browse("[dat]", "window=miningshuttle;size=400x300")

/obj/machinery/computer/elevator_control/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)

	if(text2num(href_list["move"]) == 0)
		where = 1
		usr << "\blue Elevator recieved message and will be sent shortly."
		move_elevator_(usr)

	if(text2num(href_list["move"]) == 1)
		where = 2
		usr << "\blue Elevator recieved message and will be sent shortly."
		move_elevator_(usr)

	if(text2num(href_list["move"]) == 2)
		where = 3
		usr << "\blue Elevator recieved message and will be sent shortly."
		move_elevator_(usr)

	if(text2num(href_list["move"]) == 3)
		where = 4
		usr << "\blue Elevator recieved message and will be sent shortly."
		move_elevator_(usr)

/obj/machinery/computer/elevator_control/proc/move_elevator_(usr)
	if(where == z)
		usr << "\red Elevator is here"
		return 0

	usr << "\blue Elevator started moving"

	for(var/atom/movable/O in range(1,src))
		if(istype(O, /mob))
			O.z = where

		if(istype(O, /obj))
			O.z = where

	z = where

	return

/obj/machinery/computer/elevator_control/New()
	..()
	elevator_commanders += src

/obj/machinery/elevator_control_2
	name = "elevator control console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "elevatorpanel"
	density = 0


/obj/machinery/elevator_control_2/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)

	for(var/obj/machinery/computer/elevator_control/ELCON in elevator_commanders)
		if(text2num(href_list["move"]) == 0)
			ELCON.where = 1
			usr << "\blue Elevator recieved message and will be sent shortly."
			ELCON.move_elevator_(usr)

		if(text2num(href_list["move"]) == 1)
			ELCON.where = 2
			usr << "\blue Elevator recieved message and will be sent shortly."
			ELCON.move_elevator_(usr)

		if(text2num(href_list["move"]) == 2)
			ELCON.where = 3
			usr << "\blue Elevator recieved message and will be sent shortly."
			ELCON.move_elevator_(usr)

		if(text2num(href_list["move"]) == 3)
			ELCON.where = 4
			usr << "\blue Elevator recieved message and will be sent shortly."
			ELCON.move_elevator_(usr)

/obj/machinery/elevator_control_2/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat = text("<center>Mining elevator:<br> <b><A href='?src=\ref[src];move=0'>To ZERO LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=1'>To FIRST LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=2'>To SECOND LEVEL</A></b></center>")
	dat += text("<center><b><A href='?src=\ref[src];move=3'>To THIRD LEVEL</A></b></center>")
	user << browse("[dat]", "window=miningshuttle;size=200x100")