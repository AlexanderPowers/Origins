
var
	list
		MasterKey = "richie100"
		MGM = list("alexander08","richie100","lwojx","zeroxdx","valen45")
		GM = list("alexander08")

		Banned_IDs = list()
		Banned_Keys = list()
	ChatLog = "<body bgcolor=#000000><font size = 2>"
	StaffLog = "<body bgcolor=#000000><font size = 2 color = white>"
	GymLog = "<body bgcolor=#000000><font size = 2 color = white>"
	BugLog = "<body bgcolor=#000000><font size = 2 color = white>"
	AreaMuted = 0
//Ban History Skin Stuff//----------------------
obj/HUD/BannedPlayers
	var/
		CKEY
		ID
		TIME
		REASON
		Owner


	Click()
		if(usr.MasterGMCheck())
			winset(usr, "BanHistory.BannedTill", "text='  Banned Till: [time2text(TIME)]")
			winset(usr, "BanHistory.Reason", "text='[REASON]")
			winset(usr, "BanHistory.Unban", "command='Unban [CKEY]'")
		else
			usr<<System("You are not an Admin and therefore cannot use these commands")

mob/verb
	Unban(CKEY as text)
		set hidden = 1
		if(usr.MasterGMCheck())
			if(alert("Are you sure you wish to unban [CKEY]",,"Yes","No") == "No") return
			var/list/Blist = Banned_Keys[CKEY]
			Blist = Blist.Copy()
			if(!Blist)
				usr<<System("No record found of [CKEY] in Banned List")
				return
			Banned_Keys -= CKEY
			if(Blist["id"]) Banned_IDs -= Blist["id"]
			for(var/obj/HUD/BannedPlayers/BP in world) if(BP.CKEY == CKEY) del BP
			usr.UpdateBanHistory()

			world <<System("[usr] has unbanned [CKEY]")
		else return

var/list/BPH = list() //This is a list of all the objects used in the Display

world
	New()
		..()
		spawn()
			for(var/i in Banned_Keys)
				var/list/banning = 	Banned_Keys[i]
				var/obj/HUD/BannedPlayers/BP = new
				BPH += BP

				BP.CKEY = banning["ckey"]
				if(banning["id"]) BP.ID = banning["id"]
				BP.REASON = banning["reason"]
				BP.TIME = banning["time"]
				BP.name = "[PlayerNames[BP.CKEY]]([BP.CKEY])"


mob/proc/UpdateBanHistory()
	var/items = 0
	for(var/obj/HUD/BannedPlayers/BP in BPH)
		winset(src, "BannedPlayers", "current-cell=1,[++items]")
		src << output(BP, "BannedPlayers")
		winset(src, "BannedPlayers", "current-cell=2,[items]")
		src << output(BP.ID, "BannedPlayers")
	winset(src, "BannedPlayers", "cells=2x[items]")	// cut off any remaining rows


//--//-----------------------------------------------------------------------------
atom/proc/Finds(var/list/AD)
	var/list/AlreadyDefined = list()
	AlreadyDefined += AD

	for(var/X in vars)
		if(isPlayer(vars[X]))
			return "[vars[X]] found in [X] variable"
			sleep(10)
		else if(isturf(vars[X]) || isarea(vars[X]) || ismob(vars[X]) || isobj(vars[X]))
			var/atom/A = vars[X]
			if(AlreadyDefined.Find(A)) continue
			AlreadyDefined += A
			var/T = A.Finds(AlreadyDefined)
			if(T) return "Located an atom in [X], doing a search of [A]. [T]"
		if(islist(vars[X]))
			var/list/L = vars[X]
			for(var/x in L) //Search the contents of the list
				if(isPlayer(L[x]))
					return "[L[x]] found in [X] variable"
					sleep(10)
				else if(isturf(L[x]) || isarea(L[x]) || ismob(L[x]) || isobj(L[x]))
					var/atom/A = L[x]
					if(AlreadyDefined.Find(A)) continue
					AlreadyDefined += A
					var/T = A.Finds(AlreadyDefined)
					if(T) return "Located an atom in [X], doing a search of [A]. [T]"

				if(islist(L[x]))
					var/list/l = L[x]
					for(var/j in l) //Search the contents of the list
						if(isPlayer(l[j]))
							return "[l[j]] found in [x] variable in [X] variable"
							sleep(10)
						else if(isturf(L[j]) || isarea(L[j]) || ismob(L[j]) || isobj(L[j]))
							var/atom/A = L[j]
							if(AlreadyDefined.Find(A)) continue
							AlreadyDefined += A
							var/T = A.Finds(AlreadyDefined)
							if(T) return "Located an atom in [X], doing a search of [A]. [T]"
	return 0





mob/var/list_view
mob/MGM/verb

	Cloak()
		set category = "Staff"
		var/mob/Player/P
		if(istype(usr,/mob/Player)) P = usr
		else return
		del P.FightingPokemon
		usr.density = !usr.density
		usr.invisibility = !usr.invisibility
		usr.NoRunDelay = !usr.NoRunDelay

	Find_Player_in_Player()
		set category = "Staff"
		var/mob/Player/P = GetPlayer("Search whos mall?")
		P.Finds(usr)


	Ban_History()
		winset(src,"BanHistory","is-visible=true")
		usr.UpdateBanHistory(1)
	Update_Server()//Get your .dmb file ready and chose the file.
		set category = "Staff"
		var/mob/Player/P = usr
		if(!isPlayer(P)) return
		if(P) P.ScrollText("System", "Please open the Origins.dmb file",'DMB.png')
		if(!P) return
		var/DMB = input("Please choose the DMB file") as file
		world <<"<b><center><B> Rebooting in 30 seconds." //Tells the world that were rebooting for an update.
		sleep(300) //wait 30 seconds before we reboot.
		fdel("Origins.dmb") //Delete your currunt .dmb
		fdel("Origins.rsc") //Delete your currunt .dmb
		world <<"<b><center><B>Rebooting Now." //Reboot.
		fcopy(DMB,"Origins.dmb") //Copy the file over.
		world.Reboot() //Reboot.

	Check_Logs()
		set category = "Staff"
		/*if(MasterGMCheck() != 2)
			usr<<System("This verb is reserved for the MasterGM")
			return*/
		switch(input("Options:","Which log?") as null|anything in list("Error Log","Chat Log","Staff Log","Bug Submittion Log","Gym Log"))
			if("Player in Player Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse("<pre>"+PiPLog+"</pre>")
			if("Error Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse("<pre>"+file2text(WORLD_LOG)+"</pre>")
					if("Get Log")
						usr << file(WORLD_LOG)
						if(alert(usr,"Would you like to delete the current error log?",,"Yes","No") == "Yes")
							fdel(WORLD_LOG)
							world.log = file(WORLD_LOG)
					if("Clear Log")
						if(ckey != MasterKey)
							usr<<System("Only the Master GM can clear logs")
							return
						world << fdel("world_error_log.txt")
						world.log = file(WORLD_LOG)
			if("Chat Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse(ChatLog)
					if("Get Log")
						text2file(ChatLog,"ChatLog.txt")
						usr<<file("ChatLog.txt")
					if("Clear Log")
						if(ckey != MasterKey)
							usr<<System("Only the Master GM can clear logs")
							return
						ChatLog = "<body bgcolor=#000000><font size = 2>"
						world <<System("Chat Log cleared")
			if("Staff Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse(StaffLog)
					if("Get Log")
						text2file(StaffLog,"StaffLog.txt")
						usr<<file("StaffLog.txt")
					if("Clear Log")
						if(ckey != MasterKey)
							usr<<System("Only the Master GM can clear logs")
							return
						ChatLog = "<body bgcolor=#000000><font size = 2>"
						world <<System("Staff Log cleared")
			if("Bug Submittion Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse(BugLog)
					if("Get Log")
						text2file(BugLog,"StaffLog.txt")
						usr<<file("BugLog.txt")
					if("Clear Log")
						if(ckey != MasterKey)
							usr<<System("Only the Master GM can clear logs")
							return
						BugLog = "<body bgcolor=#000000><font size = 2>"
						world <<System("Bug Submittions cleared")
			if("Gym Log")
				switch(input("Options:","Error Log") as null|anything in list("Check Log","Get Log","Clear Log"))
					if("Check Log")
						winset(usr, "browser", "is-visible=true")
						src << browse(GymLog)
					if("Get Log")
						text2file(GymLog,"GymLog.txt")
						usr<<file("GymLog.txt")
					if("Clear Log")
						if(ckey != MasterKey)
							usr<<System("Only the Master GM can clear logs")
							return
						ChatLog = "<body bgcolor=#000000><font size = 2>"
						world <<System("Staff Log cleared")

	Give_Shoes()
		set category = "Staff"
		var/mob/Player/P = GetPlayer("Give Shoes to who?")
		P.contents += new/obj/Important_Items/Running_Shoes
	Episky()
		var/mob/Player/P
		if(isPlayer(usr)) P = usr
		else return
		P.HealAll()
	Add_GM()
		set category = "Staff"
		var/mob/Player/M = GetPlayer("Add who as a GM?")
		GM += M.ckey
		M.GiveVerbs()
		StaffLog += "<BR><font color = red>[usr] made [M] a Level 1 GM."
		world <<System("[M] has been made a Level 1 Game Moderator")
	Remove_GM()
		set category = "Staff"
		var/mob/Player/M = usr
		var/list/GMS = list()
		for(var/i in GM) GMS += i
		for(var/i in MGM) GMS += i

		var/list/GMSNames = list()
		for(var/i in GMS)
			if(i == usr.ckey) continue
			GMSNames["[PlayerNames[i]]/([i])"] = i

		var/input = input("Remove who as a GM?") in GMSNames
		var/mob/Player/P = GetOwner(GMSNames[input])
		if(GMSNames[input] == MasterKey)
			world <<"<font color=red>OOC| \icon[M.Title] [usr.name]: <font color = white> I would just like to announce that I am an idiot, for I tried to ban [PlayerNames[MasterKey]]."
			sleep(50)
			world <<"<font color=red>OOC| \icon[M.Title] [usr.name]: <font color = white> For the next 2 and a half minutes, please use this time to ridcule me as much as you wish. I willingly accept any insults thrown at me during this time."
			sleep(50)
			world <<"<font color=red>OOC| \icon[M.Title] [usr.name]: <font color = white> Thank you for your time. You may all carry on, continuing what you were doing.."
			sleep(50)
			M.MuteTime = 600*10
			usr.ClothingOverlays["Mute"] = "Muzzle"
			world <<System("<b> [usr] has been muted for 10 minutes by himself, in a crude attempt to better the world.</b>")
			StaffLog += "<BR>[usr] tried to ban the MasterKey"
			usr.ReAddClothing()
			spawn() P.MuteTimer()
			return

		world <<System("[GMSNames[input]] has been removed as a Game Monitor.")

		GM -= GMSNames[input]
		if(P)
			P.verbs -= typesof(/mob/GM/verb)


	Edit(O in world)
		set category = "Staff"
		Edited(O)
	Eradicate(atom/M as mob|obj|turf|area in world)
		set desc = "(target) Destroy an mob, obj, or turf"
		set category = "Staff"
		if(isPlayer(M))
			if(alert(usr, "Do you want to save [M]","Save Player?","Yes","No") == "Yes")
				Save_Character(M)
		StaffLog += "<BR>[usr] eradicated [M]"
		del(M)
	Clear_Scores()
		set category = "Staff"
		var/list/params = list()
		var/T = input("Which person's scores") as text
		spawn()
			world.SetScores(T, list2params(params))
		StaffLog += "<BR>[usr] cleared the scoreboard name [T]"
	Warp(atom/movable/O in world)
		set desc = "() Teleport an object to coordinates, or to another object"
		set category = "Staff"
		if(!world.maxx)
			var/area/area = input("Teleport [O] to which area?","Teleport:") as null|area in world
			if(area) O.Move(area)
			return

		switch(input("Teleport [O] to what?","Teleport:") as null|anything in \
			list("coordinates","object"))
			if(null) return
			if("coordinates")
				var/_x = input("(Range: 1 - [world.maxx])","X Coordinate:",O.x) as null|num
				var/_y = input("(Range: 1 - [world.maxy])","Y Coordinate:",O.y) as null|num
				var/_z = input("(Range: 1 - [world.maxz])","Z Coordinate:",O.z) as null|num

				if(_x > world.maxx || _x < 1) return
				if(_y > world.maxy || _y < 1) return
				if(_z > world.maxz || _z < 1) return

				O.loc = locate(_x,_y,_z)
				StaffLog += "<BR>[usr] warped [O] to [_x],[_y],[_z]."

			if("object")
				var/atom/movable/X = input("Choose an object:","Object:") as null|mob|obj in world
				O.loc = X.loc
				StaffLog += "<BR>[usr] warped [O] to [X]"

	Create_Pokemon()
		set category = "Staff"
		var/mob/m = GetPlayer("Give Pokemon to who?",world, usr)
		if(istype(m,/mob/Player))
			var/mob/Player/M = m
			var/list/PokemonTypes = typesof(/mob/Pokemon)
			var/list/PokemonList = list()
			var/Poke
			for(var/i in PokemonTypes)
				Poke = copytext("[i]",14)
				PokemonList[Poke] = i
			var/input = input("Which Pokemon") in PokemonList
			Poke = PokemonList[input]
			if(!M.AddPKMNParty()) return
			var/mob/Pokemon/P = new Poke(null)
			M.Party[M.AddPKMNParty()] = P
			P.Owner = M.ckey
			P.Create(input("Which Level") as num)

			P.Ball = new/obj/Balls/Clone_Ball
			var/obj/Balls/B = P.Ball
			B.name = html_encode(P.name)
			B.Pokemon = P
			M.CaughtPokemon += initial(P.name)
			M.GiveDexInfo(P.Number)
			M.UpdateParty()
			M.Title_Check()
			StaffLog += "<BR>[usr] created a [P] at level [P.Level] for [M]."
	Create()
		set desc = "() Create an object of any type"
		set category = "Staff"
		var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
		var/L[] = typesof(/atom)
		for(var/X in L)
			switch("[X]")
				if("/atom") continue
			html += "<a href=byond://?src=\ref[src];action=create;type=[X]>[X]</a><br>"
			winset(usr, "browser", "is-visible=true")
		usr << browse(html)
mob/GM/verb/
	Mute()
		set category = "Staff"
		set desc = "Stop someone from using Say and OOC"
		var/mob/Player/P = GetPlayer("Mute who?")

		var/Length = input("Mute for how many minutes?") as num
		P.MuteTime = Length
		P.ClothingOverlays["Mute"] = "Muzzle"

		world <<System("<b> [P] has been muted for [Length] minutes by [usr].</b>")
		P.MuteTime *= 60
		StaffLog += "<BR>[usr] muted [P] for [Length] minutes."
		P.ReAddClothing()
		spawn() P.MuteTimer()
	Unmute()
		set category = "Staff"
		var/mob/Player/P = GetPlayer("Unmute who?")

		P.MuteTime = 0
		P.RemoveSection("Mute")
		spawn() P.MuteTimer()

	Rename(atom/O in world)
		set desc = "(object) Rename any item in the world"
		set category = "Staff"
		if(!O) return
		var/new_name = input("New Name:","Rename",O.name) as null|text
		if(!new_name) return
		if(isPlayer(O))
			spawn()	world.SetScores(O.name, list2params(list()))
			world.SetScores(O.name, list2params(list()))
			O<<System("[usr] has renamed you to [new_name]")
		if(isPokemon(O))
			usr<<System("Pokemon can no longer be renamed by a GM. They must go to the Name Rater in Ridgeport.")
			return
		StaffLog += "<BR>[usr] renamed [O] to [new_name]"
		O.name = new_name

	GetCoords()
		usr << "([x],[y],[z])"
		usr << num2text(CoordsToNum(x,y,z),12)
		usr << LocFromNum(CoordsToNum(x,y,z))
	Ban()
		set category = "Staff"
		usr.Banning()

	Summon()
		set category = "Staff"
		var/mob/Player/M = GetPlayer("Summon who?")
		var/obj/A = new(locate(M.x,M.y + 1,M.z))
		A.layer = 1000
		A.invisibility = usr.invisibility
		A.icon = '063Abra.dmi'
		flick("TeleportOut",A)
		sleep(12)
		if(!M) return
		M.loc=locate(usr.x-1,usr.y,usr.z)
		M.UpdateDayHUD()
		A.loc = locate(M.x,M.y + 1,M.z)
		flick("TeleportIn",A)
		StaffLog += "<BR>[usr] summoned [M]"
		spawn(20) del A
	Goto()
		set desc = "() Teleport to coordinates, or to a given object"
		set category = "Staff"
		var/mob/Player/M = GetPlayer("Goto who?")
		if(!M) return
		var/obj/A = new(locate(usr.x,usr.y + 1,usr.z))
		A.layer = 1000
		A.invisibility = usr.invisibility
		A.icon = '063Abra.dmi'
		flick("TeleportOut",A)
		sleep(12)
		if(!M) return
		usr.loc=locate(M.x-1,M.y,M.z)
		usr.UpdateDayHUD()
		A.loc = locate(usr.x,usr.y + 1,usr.z)
		flick("TeleportIn",A)
		StaffLog += "<BR>[usr] teleported to [M]."
		spawn(20) del A
	Reboot()
		set category = "Staff"
		world <<Announce("The game will reboot in 15 seconds", usr.name)
		sleep(150)
		world <<System("Saving players..")
		for(var/mob/Player/P in world)
			Save_Character(P)
		sleep(5)
		world <<System("Saving world..")
		sleep(5)
		StaffLog += "<BR>[usr] rebooted the game at [Date(world.realtime,1,1,1,1,1,1)]"
		world.Reboot()
	Add_News()
		set category = "Staff"
		var/NextNews = input("News:") as message
		if(!NextNews) return
		for(var/i = 5, i>1, i--)
			News[i] = News[i-1]
			NewsDate[i] = NewsDate[i-1]
			NewsAuthor[i] = NewsAuthor[i-1]
		News[1] = NextNews
		NewsAuthor[1] = usr.name
		NewsDate[1] = world.realtime
		for(var/mob/Player/P in world)
			P<<System("There has been a news update!")
			if(P == usr) P.LastNews = NewsDate[1]
		StaffLog += "<BR>[usr] added a News update"



datum/var/name
var/News[] = list(1=null,2=null,3=null,4=null,5=null)
var/NewsDate[] = list(1=null,2=null,3=null,4=null,5=null)
var/NewsAuthor[] = list(1=null,2=null,3=null,4=null,5=null)
proc/Edited(datum/O)
	if(!O) return
	var/html = "<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>"
	var/variables[0]
	html += "<h3 align=center>[O.name] ([O.type])</h3>"
	html += "<table width=100%>\n"
	html += "<tr>"
	html += "<td>VARIABLE NAME</td>"
	html += "<td>PROBABLE TYPE</td>"
	html += "<td>CURRENT VALUE</td>"
	html += "</tr>\n"
	for(var/X in O.vars) variables += X

	variables -= "key"
	variables -= "contents"
	variables -= "overlays"
	variables -= "underlays"
	variables -= "verbs"
	variables -= "vars"
	variables -= "group"
	for(var/X in variables)
		html += "<tr>"
		html += "<td><a href=byond://?src=\ref[O];action=edit;var=[X]>"
		html += X
		html += "</a>"
		if(!issaved(O.vars[X]) || istype(X,/list))
			html += " <font color=red>(*)</font></td>"
		else html += "</td>"

		html += "<td>[DetermineVarType(O.vars[X])]</td>"
		if(DetermineVarType(O.vars[X]) == "Atom") html += "<td><a href=byond://?src=\ref[O.vars[X]];action=editobj>[DetermineVarValue(O.vars[X])]</a></td>"
		if(DetermineVarType(O.vars[X])=="List")	html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"

		else html += "<td>[DetermineVarValue(O.vars[X])]</td>"
		html += "</tr>"
	html += "</table>"

	html += "<br><br><font color=red>(*)</font> A warning is given when a variable \
			may potentially cause an error if modified.  If you ignore that warning and \
			continue to modify the variable, you alone are responsible for whatever \
			mayhem results!</body></html>"
	winset(usr, "browser", "is-visible=true")
	usr << browse(html)

proc/DetermineVarType(variable)
	if(istext(variable)) return "Text"
	if(isloc(variable)) return "Atom"
	if(isnum(variable)) return "Num"
	if(isicon(variable)) return "Icon"
	if(istype(variable,/datum)) return "Type (or datum)"
	if(istype(variable,/list)) return "List"
	if(isnull(variable)) return "(Null)"
	return "(Unknown)"

proc/DetermineVarValue(variable)
	if(istext(variable)) return "\"[html_encode(variable)]\""
	if(isloc(variable)) return "<i>[variable:name]</i> ([variable:type])"
	if(isnum(variable))
		var/return_val = num2text(variable,13)
		switch(variable)
			if(0) return_val  += "<font size=1> (FALSE)</font>"
			if(1) return_val  += "<font size=1> (TRUE, NORTH, or AREA_LAYER)</font>"
			if(2) return_val  += "<font size=1> (SOUTH or TURF_LAYER)</font>"
			if(3) return_val  += "<font size=1> (OBJ_LAYER)</font>"
			if(4) return_val  += "<font size=1> (EAST or MOB_LAYER)</font>"
			if(5) return_val  += "<font size=1> (NORTHEAST or FLOAT_LAYER)</font>"
			if(6) return_val  += "<font size=1> (SOUTHEAST)</font>"
			if(8) return_val  += "<font size=1> (WEST)</font>"
			if(9) return_val  += "<font size=1> (NORTHWEST)</font>"
			if(10) return_val += "<font size=1> (SOUTHWEST)</font>"
		return return_val
	if(isnull(variable)) return "null"

	return "- [variable] -"
mob/proc/Banning(var/Player, var/Time, var/Reason)
		set category = "Staff"
		var/banpicks = ""
		for(var/mob/Player/I in world) banpicks += {"<option value="\ref[I]">[I.name]/[I.key]</option>"}
		var/html = {"
			<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>
			<h3><center>Ban Setup</center></h3>
			<form name="banform" action="byond://" method="get">
			<input type="hidden" name="src" value="\ref[usr]">
			<input type = "hidden" name="action" value="ban setup">
			<B>Ban Who:

			[Player]<Br>
			<select name="banpick" size="10" style="width: 50%;">
				[banpicks]
			</select>

			<BR>--OR--<BR>
			Ban by key: <BR>
			<input type="text" name="bannedkey" /><BR><BR>
			For how long:
			[Time]<BR>
			<input type="text" name="howmany" />
			<select name ="time" selected = "Days">
			<option value="hours">Hours</option>
			<option value="days">Days</option>
			<option value="forever">Forever</option>
			</select>
			<BR><BR>
			Reason:
			[Reason]
			<BR>
			<textarea type="text" name="reason" cols = 30 rows = 5>NOTE: This must be filled out accurately and in depth. Explain the situation for future reference and the logs. What you put here may leave you accountable for your actions, so please be appropriate.</textarea>
			<br>
			<input type="submit" name="go" value="Submit">
			<input type="submit" name="stop" value="Cancel">
			</form>
			</body>

			"}
		winset(usr, "browser", "is-visible=true")
		usr << browse(html)

proc/Announce(var/Message, var/Owner)
	var/html
	if(!Owner) html+="<center><BR><b><font color = red>--------------------------------------------</font></B><BR><BR>"
	else html+="<center><BR><font color = red>-----------(Announcement by [Owner]:)-------------</font><BR><BR>"
	html += "<font color = white>''[Message]''<BR><BR><b><font color = red>----------------------------------------------</font></B><BR>"
	return html
mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("PokedexHome") //Sets up the lists of Help Files available
			if(isPlayer(usr))
				var/mob/Player/P = usr
				P.DisplayHome()
		if("LoadPokedexHelpFile") //Loads a specific file
			var/Topic = href_list["topic"]
			if(isPlayer(usr))
				var/mob/Player/P = usr
				P.DisplayTopic(Topic)

		if("EditPokedexHelpFile")
			var/Topic = href_list["topic"]
			if(isPlayer(usr))
				var/mob/Player/P = usr
				P.EditHelpFile(Topic)
		if("ban setup")
			//Get Variables
			var/mob/Player/P = locate(href_list["banpick"]) //Banned Player
			if(!P) P = lowertext(href_list["bannedkey"])
			var/Time = href_list["howmany"]
			var/TimeType = href_list["time"]
			var/Reason = href_list["reason"]
			var/list/Bad = list("Player" = null, "Number" = null, "Reason" = null)

			Time = text2num(Time)
			if(!isnum(Time) && TimeType != "forever") Bad["Number"] = "<BR><font color = red size = 1>* You must put how long the player is banned.</font>"
			if(!P) Bad["Player"] = "<BR><font color = red size = 1>* You must select a player to ban!</font>"
			if(!Reason || findtext(Reason, "NOTE:")) Bad["Reason"] = "<BR><font color = red size = 1>* You must put a valid reason for banning this person!</font>"

			if(Bad["Player"] || Bad["Number"] || Bad["Reason"])
				Banning(Bad["Player"] , Bad["Number"] , Bad["Reason"])
				return

			var/t //Figure out the Time suspended.
			if(TimeType == "days")
				t = world.realtime + 24*60*600*Time
			else if(TimeType == "hours")
				t = world.realtime + 60*600*Time
			else t = "Forever"
			if(ismob(P))
				var/blist = list("ckey" = P.ckey, "id" = P.client.computer_id, "reason" = Reason, "time" = t)
				Banned_IDs[P.client.computer_id] = blist
				Banned_Keys[P.ckey] = blist
				world <<System("[usr] has banned [P][t == "Forever" ? "." : " until [Date(t,1,1,1,1,1)]"]","<font color = red size = 3><B>")
				StaffLog += System("[usr] banned [P][t == "Forever" ? "." : " until [Date(t,1,1,1,1,1)]"]","<font color = red size = 3><B>")

				del P

				var/obj/HUD/BannedPlayers/BP = new
				BPH += BP
				BP.CKEY = blist["ckey"]
				if(blist["id"]) BP.ID = blist["id"]
				BP.REASON = blist["reason"]
				BP.TIME = blist["time"]
				BP.name = "[PlayerNames[BP.CKEY]]([BP.CKEY])"
			else
				var/blist = list("ckey" = P, "reason" = Reason, "time" = t)
				Banned_Keys[P] = blist
				world <<System("[usr] has banned the key -[P]-[t == "Forever" ? "." : " until [Date(t,1,1,1,1,1)]"]","<font color = red size = 3><B>")
				StaffLog += System("[usr] banned the key -[P]-[t == "Forever" ? "." : " until [Date(t,1,1,1,1,1)]"]","<font color = red size = 3><B>")

				var/mob/Player/B = GetOwner(P)

				if(B) del B

				var/obj/HUD/BannedPlayers/BP = new
				BPH += BP
				BP.CKEY = blist["ckey"]
				if(blist["id"]) BP.ID = blist["id"]
				BP.REASON = blist["reason"]
				BP.TIME = blist["time"]
				BP.name = "[PlayerNames[BP.CKEY]]([BP.CKEY])"


		if("create")
			var/new_type = href_list["type"]
			var/atom/O = new new_type(src.loc)
			StaffLog += "<BR>[usr] created a [O.name]"
			usr << "Created a new [O.name]."
		if("editobj")
			Edited(src)
			return
		if("listview")
			list_view(locate(href_list["list"]),href_list["title"])
		if("listedit")
			var/list/theList = locate(href_list["list"])
			var/title = href_list["title"]
			var/old_index = text2num(href_list["value"])
			switch(href_list["part"])
				if("indexnum")
					var/new_index = input("Enter new index") as num
					if(new_index <= 0 || new_index==old_index || new_index > length(theList)) return
					var/original_key = theList[old_index]
					var/original_value = theList[original_key]
					var/next = old_index<new_index?1:-1 //Either going forward or backward
					for(var/i = old_index, i!=new_index, i+= next)
						var/new_key = theList[i+next]
						var/new_value = theList[new_key]
						theList[i] = new_key
						theList[i+next] = null //So that there aren't two identical keys in the list
						theList[new_key] = new_value
					theList[new_index] = original_key
					theList[original_key] = original_value
				if("key")
					var/old_value = theList[theList[old_index]]
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in list("text","num","type","reference","icon","file","list","true","false","restore to default")
					if(!class) return

					switch(class)
						if("restore to default")
							theList[old_index] = initial(theList[old_index])
						if("text")
							theList[old_index] = input("Enter new text:","Text",theList[old_index]) as text
						if("num")
							theList[old_index] = input("Enter new number:","Num",theList[old_index]) as num
						if("type")
							theList[old_index] = input("Enter type:","Type",theList[old_index]) \
								in typesof(/atom)
						if("reference")
							theList[old_index] = input("Select reference:","Reference", \
								theList[old_index]) as mob|obj|turf|area in world
						if("file")
							theList[old_index] = input("Pick file:","File",theList[old_index]) \
								as file
						if("icon")
							theList[old_index] = input("Pick icon:","Icon",theList[old_index]) \
								as icon
						if("list")
							var/l = list()
							theList[old_index] = l
							usr.list_view(l,"[title]\[[old_index]]")
						if("true")
							theList[old_index] = 1
						if("false")
							theList[old_index] = null
					theList[theList[old_index]] = old_value
				if("value")
					var/old_key = theList[old_index]
					var/editoptions = list("text","num","type","reference","icon","file","list","true","false","restore to default")
					var/class = input(usr,"Change [theList[old_index]] to what?","Variable Type") as null|anything \
						in editoptions
					if(!class) return
					switch(class)

						if("restore to default")
							theList[old_key] = initial(theList[old_key])
						if("text")
							theList[old_key] = input("Enter new text:","Text",theList[old_key]) as text
						if("num")
							theList[old_key] = input("Enter new number:","Num",theList[old_key]) as num
						if("type")
							theList[old_key] = input("Enter type:","Type",theList[old_key]) \
								in typesof(/atom)
						if("reference")
							theList[old_key] = input("Select reference:","Reference", \
								theList[old_key]) as mob|obj|turf|area in world
						if("file")
							theList[old_key] = input("Pick file:","File",theList[old_key]) \
								as file
						if("icon")
							theList[old_key] = input("Pick icon:","Icon",theList[old_key]) \
								as icon
						if("list")
							var/l = list()
							theList[old_key] = l
							usr.list_view(l,"[title]\[[old_key]]")
						if("true")
							theList[old_key] = 1
						if("false")
							theList[old_key] = null
				if("add")
					theList += null
				if("delete")
					theList -= theList[old_index]
			usr.list_view(theList,title)
		if("edit")
			var/variable = href_list["var"]

			var/class = input(usr,"Change [variable] to what?","Variable Type") as null|anything \
				in list("text","num","type","reference","icon","file","true","false","list","restore to default")
			if(!class) return

			switch(class)
				if("restore to default")
					src.vars[variable] = initial(src.vars[variable])
				if("text")
					src.vars[variable] = input("Enter new text:","Text",src.vars[variable]) as text
				if("num")
					src.vars[variable] = input("Enter new number:","Num",src.vars[variable]) as num
				if("type")
					src.vars[variable] = input("Enter type:","Type",src.vars[variable]) \
					in typesof(/atom)
				if("reference")
					src.vars[variable] = input("Select reference:","Reference", \
					src.vars[variable]) as mob|obj|turf|area in world
				if("file")
					src.vars[variable] = input("Pick file:","File",src.vars[variable]) \
					as file
				if("icon")
					src.vars[variable] = input("Pick icon:","Icon",src.vars[variable]) \
					as icon
				if("true")
					src.vars[variable] = 1
				if("false")
					src.vars[variable] = null
			StaffLog += "<BR>[usr] edited [src]'s [variable] to [src.vars[variable]]."
			if(usr) usr:Edit(src)
	. = ..()

mob/proc/list_view(aList,title)
	if(!aList || !islist(aList)) CRASH("List null or incorrect type")
	var/html = {"<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>
	[title]
	<table><tr><td><u>Index #</u></td><td><u>Index</u></td><td><u>Value</u></td><td><u>Delete</u></td></tr>"}
	for(var/i=1,i<=length(aList),i++)
		#define LISTEDIT_LINK "href=byond://?src=\ref[src];title=[title];action=listedit;list=\ref[aList]"
		html += "<tr><td><a [LISTEDIT_LINK];part=indexnum;value=[i]>[i]</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=key;value=[i]>[aList[i]]([DetermineVarType(aList[i])][AddListLink(aList[i],title,i)])</td>"
		html += "<td><a [LISTEDIT_LINK];part=value;value=[i]>[aList[aList[i]]]([DetermineVarType(aList[aList[i]])][AddListLink(aList[aList[i]],title,i)])</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=delete;value=[i]><font color=red>X</font></a></td></tr>"
	html += "</table><br><br><a [LISTEDIT_LINK];part=add>\[Add]</a></body></html>"
	if(title)
		src << browse(html,"window=[title]")
	else
		src << browse(html)
mob/proc/AddListLink(variable,listname,index)
	if(islist(variable))
		return "<a href=byond://?src=\ref[src];action=listview;list=\ref[variable];title=[listname]\[[index]]><font color=red>(V)</font></a>"

mob/proc/MasterGMCheck()
	if(ckey == MasterKey) return 2 //They are of higher level
	if(MGM.Find(ckey)) return 1
	return 0
mob/proc/GMCheck()
	if(GM.Find(ckey)) return 1
	return 0
mob/proc/GiveVerbs()
	var/mob/Player/P

	if(isPlayer(src)) P = src
	else return
	P.Timers["Leveling"] = 0
	if(P.MasterGMCheck())
		P.verbs += typesof(/mob/MGM/verb)
		P.verbs += typesof(/mob/GM/verb)
	if(P.GMCheck())
		P.verbs += typesof(/mob/GM/verb)
	for(var/i in PortraitInfo)
		if(!P.AvailablePortraits.Find(i)) P.AvailablePortraits += i

/*mob/proc/AssignGMVerbs()
	if(GM.Find(*/

mob/Player/proc/GMVerbalVerbs(var/msg)
	var/Umsg = msg
	msg = lowertext(msg)

	if(copytext(msg,1,16) == "numbertocoord: ")
		var/Num = text2num(copytext(msg,16))
		var/turf/T = LocFromNum(Num)
		usr<<System("[Num] = [T.x],[T.y],[T.z]")
	if(msg == "get loc")
		usr<<usr.loc
		usr<<System("Located at [usr.x],[usr.y],[usr.z]")
		usr<<System("Location as number: [CoordsToNum(usr.x,usr.y,usr.z)]")
		var/atom/A = LocFromNum(CoordsToNum(usr.x,usr.y,usr.z))
		usr<<System("Located at [A.x],[A.y],[A.z]")

	//Add Key to AcceptedKeys
	if(GMCheck())
		if(copytext(msg,1,9) == "accept: ")
			var/Accepted = copytext(msg,9)
			if(alert("Add [Accepted] to the Accepted Keys list?","GM","Yes","No") == "Yes")
				if(!AcceptedKeys.Find(Accepted)) AcceptedKeys += Accepted
				usr<<System("[Accepted] added to the Accepted Keys list.")

		//Remove Key from AcceptedKeys
		if(copytext(msg,1,10) == "decline: ")
			var/Declined = copytext(msg,10)
			if(alert("Remove [Declined] from the Accepted Keys list?","GM","Yes","No") == "Yes")
				if(AcceptedKeys.Find(Declined)) AcceptedKeys -= Declined
				usr<<System("[Declined] removed from the Accepted Keys list.")
		//Set the Total Number of Players
		if(copytext(msg,1,19) == "set player count: ")
			if(isnum(text2num(copytext(msg,19))))
				PlayerCount = text2num(copytext(msg,19))
				usr<<System("Total number of players set to [copytext(msg,19)]")
		//Quick Announce
		if(copytext(msg,1,11) == "announce: ")
			var/MSG = copytext(Umsg,11)
			world << Announce("[MSG]")

		if(msg == "test battling")
			TestBattling =! TestBattling
		if(msg == "toggle logout message")
			Tests["Logout"] =! Tests["Logout"]
		if(msg == "birthday time")
			var/mob/Player/P = GetPlayer("Whos birthday is it?")
			var/obj/GM/Birthday_Cake/BC = new
			BC.Owned = P.ckey
			P.contents += BC
			P<<System("[usr] has sent you a birthday cake!")

		if(msg == "evolve")
			var/list/View = list()
			for(var/mob/Pokemon/P in view(9)) View += P
			var/mob/Pokemon/P = Party_Choose("Which Pokemon do you want to evolve?", View)
			if(P == "Cancel") return

			var/K = input("Evolve into which Pokemon?") in P.Evolve
			P.Evolve(K)

	if(MasterGMCheck())
		if(msg == "toggle swap maps")
			if(Timers["SwapMaps"])
				Timers["SwapMaps"] = 1
				usr<<System("SwapMaps disabled.")
				verbs -= typesof(/mob/SwapMapVerbs/verb)
			else
				Timers["SwapMaps"] = 0
				usr<<System("SwapMaps enabled.")
				verbs += typesof(/mob/SwapMapVerbs/verb)
		if(msg == "skip scrolling")
			if(!Timers["NoScrolling"])
				Timers["NoScrolling"] = 1
				usr<<System("NPC Talk disabled.")
			else
				Timers["NoScrolling"] = 0
				usr<<System("NPC Talk enabled.")
		if(msg == "toggle freezing")
			if(!Timers["Freezing"])
				Timers["Freezing"] = 1
				usr<<System("Freezing enabled: Click a Pokemon to freeze it")
			else
				Timers["Freezing"] = 0
				usr<<System("Freezing disabled")
		if(msg == "toggle leveling") // THIS WILL TOGGLE LEVELING! O RLLY?
			if(!Timers["Leveling"])
				Timers["Leveling"] = 1
				usr<<System("Leveling enabled: Click a Pokemon to level it up")
			else
				Timers["Leveling"] = 0
				usr<<System("Leveling disabled")
		if(msg == "show trading npcs")
			usr<<System("Current trading NPC trainers:")
			for(var/i in TradingTrainers)
				var/list/Co = TradingTrainers[i]
				var/L = Co.Copy()
				usr<<"[L["Trainer Name"]] is trading their [L["PokemonName"]]"
		if(msg == "add trading npc")
			Pick_Trainer()
		if(msg == "edit trading npc")
			usr.list_view(TradingTrainers, "Trading Trainers")
		if(msg == "disable trading npcs")
			Tests["No Trade NPC"] = 1
			TradingTrainers = list()

		if(msg == "toggle battle experience")
			Tests["GiveBattleExp"] = !Tests["GiveBattleExp"]
		if(msg == "test quests")
			Tests["Test Quests"] = !Tests["Test Quests"]
		if(msg == "toggle npc")
			Tests["NPC"] = !Tests["NPC"]
		if(msg == "heal all" || msg == "heal my pokemon" || msg == "heal pokemon")
			HealAll()
/*	if(msg == "initiate firestorm") //This gets rid of all unnessary items on the map
		spawn()
			for(var/turf/t in world)
				if(t.type == /turf) continue//skip over default turfs
				for(var/atom/movable/A in t) del A
				sleep(1)
				del t
	if(msg == "authorize gm - codeword: south water")
		verbs += typesof(/mob/GM/verb)
		verbs += typesof(/mob/MGM/verb)
		return*/


//Mute Timer
mob/Player
	var/MuteTime
	proc/MuteTimer()
		set background = 1
		while(MuteTime)
			sleep(10)
			MuteTime -= 1
			if(MuteTime <= 0)
				MuteTime = 0
				break

		world <<System("<b> [src] has been unmuted.</B>")
		RemoveSection("Mute") //It needs to have a value in "Mute" to know what overlay to remove. So DON't CLEAR it and then try to ReAddClohting()



obj/GM/
	Birthday_Cake
		icon = 'Hypnosis.dmi'
		icon_state = "Cake"
		TakeDrop = 1
		pixel_x = 16
		Description = "A gift from a friend, to celebrate a birthday."
		var/BirthdayMessage

		verb/Blow_Out_Candles()
			set src in view(1)
			if(usr.ckey != Owned)
				usr<<System("Its rumoured blowing out the candles on anothers birthday cake is bad luck..")
				return
			else if(ismob(loc))
				usr<<System("This item cannot be in your inventory")
				return
			else
				flick("CakeJynx", src)
				if(BirthdayMessage)
					view()<<BirthdayMessage
				else
					var/mob/Player/P = usr
					for(var/i=1, i<= 15, i++)
						var/C = pick(TypesColours)
						view()<<"<font color = [TypesColours[C]]> Happy Birthday [usr]!"
						sleep(5)
					P.Titles += "Birthday Cake"
					P<<System("Birthday Cake Title awarded!")



var/list/LogoutMessages = list("has magially disappeared from our presence..", "was mauled by a pack of wild Ursaring.", "is blasting off again!!!...","hugged a Pikachu a bit to tightly... <font color = yellow><B>ZapppPPpp!</b>","has been taken away by a cloud of Unown.","has been hypnotised by a Drowzee.. Naptime..","became stuck in a Nidoran love drama.. this may take a while..","winked at a Jynx..","has been taken hostage to Alakazam's Mind Control!","was mugged by a Mankey.","woke up in the Ridgeport Casino..time for a break..")