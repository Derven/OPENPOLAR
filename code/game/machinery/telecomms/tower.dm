var/list/freq2name = list(1459 = "Common", 1353 = "Command",
						1347 = "Supply", 1351 = "Science",
						1355 = "Medical", 1357 = "Engineering", 1359 = "Security")

/obj/machinery/telecomms/allinone/tower
	freq_listening = list(1459, 1353, 1347, 1351, 1355, 1357, 1359)
	var/list/channels = list("Common" = 1, "Command" = 1, "Supply" = 1,
							"Science" = 1, "Medical" = 1, "Engineering" = 1,
							"Security" = 1)

	var/list/logs = list()
	var/datum/wires/tower/wires

/obj/machinery/telecomms/allinone/tower/New()
	..()
	wires = new(src)




/obj/machinery/telecomms/allinone/tower/receive_signal(datum/signal/signal)
	if(!on) // has to be on to receive messages
		return

	if(is_freq_listening(signal)) // detect subspace signals
		signal.data["done"] = 1 // mark the signal as being broadcasted
		signal.data["compression"] = 0

		// Search for the original signal and mark it as done as well
		var/datum/signal/original = signal.data["original"]
		if(original)
			original.data["done"] = 1

		if(signal.data["slow"] > 0)
			sleep(signal.data["slow"]) // simulate the network lag if necessary
		else
			sleep(1)

		/* ###### Broadcast a message using signal.data ###### */

		var/datum/radio_frequency/connection = signal.data["connection"]

		var/list/zl = list()
		zl += src.z

		var/log_freq
		if(connection.frequency in freq2name)
			log_freq = freq2name[connection.frequency]

		if(log_freq)
			if(!channels[log_freq])
				return

			world << "log"
			var/list/loglist = logs[log_freq]
			if(!loglist)
				loglist = list()

			if(signal.data["name"] && signal.data["message"])
				var/record = signal.data["name"]
				if(signal.data["job"])
					record += " ([signal.data["job"]])"

				record += ": [signal.data["message"]]"
				loglist += record
				logs[log_freq] = loglist


		Broadcast_Message(connection, signal.data["mob"], signal.data["vmask"],
						signal.data["vmessage"], signal.data["radio"], signal.data["message"],
						signal.data["name"], signal.data["job"], signal.data["realname"],
						signal.data["vname"], , signal.data["compression"],
						zl, connection.frequency)

		world << "cast2"
		/*Broadcast_Message(connection, null, "#unkn", "[Gibberish("V42TCBW7IguJBNjdenURooOgPBaDMxyDQ", 90)] *BZZZT*",
						null, "[Gibberish("V42TCBW7IguJBNjdenURooOgPBaDMxyDQ", 90)] *BZZZT*",
						"#unkn", "#unkn", "#unkn", "#unkn", , 0, zl, connection.frequency)*/