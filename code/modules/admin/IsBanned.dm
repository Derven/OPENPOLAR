//Blocks an attempt to connect before even creating our client datum thing.
world/IsBanned(key,address,computer_id)
        if(ckey(key) in admin_datums)
                return ..()
 //       return list("reason"="Server closed.", "desc"="\nServer closed on maintenance work (Polar Station testing).\nGo to forum: http://forum.ss13.ru/index.php?showforum=8185")

        //Guest Checking
        if(!guests_allowed && IsGuestKey(key))
                log_access("Failed Login: [key] - Guests not allowed")
        //        message_admins("\blue Failed Login: [key] - Guests not allowed")
                return list("reason"="guest", "desc"="\nReason: Guests not allowed. Please sign in with a byond account.")

/*       //whitelist
        if(!isInWhitelist(key))
                return list("reason"="Not in whitelist", "desc"="\nYou are not in whitelist.\nGo to forum: http://forum.ss13.ru/index.php?showforum=92")
*/
        //check if the IP address is a known TOR node
        if(config && config.ToRban && ToRban_isbanned(address))
                log_access("Failed Login: [src] - Banned: ToR")
                message_admins("\blue Failed Login: [src] - Banned: ToR")
                //ban their computer_id and ckey for posterity
                AddBan(ckey(key), computer_id, "Use of ToR", "Automated Ban", 0, 0)
                return list("reason"="Using ToR", "desc"="\nReason: The network you are using to connect has been banned.\nIf you believe this is a mistake, please request help at [config.banappeals]")

        //Ban Checking
        . = CheckBan( ckey(key), computer_id, address )
        if(.)
                log_access("Failed Login: [key] [computer_id] [address] - Banned [.["reason"]]")
                message_admins("\blue Failed Login: [key] id:[computer_id] ip:[address] - Banned [.["reason"]]")
                return .

        return ..()        //default pager ban stuff
