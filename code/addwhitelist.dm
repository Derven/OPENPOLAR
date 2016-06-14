/* #define yellow_db_port 3306
#define yellow_db_name "green"
#define yellow_db_ip "127.0.0.1"
#define yellow_db_login "tgdb"
#define yellow_db_pass "tgdb" */

var/global/list/y_whitelist = list()

proc
	load_ywhitelist()
		y_whitelist = list ()
		log_admin("Loading whitelist")
		var/DBConnection/dbcon = new()
		var/DBQuery/query
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			log_admin("Failed to load whitelist. Error: [dbcon.ErrorMsg()]")
			return 0
		query = dbcon.NewQuery("SELECT * FROM whitelist")
		query.Execute()
		while (query.NextRow())
			y_whitelist += "[query.item[1]]"
		dbcon.Disconnect()
		log_admin("Whitelist init complete. There's [y_whitelist.len] in whitelist")
		return 1

	isInWhitelist(var/K)
		K = ckey(K)
		if (K in y_whitelist)
			return 1
		return 0

/datum/admins/proc
	LoadWhitelist()
		set category = "Server"
		set name = "Update whitelist"

		if (load_ywhitelist())
			usr << "\blue \bold Success!"
		else
			usr << "\red \bold Fail!"




//////////////////////////
/* #define WHITELIST_FILE "data/yellow_whitelist.txt"
var/global/y_whitelist = list()

proc
	load_ywhitelist()
		if (!fexists(WHITELIST_FILE)) //Doesn't it exists?
			text2file(null, WHITELIST_FILE) //CREATE IT
		y_whitelist = file2list(WHITELIST_FILE) 

	isInWhitelist(var/K)
		load_ywhitelist()
		K = ckey(K)	
		if (K in y_whitelist)
			return 1
		return 0

	addInWhitelist(var/K as text)
		load_ywhitelist()
		K = ckey(K)
		if (isInWhitelist(K))
			return 0
		text2file(K, WHITELIST_FILE)
		return 1

	removeFromWhitelist(var/K as text)
		load_ywhitelist()
		K = ckey(K)
		if (K in y_whitelist)
			y_whitelist -= K
			fdel(WHITELIST_FILE)
			text2file(dd_list2text(y_whitelist, "\n"), WHITELIST_FILE) //Goddamn BYOND.
			return 1
		return 0

/datum/admins/proc
	AddIn()
		set category = "Server"
		set name = "Add in whitelist"
		
		if (usr.client.holder.rank in list("Game Master", "Host", "Game Admin"))
			var/key = input(usr, "A key:") as text
			if (!key)
				return
			if (!addInWhitelist(key))
				usr << "ERROR:[ckey(key)] is already added."
				return
			log_admin("\blue [key_name_admin(usr)] added [ckey(key)] in the whitelist")
			message_admins("[key_name_admin(usr)] has added [ckey(key)] to whitelist.", 1)
		else
			usr << "\red You don't have such high rank to do this."
	RemoveFrom()
		set category = "Server"
		set name = "Remove from whitelist"
		
		if (usr.client.holder.rank in list("Game Master", "Host", "Game Admin"))
			var/key = input(usr, "A key:") as text
			if (!key)
				return
			if (!removeFromWhitelist(key))
				usr << "ERROR:[ckey(key)] not in whitelist, nothing to remove."
				return
			log_admin("\blue [key_name_admin(usr)] removed [ckey(key)] from the whitelist")
			message_admins("[key_name_admin(usr)] has removed [ckey(key)] from whitelist.", 1)
		else
			usr << "\red You don't have such high rank to do this."
	InWhitelist()
		set category = "Server"
		set name = "Is player in whitelist?"
		
		var/key = input(usr, "A key:") as text
		if (!key)
			return
		if (isInWhitelist(key))
			usr << "[ckey(key)] - CHECK!"
		else
			usr << "[ckey(key)] isn't whitelisted."
	ShowWhitelist()
		set category = "Server"
		set name = "Show whitelist"
		
		load_ywhitelist()
		var/dat = dd_list2text(y_whitelist, "<br>")
		usr << browse(dat, "window=whitelist")




proc
	addwhitelist(mob/user)

		if(user.client.holder.rank in list("Game Master", "Host", "Game Admin"))
			var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
			if(!accname)
				return
			var/DBConnection/dbcon = new()
			dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
			if(!dbcon.IsConnected())
				log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
				return
			var/DBQuery/query
			query = dbcon.NewQuery("INSERT INTO whitelist (byond) VALUES ('[accname]')")
			if(!query.Execute())
				src << "Unable to add key into DB"
				dbcon.Disconnect()
				return
			dbcon.Disconnect()
			log_admin("[key_name(usr)] added [accname] to whitelist.")
			message_admins("[key_name_admin(usr)] added [accname] to whitelist.", 1)
		else
			user << "Not enough high admin rank to do this"

	remwhitelist(mob/user)

		if(user.client.holder.rank in list("Game Master", "Host", "Game Admin"))
			var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
			if(!accname)
				return
			var/DBConnection/dbcon = new()
			dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
			if(!dbcon.IsConnected())
				log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
				return
			var/DBQuery/query
			query = dbcon.NewQuery("DELETE FROM whitelist WHERE byond=('[accname]')")

			if(!query.Execute())
				src << "Unable to remove key from DB"
				dbcon.Disconnect()
				return
			dbcon.Disconnect()
			log_admin("[key_name(usr)] has removed [accname] from whitelist.")
			message_admins("[key_name_admin(usr)] has removed [accname] from whitelist.", 1)
		else
			user << "Not enough high admin rank to do this"

	showwhitelist(mob/user)

		if(user.client.holder.rank) //Any rank can see that shit.
			bwhitelist = list()
			var/DBConnection/dbcon = new()
			var/DBQuery/query
			dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
			if(!dbcon.IsConnected())
				log_admin("Failed to load bwhitelist from green. Error: [dbcon.ErrorMsg()]")
				return
			query = dbcon.NewQuery("SELECT byond FROM whitelist ORDER BY byond ASC")
			query.Execute()
			while(query.NextRow())
				bwhitelist += "[query.item[1]] <br>"
			user << browse(bwhitelist, "window=whitelist")
			dbcon.Disconnect()
		else
			user << "Not enough high admin rank to do this"

	inWhitelist(mob/user)

		if(user.client.holder.rank) //Any rank can see that shit.
			var/DBConnection/dbcon = new()
			var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
			if(!accname)
				return
			if (check_bwhitelist(ckey(accname)))
				usr << "\blue [accname] in whitelist."
			else
				usr << "\red [accname] not in whitelist."
		else
			usr << "Not enough high admin rank to do this"

/datum/admins/proc/control_panel()
	set category = "Server"
	set desc = "It opens the control panel"
	set name = "Open whitelist control panel"

	var/selection = input(usr, "Choose an action to do with whitelist", null) in list("Add", "Remove", "Show", "Check player", "Cancel")
	switch(selection)
		if ("Add")
			addwhitelist(usr)
		if ("Remove")
			remwhitelist(usr)
		if ("Show")
			showwhitelist(usr)
		if ("Check player")
			inWhitelist(usr)
		else
			return 0
			
			

















/datum/admins/proc/addwhitelist()
	set category = "Server"
	set desc="Add to whitelist"
	set name="Add To Whitelist"
	if(usr.client.holder.rank in list("Game Master", "Host", "Game Admin"))
		var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
		if(!accname)
			return
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
			return
		var/DBQuery/query = dbcon.NewQuery("INSERT INTO whitelist (byond) VALUES ('[accname]')")
		if(!query.Execute())
			src << "Unable to add key into DB"
			dbcon.Disconnect()
			return
		dbcon.Disconnect()
		log_admin("[key_name(usr)] added [accname] to whitelist.")
		message_admins("[key_name_admin(usr)] added [accname] to whitelist.", 1)
	else
		usr << "Not enough high admin rank to do this"

/datum/admins/proc/remwhitelist()
	set category = "Server"
	set desc="Remove from whitelist"
	set name="Remove from whitelist"
	if(usr.client.holder.rank in list("Game Master", "Host", "Game Admin"))
		var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
		if(!accname)
			return
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
			return
		var/DBQuery/query = dbcon.NewQuery("DELETE FROM whitelist WHERE byond=('[accname]')")
		if(!query.Execute())
			src << "Unable to remove key from DB"
			dbcon.Disconnect()
			return
		dbcon.Disconnect()
		log_admin("[key_name(usr)] has removed [accname] from whitelist.")
		message_admins("[key_name_admin(usr)] has removed [accname] from whitelist.", 1)
	else
		usr << "Not enough high admin rank to do this"

/datum/admins/proc/showwhitelist()
	set category = "Server"
	set desc="Show whitelist"
	set name="Show whitelist"
	if(usr.client.holder.rank) //Any rank can see that shit.
		var/ckeys = list()
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
			return

		var/DBQuery/query = dbcon.NewQuery("SELECT byond FROM whitelist ORDER BY byond ASC")
		query.Execute()
		while(query.NextRow())
			ckeys += "[query.item[1]]<br>"
		usr << browse(ckeys, "window=whitelist")
		dbcon.Disconnect()
	else
		usr << "Not enough high admin rank to do this"

/datum/admins/proc/inWhitelist()
	set category = "Server"
	set desc = "Is player in whitelist?"
	set name = "Check in whitelist"

	if(usr.client.holder.rank) //Any rank can see that shit.
		var/DBConnection/dbcon = new()
		var/accname = ckey(input(usr,"Ckey of a player","ckey", null) as text|null)
		if(!accname)
			return
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if(!dbcon.IsConnected())
			log_admin("Failed to connect DB. Error: [dbcon.ErrorMsg()]")
			return

		var/DBQuery/query = dbcon.NewQuery("SELECT * FROM whitelist WHERE (byond='[accname]')")
		if (!query.Execute())
			usr << "Unable to search key in whitelist"
			dbcon.Disconnect()
			return
		if (query.item[1])
			usr << "\blue [accname] in whitelist."
		else
			usr << "\red [accname] not in whitelist."
		dbcon.Disconnect()
	else
		usr << "Not enough high admin rank to do this"*/
