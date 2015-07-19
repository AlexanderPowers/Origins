mob/
	see_in_dark = 11
	var/
		tmp/frozen = 0 // Are the able to move or not?
		Money = 0
		MomPercent = 0 //This is a percentage of money gained by the player, that is automaticlly sent to their mother. (Bank)
		MomBank = 0
		Event_Tokens = 0
	//	Alert //This is so that you can only do one alert at a time
		HP = 100
		MHP = 100
		DieLoc = "X156Y156Z2" //This is the Lexus Valley Pokemon Center

		//Speed Delay
		tmp/Speeding = 0
		tmp/NoRunDelay
		tmp/RunningShoes = 0
		tmp/RunDelay = 3
		tmp/MustStep = 0
		tmp/Fishing = 0

		tmp/Following[2]
		tmp/Follow = 0
		Bag = "Normal"
		SavedX
		SavedY
		SavedZ
		Skin = "White" //Black or White?
		HairStyle = "Brandon"
		HairColour = "White"
		Ricon = 'MaleWhiteBase.dmi'
		list/NPCTrades = list() //Saves the Pokemon traded to the NPC
		list/NPCTradeTimes = list() //Saves the time last traded. Can't trade within 5 hours of person trading with you.

		tmp/sound/Playing


		//Battles
		//obj/Team/Team
		tmp/
			mob/Partner
			mob/Watcher/Watcher
			obj/Battling/Court/Court
			mob/Pokemon/ControlingPokemon //This is the pokemon that the user is controling.

		list/
			Wins = list()
			Loses = list()
			NPCWins = list()
			tmp/Challenges = list()



mob/Player
	icon = 'MaleWhiteBase.dmi'
	layer = 30
	HP = 100
	MHP = 100
	name = "????"
	var/
		Steps
		LastNews
		BerryParty[6]
		Party[6]
		StartTime = null

		NPCTimes = list()
		tmp/mob/Pokemon/FightingPokemon //This is the wild pokemon that the person is fighting. No other pokemon will appear if this is TRUE.
		tmp/mob/Pokemon/Trading //This is the pokemon that is subject to a trade
		tmp/PokeballThrow

		list/Badges = list("Whirlpool" = null, "Magnet" = null, "Tectonic" = null, "Pyro" = null, "Herb" = null,"Combat" = null, "Sky" = null)
		list/AvailablePortraits = list()
		list/tmp/TEMPPORT = list()
		list/IgnoredKeys = list()
		list/FriendKeys = list()
		tmp/mob/Player/PrivateChat = null

		list/Timers = list()

		Karma = 0
		tmp/AFK = 0




		tmp/Attacks[] = list(1 = null, 2 = null, 3 = null, 4 = null, 5 = null, 6 = null)



		LastHealed

	Login()
		return 0 //This is to prevent the Red Room Glitch. This way, Players mobs can be saved to another Players Savefile
				 //Without the fear of them rolling back.
	Move(loc,dir)
		if(Following[1] && ismob(Following[1]) && !ControlingPokemon && !PathFinding)
			var/mob/F = Following[1]

			for(var/i = 1, i <= 3, i++)
				spawn(3*i)
					var/atom/GO = get_step(src, turn(src.dir,180))
					step_towards(F,GO)
					if(F.loc == GO) break

			if(get_dist(src,F) >= 5)
				F.loc = get_step(src, turn(src.dir,180))
				F.dir = get_dir(src, F)


		if(AFK)
			AFK = 0
			icon_state = "Male Base"
			DaycareLogin()
		if(Trading)	Trading = null
		if(HP <= 0 || Fishing || ClothingOverlays["Shackle"]) return 0

		if(FightingPokemon)
			if(FightingPokemon.Owner || !FightingPokemon.loc || get_dist(src,FightingPokemon) >= 11) FightingPokemon = null

		if(ControlingPokemon && !PathFinding)

			if(get_dist(get_step(ControlingPokemon,dir),usr.client.eye) < 9 )

				if(!ControlingPokemon.Rolling)
					if(prob(80)) step(ControlingPokemon,dir) //This is for rollout. It doesn't step them forward but changes the direction.
				else ControlingPokemon.dir = dir
		//	src.base_StepTowards(ControlingPokemon,0, 100)
			return 0

		if(!ControlingPokemon)

			if(length(TalkingTo) || Round) return 0

		if(Watcher) //They are watching a battle as the trainer, or an actual observer.
			if(Court) return 0 //They are the Battler, so no moving.
			else if(!HP) return 0
			else
				step(Watcher, dir)
				return 0

		if(Speeding == 0)
			Speeding = 1
			..()

			//These are checks that need to be made after the step has been made.
			if(!ControlingPokemon && !Watcher)
				Steps +=1
				for(var/mob/Pokemon/P in Party) if(istype(P.Ball,/obj/Balls/Egg))
					P.EggSteps -= 1
					if(P.EggSteps <= 0)
						P.Hatch()
						return
				if(Steps == 600)
					for(var/mob/Pokemon/P in Party) P.Happiness_Check(1)
					Steps = 0
			//-----------------------------------------------------------------------
			if(RunningShoes && z == 5) sleep(1)
			else if(!NoRunDelay) sleep(RunDelay)
			Speeding = 0
	Click()
		var/href = "src=\ref[src];action=Stats"
		Topic(href,params2list(href))
	Topic(href,href_list[])
		..()
		var/mob/Player/USR
		if(istype(usr,/mob/Player)) USR = usr
		if(!USR) return
		switch(href_list["action"])
			if("Chat")
				var/mob/Player/P = locate(href_list["friend"])
				//if(P == usr || src != usr) return
				if(istype(P,/mob/Player))
					winset(src, "PickFriend", "text='[P.name]'")
					PrivateChat = P
				else
					winset(usr, "PickFriend", "text='Private Chat'")
					PrivateChat = null
			if("FoundP")
				Portrait = text2num(href_list["portrait"])
				for(var/i in TEMPPORT)
					if(TEMPPORT[i] == Portrait)
						Portrait = i

				var/H= "src=\ref[src];action=Stats"
				Topic(H,params2list(H))
			if("ChangePortrait") //Only the src should be able to call this, and it generates a list for portraits in which they can choose from
				winset(usr, "browser", "is-visible=true")
				var/html = "<BODY link=black alink=marroon vlink=marroon BGCOLOR=black TEXT=black><table BGCOLOR=Marroon Border=1 Bordercolor=black Width=500>" //Cr
				var/Counter
				for(var/i in AvailablePortraits)
					Counter += 1
					TEMPPORT[i] = Counter
					//usr<<browse_rsc(i, "Portrait[Counter].png")
					html+= "<TR><TD width = 64><a href=?src=\ref[src];action=FoundP;portrait=[Counter]><IMG SRC=Portrait[Counter].png ALT = Change Portrait WIDTH=64 HEIGHT=64></a><TD>[PortraitInfo[i]]<br>Unlocked: [AvailablePortraits[i]]</tr>"
				html += "</table>"
				usr<<browse(html)
			if("Stats") //Whoever called this, wants to look at their Player Profile
				winset(usr, "TrainerInformation", "is-visible=true")
				//TrainerInformation
				winset(usr, "TrainerInformation.ProfileAvatar", "image=[Portrait]")
				winset(usr, "TrainerInformation.ProfileName", "text='[name]'")
				winset(usr, "TrainerInformation.ProfileStartedPlaying", "text='Started: [time2text(StartTime,"Month DD, YYYY")]'")
				winset(usr, "TrainerInformation.ProfileKey", "text='Key: [key]'")
				//TrainerBattles
				var/Win = 0
				var/Lose = 0
				var/list/Players = list()
				var/items = 0

				for(var/i in Wins)
					Win += Wins[i]
					if(!Wins[i]) Wins[i] = 0
					Players[i] = 1

				for(var/i in Loses)
					Lose += Loses[i]
					if(!Loses[i]) Loses[i] = 0
					Players[i] = 1


				winset(usr, "BattlesGrid", "current-cell=1,[++items]")
				usr << output("Player", "BattlesGrid")
				winset(usr, "BattlesGrid", "current-cell=2,[items]")
				usr << output("Wins", "BattlesGrid")
				winset(usr, "BattlesGrid", "current-cell=3,[items]")
				usr << output("Loses", "BattlesGrid")

				for(var/i in Players)
					if(PlayerNames[i])
						winset(usr, "BattlesGrid", "current-cell=1,[++items]")
						usr << output("[PlayerNames[i]] ([i])", "BattlesGrid")
						winset(usr, "BattlesGrid", "current-cell=2,[items]")
						usr << output("[Wins[i]?  "[Wins[i]]":"0"]", "BattlesGrid")
						winset(usr, "BattlesGrid", "current-cell=3,[items]")
						usr << output("[Loses[i]?  "[Loses[i]]":"0"]", "BattlesGrid")
				winset(src, "BattlesGrid", "cells=3x[items]")	// cut off any remaining rows



				//Achievments
				for(var/i in Badges)
					if(Badges[i])
						var/icon/I = new('Badges.dmi', i)
						var/iconfile = fcopy_rsc(I)
						winset(usr, "TrainerAchievements.[i]Badge", "image=\ref[iconfile]")
					else
						winset(usr, "TrainerAchievements.[i]Badge", "image=''")
				items = 0
				for(var/obj/Badge/B in PlayerBadges)
					winset(usr, "PlayerBadges", "current-cell=1,[++items]")
					usr << output(B, "PlayerBadges")
					winset(usr, "PlayerBadges", "current-cell=2,[items]")
					usr << output("Recieved from [PlayerNames[B.Giver]]", "PlayerBadges")
					winset(usr, "PlayerBadges", "text-color=black")


				//TrainerPokemon
				var/BlackLength = 12
				var/TotalLevels
				var/TotalPokemon
				for(var/i = 1, i <= 6, i++)
					var/mob/Pokemon/P = Party[i]
					if(!isPokemon(P)) //There is no Pokemon in this slot
						winset(usr, "TrainerPokemon.[i]", "is-visible=false")
						winset(usr, "TrainerPokemon.[i]Image", "is-visible=false")
						winset(usr, "TrainerPokemon.[i]Name", "is-visible=false")
						winset(usr, "TrainerPokemon.[i]Level", "is-visible=false")
						winset(usr, "TrainerPokemon.[i]Type1", "is-visible=false")
						winset(usr, "TrainerPokemon.[i]Type2", "is-visible=false")
					else
						TotalLevels += P.Level
						TotalPokemon += 1
						BlackLength += 70
						winset(usr, "TrainerPokemon.[i]", "is-visible=true")
						winset(usr, "TrainerPokemon.[i]Image", "is-visible=true")
						winset(usr, "TrainerPokemon.[i]Name", "is-visible=true")
						winset(usr, "TrainerPokemon.[i]Level", "is-visible=true")
						winset(usr, "TrainerPokemon.[i]Type1", "is-visible=true")
						winset(usr, "TrainerPokemon.[i]Type2", "is-visible=true")

						winset(usr, "TrainerPokemon.[i]Image", "image='[P.Number].png'")
						winset(usr, "TrainerPokemon.[i]Name", "text='[P.name]'")
						winset(usr, "TrainerPokemon.[i]Level", "text='[P.Level]'")
						if(P.Type1 && P.Type2)
							winset(usr, "TrainerPokemon.[i]Type1", "background-color='[TypesColours[P.Type1]]'")
							winset(usr, "TrainerPokemon.[i]Type1", "text='[P.Type1]'")
							winset(usr, "TrainerPokemon.[i]Type2", "background-color='[TypesColours[P.Type2]]'")
							winset(usr, "TrainerPokemon.[i]Type2", "text='[P.Type2]'")
							winset(usr, "TrainerPokemon.[i]Type1", "size='80x32'")
						else
							winset(usr, "TrainerPokemon.[i]Type1", "background-color='[TypesColours[P.Type1]]'")
							winset(usr, "TrainerPokemon.[i]Type1", "text='[P.Type1]'")
							winset(usr, "TrainerPokemon.[i]Type1", "size='160x32'")


				winset(usr, "TrainerPokemon.PartyBlack", "size='424x[BlackLength]'")
				if(TotalPokemon) winset(usr, "TrainerPokemon.PartyTitle", "text=' Party - [TotalPokemon] Pokemon - Average Level: [round(TotalLevels/TotalPokemon)]'")


				/*if(src.name == "????") return
				winset(usr, "browser", "is-visible=true")
				if(!isicon(Portrait)) Portrait = 'Brendan1.png'
				var/r = AvailablePortraits.Find(Portrait)
				//usr<<browse_rsc(Portrait, "Portrait[r][src.name].png")
				var/Port = "<IMG SRC=Portrait[r][src.name].png WIDTH=64 HEIGHT=64>"
				if(usr == src)
					Port = "<a href=?src=\ref[src];action=ChangePortrait style=text-decoration:none><IMG SRC=Portrait[r][src.name].png ALT = Change Portrait WIDTH=64 HEIGHT=64></a>"
				var/html = "<BODY link=black alink=black vlink=black BGCOLOR=black TEXT=black><table BGCOLOR=Marroon Border=1 Bordercolor=black Width=500>" //Creates the Table
				html += "<TR><TD>[Port]</TD><TD WIDTH=500><center><font size = 5>[name]<br><font size = 1>[key]</TR>" //Portrait and Name
				if(usr != src)
					html += "<TR><TD colspan = 2><table cellspacing = 0 border = 0 width = 500><TR>"

					if(USR.FriendKeys.Find(src.ckey)) html += "<TD width = 250><center><a href=?src=\ref[usr];action=RemoveFriend;friend=\ref[src] style=text-decoration:none>Remove Friend</a></td>"
					else html += "<TD width = 250><center><a href=?src=\ref[usr];action=AddFriend;friend=\ref[src] style=text-decoration:none>Add Friend</a></td>"

					if(USR.IgnoredKeys.Find(src.ckey)) html += "<TD width = 250><center><a href=?src=\ref[usr];action=Unignore;friend=\ref[src] style=text-decoration:none>Unignore</a></td></TR>"
					else html += "<TD width = 250><center><a href=?src=\ref[usr];action=Ignore;friend=\ref[src] style=text-decoration:none>Ignore</a></td></TR>"

					html += "</table>"


				//Pokemon Table//----------------
				html += "<TR><TD colspan = 2 >"
				var/PokeImage
				//usr<<browse_rsc(icon('Pokeballs.dmi',"Caught"), "CCC.png")
				if(href_list["PokemonShow"])
					html += "<table cellspacing = 0 border = 1 width = 500><Tr><TD><B><u>Pokemon<TD><B><u>Level<TD><B><u>Type 1<TD><B><u>Type 2</TR>" //Starts the Pokemon Table
					for(var/mob/Pokemon/P in Party)
						PokeImage = "[P.Number]"
						var/obj/Balls/B = P.Ball
						if(istype(B,/obj/Balls/Egg))
							//usr<<browse_rsc(icon(B.icon,B.icon_state), "Egg.png")
							PokeImage = "Egg"
						//else
							//usr<<browse_rsc(icon('PokedexIcons.dmi',"[P.Number]"), "[P.Number].png")

						if(PokeImage == "Egg") html += "<TR bgcolor = black><TD Width = 200><center><img width = 32 height = 32 src = [PokeImage].png>"
						else html += "<TR bgcolor = black ><TD Width = 200><font color = white><img width = 32 height = 32 src = [PokeImage].png>[P.name]<TD><font color = white>[P.Level]<TD [P.Type2?  "":"colspan = 2"]><center><font color = [TypesColours[P.Type1]]>[P.Type1][P.Type2?  "<TD><center><font color = [TypesColours[P.Type2]]>[P.Type2]":""]</tr>" //Fills in the Pokemon Table
					html += "</table>" //Finishs Pokemon Table
					html+="<font size = 1><a href=?src=\ref[src];action=Stats;Battle=[href_list["Battle"]] style=text-decoration:none >Close</a>"

				else
					html+="<table cellspacing = 0 border = 1 width = 500><Tr><TD><B><u><center>Pokemon<TD><B><u><center>Average Level</TR>" //Starts the Pokemon Table
					html+="<Tr><TD><center>"
					var/Levels
					var/C
					for(var/mob/Pokemon/P in Party)
						var/obj/Balls/B = P.Ball
						if(!istype(B,/obj/Balls/Egg))
							html+="<img src = CCC.png>"
							Levels += P.Level
							C+=1
					html += "<TD><center>[round(Levels/C)]"
					html += "</tr></table>"


					html+="<font color = white size = 1><a href=?src=\ref[src];action=Stats;PokemonShow=1;Battle=[href_list["Battle"]] style=text-decoration:none >Expand</a>"

				//Battle Stats Table//-----------------------
				//Find Stats//-------------------------------
				var/Win = 0
				var/list/Players = list()
				for(var/i in Wins)
					Win += Wins[i]
					if(!Wins[i]) Wins[i] = 0

					Players[i] = 1
				var/Lose = 0
				for(var/i in Loses)
					Lose += Loses[i]
					if(!Loses[i]) Loses[i] = 0
					Players[i] = 1

				html += "<BR><BR><table cellspacing=0 border=1 width = 500>"
				if(href_list["Battle"])
					html += "<TR><TD><B><U>Opponent<TD><B>Wins<TD><B>Loses</TR>"
					for(var/i in Players)
						if(PlayerNames[i]) html += "<TR><TD>[PlayerNames[i]]([i])<TD><Center>[Wins[i]?  "[Wins[i]]":"0"]<TD><Center>[Loses[i]?  "[Loses[i]]":"0"]</TR>"
					html += "<TR><TD><TD><Center><B>[Win]<TD><Center><B>[Lose]</TR></table><font size = 1><a href=?src=\ref[src];action=Stats style=text-decoration:none >Close</a>"
				else
					html += "<TR><TD><Center><B>Wins: [Win]<TD><Center><B>Loses: [Lose]</TR></table><font size = 1><a href=?src=\ref[src];action=Stats;Battle=1 style=text-decoration:none >Expand</a>"

				//Gym Badges Table//------------------------------
				html += "<BR><BR><table cellspacing=0 border=1 width = 500><TR>"
				for(var/I in Badges)
					html += "<TD  width = [round(500/length(Badges))]><center>[I]</TD>"
				html += "<TR>"
				for(var/I in Badges)
					//usr<<browse_rsc(icon('Badges.dmi',"[I]"), "[I].png")
					html += "<TD width = [round(500/length(Badges))] bgcolor = black><center><img src = [I].png></TD>"
				html += "<TR>"
				for(var/I in Badges)
					if(Badges[I]) html += "<TD><center>[Badges[I]]</TD>"
					else html += "<TD><center>0</TD>"
				html += "</TR></table>"

				usr<<browse(html)*/




	Stat()
		set background = 1
		statpanel("Stats")
		stat("Time: [GetTime()]")
		stat("Stamina:","[HP]/[MHP]")
		stat("Money:","[Money] Pokedollars")
		if(Event_Tokens) stat("Event Tokens:",Event_Tokens)
		if(client.inactivity >= 1500 & !AFK)
			AFK = world.realtime
			icon_state = "Sleep Base"
			DaycareLogout()
			if(ControlingPokemon) ControlingPokemon.ReturntoBall()
		if(ControlingPokemon)
			statpanel("Pokemon")
			var/mob/Pokemon/P = ControlingPokemon
			stat(P.Ball)
			stat("Level:[P.Level]")
			stat("Experience:[num2text(P.Exp,13)] (XP till next Level: [num2text(P.MExp - P.Exp,13)])")
			stat("")
			stat("--Stats--")
			stat("Attack:",round(P.Stats["ATK"] * TempStatReturn(P.TempStats["ATK"])))
			stat("Defence:",round(P.Stats["DEF"] * TempStatReturn(P.TempStats["DEF"])))
			stat("Special Attack:",round(P.Stats["SPL ATK"] * TempStatReturn(P.TempStats["SPL ATK"])))
			stat("Special Defence:",round(P.Stats["SPL DEF"] * TempStatReturn(P.TempStats["SPL DEF"])))
			stat("Speed:",round(P.Stats["SPD"] * TempStatReturn(P.TempStats["SPD"])))
			stat("")
			stat("--Attacks--")
			var/list/TM = ControlingPokemon.TemporaryMoves["Moves"]
			if(!length(TM)) TM = P.Moves
			for(var/obj/Moves/M in TM)
				stat("[M.PP]/[M.MPP] PP ([M.Type])", M)
		statpanel("Who")
		var/list/AFKs = list()
		var/list/Active = list()
		for(var/mob/Player/M in world)
			if(!client) continue
			if(M.AFK) AFKs += M
			else Active += M
		stat("Players Online:[length(AFKs) + length(Active)]")
		stat("---Active Players---")
		for(var/mob/Player/M in Active)	stat("[M.name]([M.key])")
		if(length(AFKs))
			stat("---AFK Players---")
			for(var/mob/Player/M in AFKs)	stat("[M.name]([M.key])")
	Bump(M)
		if(istype(M,/atom/movable))
			var/atom/movable/A = M
			A.BumpedInto(src)
		if(istype(M,/mob/Player))//|| istype(M,/mob/NPC/Quest/ANewBeggining/Rival_Ray))
			var/mob/Player/m = M
			for(var/obj/deco/Mapping/ProgressStep/PS in m.loc) //This is to stop players from walking over Progres Steps
				return 1
			if(!PathFinding && !m.PathFinding) loc = m.loc
		if(istype(M,/mob/Pokemon))
			var/mob/Pokemon/m = M
			if(m.Owner)
				loc = m.loc

		..()



mob/Player/verb/StopWatch()
	set hidden = 1
	winset(usr, "StopWatch", "is-visible=false")
	del Watcher
	RemoveSection("WatchingBattle")

	TimeHUD.WeatherEffect = null //Remove Weather Overlays
	UpdateDayHUD()

	for(var/obj/Battling/Court/B in world)
		if(B.Watchers.Find(usr))
			B.Watchers -= usr

	if(client) client.eye = src
mob/Player/verb
	Watch_Battle()
		set category = "Commands"
		if(Court || Watcher) return
		var/list/Battles = list("Cancel")
		var/area/A = usr.loc.loc
		for(var/mob/Player/P in A)
			if(P.Court)
				var/obj/Battling/Court/B = P.Court
				var/Team11
				var/Team22
				for(var/mob/M in B.Team1)
					if(!Team11) Team11 += "[M]"
					else Team11 += " + [M]"
				for(var/mob/M in B.Team2)
					if(!Team22) Team22 += "[M]"
					else Team22 += " + [M]"
				var/Title = "[Team11] vs. [Team22]"
				if(Battles.Find(Title)) continue
				else
					Battles[Title] = B
		if(length(Battles) == 1) usr<<System("There are no battles going on in this area.")
		else
			var/obj/Battling/Court/B = input("Watch which battle?") in Battles
			if(B == "Cancel") return
			B = Battles[B]

			var/area/Area = B.loc.loc

			if(Area.WeatherID) //There is a Weather effect that must be applied.
				TimeHUD.WeatherEffect = Area.WeatherID
				UpdateDayHUD()
			B.Watchers += usr
			winset(usr, "StopWatch", "is-visible=true")
			Watcher = new (locate(B.x,B.y + 8,B.z))
			Watcher.icon = icon
			Watcher.icon_state = icon_state
			ItemUsing = null
			Watcher.overlays = overlays
			Watcher.name = name
			Watcher.Owner = src
			client.eye = src
			client.eye = locate(B.x,B.y,B.z)
			client.perspective=EYE_PERSPECTIVE
			ClothingOverlays["WatchingBattle"] = "Eye"
			ReAddClothing()


	News()
		set category = "Commands"
		usr <<browse_rsc('News.png',"News.png")
		winset(usr, "browser", "is-visible=true")
		LastNews = NewsDate[1]
		var/html = {"
<BODY BGCOLOR="black" TEXT="black">
<center>
<TABLE Border=1 BGCOLOR="maroon" Bordercolor="maroon" Align=center width = 500>
<TR><TD><center><IMG SRC="News.png"></center></TD><TR>
<TABLE Border=1 BGCOLOR="maroon" Bordercolor="black" Align=center width = 500>

<TR><TD>Author<TD>Date<TD width = 300>News</TD></TR>"}

		if(News[1]) html += "<TR><TD>[NewsAuthor[1]]<TD>[time2text(NewsDate[1])]<TD width = 350>[News[1]]</TD></TR>"
		if(News[2]) html += "<TR><TD>[NewsAuthor[2]]<TD>[time2text(NewsDate[2])]<TD width = 350>[News[2]]</TD></TR>"
		if(News[3]) html += "<TR><TD>[NewsAuthor[3]]<TD>[time2text(NewsDate[3])]<TD width = 350>[News[3]]</TD></TR>"
		if(News[4]) html += "<TR><TD>[NewsAuthor[4]]<TD>[time2text(NewsDate[4])]<TD width = 350>[News[4]]</TD></TR>"
		if(News[5]) html += "<TR><TD>[NewsAuthor[5]]<TD>[time2text(NewsDate[5])]<TD width = 350>[News[5]]</TD></TR>"
		html += {"</TD>
</TR></TABLE>
</TABLE>
<br>
<font color = white><center>Pokémon Image from: <a href="http://www.arkeis.com"><img src="http://img.photobucket.com/albums/v362/aragornbird/Banners%20and%20Avatars/arkeis_button.jpg" border="0" alt="Image hosted by Photobucket.com"><br></a>
"}
		usr<<browse(html)



//PortraitDescriptions//------------------------
mob/Player/proc/PortraitCheck()
	var/L = length(AvailablePortraits)
	var/
		PartyFlying
		PartyWater
		PartyBug

	for(var/mob/Pokemon/P in Party)
		if(P.Type1 == "Flying" || P.Type2 == "Flying")
			PartyFlying += 1
		if(P.Type1 == "Water" || P.Type2 == "Water")
			PartyWater += 1
		if(P.Type1 == "Bug" || P.Type2 == "Bug")
			PartyBug += 1

	switch(gender)
		if("male")
			if(length(FriendKeys) >= 20 && !AvailablePortraits.Find('CooltrainerMale1.png'))
				AvailablePortraits['CooltrainerMale1.png'] = Date(world.realtime,0,0,1,1,1)
			if(length(FriendKeys) >= 30 && !AvailablePortraits.Find('CooltrainerMale2.png'))
				AvailablePortraits['CooltrainerMale2.png'] = Date(world.realtime,0,0,1,1,1)
			if(PartyWater >= 6)
				AvailablePortraits['MaleSwimmer1.png'] = Date(world.realtime,0,0,1,1,1)
		if("female")
			if(length(FriendKeys) >= 20 && !AvailablePortraits.Find('CooltrainerFemale2.png'))
				AvailablePortraits['CooltrainerFemale2.png'] = Date(world.realtime,0,0,1,1,1)
			if(length(FriendKeys) >= 30 && !AvailablePortraits.Find('CooltrainerFemale2.png'))
				AvailablePortraits['CooltrainerFemale2.png'] = Date(world.realtime,0,0,1,1,1)
			if(PartyWater >= 6)
				AvailablePortraits['FemaleSwimmer1.png'] = Date(world.realtime,0,0,1,1,1)
	if(PartyFlying >= 6)
		AvailablePortraits['Birdkeeper1.png'] = Date(world.realtime,0,0,1,1,1)
	if(PartyBug >= 6)
		AvailablePortraits['Bugcatcher1.png'] = Date(world.realtime,0,0,1,1,1)

	if(length(AvailablePortraits) != L)
		src<<System("You have unlocked a Trainer Portrait!")


var/list/PortraitInfo = list('Brendan1.png' = "Brendan, the Male protagonist of Pokémon Ruby and Saphire.<BR>Unlocked by starting the game.",\
							'May1.png' = "May, the Female protagonist of Pokémon Ruby and Saphire.<BR>Unlocked by starting the game.",\
							'CooltrainerMale1.png' = "A Cool Trainer from Ruby and Saphire.<BR>Unlocked by having 20 friends.",\
							'CooltrainerFemale1.png' = "A Cool Trainer from Ruby and Saphire.<BR>Unlocked by having 20 friends.",\
							'CooltrainerMale2.png' = "A Cool Trainer from FireRed/LeafGreen.<BR>Unlocked by having 30 friends.",\
							'CooltrainerFemale2.png' = "A Cool Trainer from FireRed/LeafGreen.<BR>Unlocked by having 30 friends.",\
							'Tamer.png' = "A Tamer from FireRed/LeafGreen.<BR>Unlocked by having 10 Pokémon.",\
							'Birdkeeper1.png' = "A Birdkeeper from Ruby and Saphire.<BR>Unlocked by having 6 Flying types in party.",\
							'Bugcatcher1.png' = "A Bugcatcher from Ruby and Saphire.<BR>Unlocked by having 6 Bug types in party.",\
							'FemaleSwimmer1.png' = "A Swimmer from Ruby and Saphire.<BR>Unlocked by having 6 Water types in party.",\
							'MaleSwimmer1.png' = "A Swimmer from Ruby and Saphire.<BR>Unlocked by having 6 Water types in party."\

							)


