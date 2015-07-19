mob/Player
	var/
		tmp/list/PrivateChats = list()
		tmp/list/PrivateTimes = list()
		tmp/list/NewMessage = list()
		tmp/Talkingto //Who your talking too..
		tmp/obj/PCObj/PCO




	verb/
		SendPC() //The Send Button
			set hidden = 1
			var/Text = winget(usr, "PCInput", "text")
			var/mob/Player/P = usr
			P.PC(Text)
		OpenPC()
			//set hidden = 1
			winset(usr, "PrivateChat", "is-visible=true")
			UpdatePlayerListPC()
		PC(T as text)
			set hidden = 1
			var/mob/Player/M = usr
			M.PrivateChats[M.Talkingto] = "<font color = blue>[M]:</font> [T]<BR>" + M.PrivateChats[M.Talkingto]
			var/mob/Player/MM = GetOwner(M.Talkingto)
			if(!MM) return //Talking to no one, why continue?
			MM.PrivateChats[ckey] = "<font color = blue>[M]:</font> [T]<BR>" + MM.PrivateChats[MM.Talkingto]
			var/html = "<BODY link=black alink=marroon vlink=marroon BGCOLOR=black TEXT=white><font size = 2>[M.PrivateChats[M.Talkingto]]"
			M<<output(html, "PCOutput")
			if(MM.Talkingto == ckey)
				html = "<BODY link=black alink=marroon vlink=marroon BGCOLOR=black TEXT=white><font size = 2>[MM.PrivateChats[MM.Talkingto]]"
				MM<<output(html, "PCOutput")
			M.PrivateTimes[M.Talkingto] = world.timeofday
			M.UpdatePlayerListPC()
			MM.NewMessage[M.ckey] = 1
			MM.UpdatePlayerListPC()


	proc
		UpdatePlayerListPC()
			if(winget(src, "PM ON", "is-checked") == "true") winset(src, "PrivateChat", "is-visible=true")
			var/items = 0
			var/list/Recent = list()
			if(length(PrivateChats))
				winset(src, "PCPlayers", "text-color=red")
				winset(src, "PCPlayers", "current-cell=1,[++items]")
				src << output("--Recent Contacts--", "PCPlayers")
				winset(src, "PCPlayers", "text-color=black")
			for(var/i in PrivateChats) //Put recently talked to people at the top of the list
				var/mob/Player/P = GetOwner(i)
				if(!P) continue
				if(world.timeofday - PrivateTimes[i] <= 6000) //10 minutes
					if(NewMessage.Find(P.ckey)) winset(src, "PCPlayers", "text-color=blue")
					winset(src, "PCPlayers", "current-cell=1,[++items]")
					src << output(P.PCO, "PCPlayers")
					winset(src, "PCPlayers", "text-color=black")
					Recent += P.ckey
			if(length(PrivateChats))
				winset(src, "PCPlayers", "text-color=red")
				winset(src, "PCPlayers", "current-cell=1,[++items]")
				src << output("--Other Contacts--", "PCPlayers")
				winset(src, "PCPlayers", "text-color=black")
			for(var/mob/Player/P in world)
				if(Recent.Find(P.ckey)) continue //We already have them in the list.
				if(P == src) continue
				if(NewMessage.Find(P.ckey)) winset(src, "PCPlayers", "text-color=blue")
				winset(src, "PCPlayers", "current-cell=1,[++items]")
				src << output(P.PCO, "PCPlayers")
				winset(src, "PCPlayers", "text-color=black")
			winset(src, "PCPlayers", "cells=1x[items]")	// cut off any remaining rows


obj/PCObj
	var/OWNER

	Click()
		if(isPlayer(usr))
			var/mob/Player/M = usr
			M.Talkingto = OWNER
			M.UpdatePlayerListPC()
			var/html = "<BODY link=black alink=marroon vlink=marroon BGCOLOR=black TEXT=white><font size = 2>[M.PrivateChats[M.Talkingto]]"
			M<<output(html, "PCOutput")
			M.NewMessage[OWNER] = 0
