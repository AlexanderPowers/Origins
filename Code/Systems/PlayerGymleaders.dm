var
	list
		PlayerGyms = list() //Sorted by Type

//Procs//-----------------------------------------------------------------------
proc/FindGym(var/TYPE) //Finds the Gym Datum by type
	for(var/i in PlayerGyms)
		var/PlayerGym/PG = PlayerGyms[i]

		if(PG.Type == TYPE) return PG


mob/proc/GLCheck()
	var/mob/Player/P = src
	if(!isPlayer(P)) return

	for(var/i in PlayerGyms)
		var/PlayerGym/PG = PlayerGyms[i]

		if(PG.Owner == ckey)
			PG.LastLogin = world.realtime
			P.GymType = PG.Type
			P.verbs += typesof(/mob/MGM/PlayerGymVerbs/verb)
			if(!PG.BadgeIcon)
				P.verbs += typesof(/mob/MGM/PlayerGymVerbs/SetBadge/verb)
			return 1
	return 0

mob/proc/GenerateGymInfo()

	var/html = "<BODY BGCOLOR=black TEXT=black><center><table Border=1 BGCOLOR=grey><TR><TD>Gymleader<TD>Type<TD>Description<TD>LastLogin</TR>"

	for(var/i in PlayerGyms)
		var/PlayerGym/PG = PlayerGyms[i]
		var/WeekChallenges = 0
		for(var/j in PG.Challenges)	if(PG.Challenges[j] > world.realtime - 6048000)	WeekChallenges += 1

		html += "<TR BGCOLOR=[TypesColours[PG.Type]]><TD>[PlayerNames[PG.Owner]]<br>([PG.Owner])<TD>[PG.Type]<TD> [PlayerNames[PG.Owner]] has taken [WeekChallenges] challenges in the past week, and [length(PG.Challenges)] challenges overall. [length(PG.Winners)] players have beaten this gymleader to earn their badge.<TD> [time2text(PG.LastLogin)]</TR>"

	html += "</table>"

	winset(src, "browser", "is-visible=true")
	src<<browse(html)


mob/Player/verb/Gymleader_Info()
	usr.GenerateGymInfo()


//Verbs//-------------------------------------------------------------------------
mob/MGM/
	verb
		Manage_Gymleaders()
			set category = "Staff"

			var/input = input("What do you want to do?") in list("Add Gymleader", "Remove Gymleader", "Set Gym Badge","Cancel")
			switch(input)
				if("Cancel") return

				if("Add Gymleader")
					var/list/AvailableTypes = list("Fire","Water","Grass","Electric","Bug", "Flying", "Rock", "Ground", "Steel", "Poison", "Fighting", "Dark", "Dragon", "Normal", "Ice", "Psychic", "Ghost")

					for(var/i in PlayerGyms)
						var/PlayerGym/PG = PlayerGyms[i]
						if(istype(PG,/PlayerGym)) if(PG.Type) AvailableTypes -= PG.Type
						else PlayerGyms -= i

					var/mob/Player/P = GetPlayer("Who do you want to be a Gymleader?")
					if(P.GymType)
						usr<<System("This person is already the leader of the [P.GymType] Gym.")
						return

					var/Type = input("What type of Gym will they lead?") in AvailableTypes

					if(!P || !Type) return

					if(PlayerGyms[Type])
						usr<<System("There currently is already a [Type] Gymleader. Either remove this gymleader from power, or choose another type before continuing.")
						return

					world <<System("[P] has been choosen to lead the [Type] Gym!", "<font color = [TypesColours[Type]]>")


					var/PlayerGym/PG = new
					PG.Owner = P.ckey
					PG.Type = Type

					PlayerGyms[Type] = PG
					P.GLCheck()

				if("Remove Gymleader")
					var/list/Gymleaders = list()
					for(var/i in PlayerGyms)
						var/PlayerGym/PG = PlayerGyms[i]
						if(istype(PG,/PlayerGym)) Gymleaders["[PlayerNames[PG.Owner]]/([PG.Owner])"] = PG
						else PlayerGyms -= i

					var/Gymleader = input("Remove which Gymleader?") in Gymleaders

					var/PlayerGym/PG = Gymleaders[Gymleader]
					world <<System("[PlayerNames[PG.Owner]] has been removed as the leader of the [PG.Type] Gym!", "<font color = [TypesColours[PG.Type]]>")
					var/mob/Player/Owner = GetOwner(PG.Owner)
					if(Owner)
						Owner.GymType = null
						Owner.verbs -= typesof(/mob/MGM/PlayerGymVerbs/verb)

					PlayerGyms -= PG.Type
					if(PG.Building)
						for(var/i in PG.Building.Parts) del i
						del PG.Building

					del PG

				if("Set Gym Badge")
					var/list/Gymleaders = list()
					for(var/i in PlayerGyms)
						var/PlayerGym/PG = PlayerGyms[i]
						Gymleaders["[PlayerNames[PG.Owner]]/([PG.Owner])    [PG.Type] Gym"] = PG

					var/PlayerGym/PG = input("Which Gym Badge are you editing?") in Gymleaders
					PG = Gymleaders[PG]

					PG.BadgeIcon = input("Choose an icon to upload") as icon
					PG.BadgeIcon_state = input("What is the icon_state?") as text
					PG.BadgeName = input("What is the name of the badge?") as text











	PlayerGymVerbs
		verb
			Set_Gym_Location()
				set category = "Gymleader"

				var/mob/Player/P = usr
				if(!isPlayer(P) || !P.GymType) return
				var/PlayerGym/PG = FindGym(P.GymType)

				if(alert(P, "Are you sure you want to move your Gym Location to this spot? You may only move your Gym once a week.",,"Yes","No") == "No") return

				if(P.Timers["ChangeGymLocation"] > world.realtime + 6048000)
					usr<<System("You must wait 7 days inbetween changing your Gym Location. This is to prevent cheating.")
					return
				P.Timers["ChangeZoneTime"] = world.realtime
				if(PG.Building)
					for(var/i in PG.Building.Parts) del i
					del PG.Building

				var/obj/deco/Buildings/Player_Gym/PGB = new (P.loc)
				PG.Building = PGB
				PGB.Construct(P.GymType)
				PG.GymLoc = CoordsToNum(PGB.x, PGB.y, PGB.z)
				GymLog += "<BR><font color = red>[usr] has moved his gym to [PGB.loc]."



			Initiate_Battle()
				set category = "Gymleader"

				var/mob/Player/P = usr
				if(!isPlayer(P) || !P.GymType) return
				var/PlayerGym/PG = FindGym(P.GymType)
				if(!PG) return

				if(P.TalkingTo.Find("OfficalGymBattle")) return
				P.TalkingTo += "OfficalGymBattle"

				var/area/A = P.loc.loc
				if(!istype(A,/area/Towns/PlayerGym))
					P<<System("All Regulation Gymbattles must take place within a Pokemon Gym.")
					P.TalkingTo -= "OfficalGymBattle"
					return

				if(alert("Do you accept that this is an offical gym match, and should your challenger defeat you, they will automatically recieve a badge?",,"Yes","No") == "No")
					P.TalkingTo -= "OfficalGymBattle"
					return


				var/mob/Player/Challenger = GetPlayer("Who is challenging you", view())

				if(alert("Please Note, that accepting this dialog will force [Challenger] into a battle. Are you sure you want to do this?",,"Yes","No") == "No")
					P.TalkingTo -= "OfficalGymBattle"
					return

				for(var/obj/Badge/B in Challenger.PlayerBadges)
					if(B.Giver == P.ckey && B.Type == P.GymType)
						P<<System("Each Challenger can only earn one [P.GymType] Badge. If you wish to battle them, please have an unregulated battle.")
						P.TalkingTo -= "OfficalGymBattle"
						return

				PG.Challenges[Challenger.ckey] = world.realtime
				var/obj/Battling/Court/C
				for(var/obj/Battling/Court/c in world)
					if(!c.Battle && !c.Tournament)
						C = c
						break // We've found a court to play on, no need to continue


				C.Team1 = list(Challenger)
				C.Team2 = list(P)
				C.name = "Gymleader [P] vs. Challenger [Challenger]"

				C.Mob_Set_Up()
				C.Court_Set_Up()
				var/list/W = C.Start_Battle()

				PG.Battles += 1
				GymLog += "<BR><font color = blue>[usr] has had a Gym Battle with [Challenger] at [Date(world.realtime,1,1,1,1,1,1)]."
				if(!Challenger || !P) return //One of the two battling has left the game. Therefore no badges were earned.

				if(W.Find(Challenger)) //The Challenger won
					if(W["Reason"] == "Winner Found") //The Challegner won by defeating all the gymleader's Pokemon, not by
						Challenger << System("You have defeated Gymleader [P] and earned the [P.GymType] Badge!","<font color = [TypesColours[P.GymType]]>")
						var/obj/Badge/B = new
						B.Giver = P.ckey
						B.Type = P.GymType
						B.icon = PG.BadgeIcon
						B.icon_state = PG.BadgeIcon_state
						B.name = "[PG.BadgeName] Badge"
						Challenger.PlayerBadges += B
						PG.Winners += Challenger.ckey
						GymLog += "<BR><font color = blue>[Challenger] has won [usr]'s Gym Badge at [Date(world.realtime,1,1,1,1,1,1)]."



			Lock_Gym()
				set category = "Gymleader"

				var/mob/Player/P = usr
				if(!isPlayer(P) || !P.GymType) return
				var/PlayerGym/PG = FindGym(P.GymType)

				if(PG.Locked)
					PG.Locked = 0
					world <<System("[P] has unlocked the [PG.Type] Gym!", "<font color = [TypesColours[PG.Type]]>")
				else
					PG.Locked = 1
		SetBadge
			verb/Set_Badge()
				set category = "Gymleader"


				var/mob/Player/P = usr
				if(!isPlayer(P) || !P.GymType) return
				var/PlayerGym/PG = FindGym(P.GymType)

				if(P) P.ScrollText("Selecting your Gymbadge", "Before you can do anything as a Gymleader, you must select your Gymbadge. There are default badges available, but you are also welcome to upload your own badge to use. It must be a 16x16 badge centered on a 32x32 pallete. If your badge is deemed inapopriate by any Admin, your badge will be set to the default. You may choose now, or choose later. Once your badge is chosen, you cannot change it.")

				var/input = input("Choose a Gymbadge") in list("Choose Later", "Use Default Badge", "Submit Own Badge Design")
				switch(input)
					if("Choose Later") return

					if("Use Default Badge")
						PG.BadgeIcon = 'Badges.dmi'
						PG.BadgeIcon_state = PG.Type
						P.verbs -= /mob/MGM/PlayerGymVerbs/SetBadge/verb/Set_Badge
						PG.BadgeName = PG.Type

					if("Submit Own Badge Desgin")
						if(P) P.ScrollText("Selecting your Gymbadge", "You must talk to Alexander to have your badge approved currently..")
						return



//The Badge Setup
obj/Badge
	var/Giver //This is saved by ckey
	var/Type





//Player Vars//-------------------------------------
mob/Player/var
	tmp/GymType = null //This is set when the player logs in. If they are removed while offline, it is not given at next login.
	PlayerBadges = list()


PlayerGym
	var/
		Type
		tmp/Locked = 1 //Locked by default
		Owner
		LastLogin
		Challenges = list()

		BadgeIcon
		BadgeIcon_state
		BadgeName

		tmp/obj/deco/Buildings/Player_Gym/Building
		GymLoc

		var/Battles
		var/list/Winners = list()

//Mappable Objects//-------------------------------------------------------------------
obj/deco/Buildings/
	var/Type

	Player_Gym
		var/list/Parts = list()
		icon = 'Gym.dmi'
		icon_state = "PlayerGym"
		density = 0
		proc/Construct(var/Type)
			if(!Type) Type = "Fire"
			var/PlayerGym/PG = FindGym(Type)

			var/obj/deco/Buildings/Gym_Entrance/G = new
			G.loc = locate(x+2,y,z)
			G.Type = Type

			Parts += G

			var/obj/deco/Mapping/Density/D = new(locate(x+2,y,z))
			Parts += D
			for(var/i = 0, i<= 2, i++)
				D = new(locate(x+i,y+1,z))
				Parts += D

			var/obj/deco/Town/Sign/S = new(locate(x+3,y,z))
			Parts += S
			S.layer = 21
			S.icon_state = "Gym Sign"
			S.pixel_y = -16
			S.Message = "[Type] Gym; Run by Gymleader [PlayerNames[PG.Owner]]"

			var/obj/Badge = new(locate(x+2,y,z))
			Badge.icon = PG.BadgeIcon
			Badge.icon_state = PG.BadgeIcon_state
			Badge.layer = 21
			Badge.pixel_y = 8
			Parts += Badge



	Gym_Entrance
		invisibility = 1
		SteppedOn(var/mob/Player/M)
			if(isPlayer(M))
				var/PlayerGym/PG = FindGym(Type)
				if(!PG) return
				M.QuestCheck("TransportStep", "[src.type]")
				if(PG.Locked)
					M<<System("This gym is currently closed. The Gymleader is offline or currently not accepting challenges.")
					return 0

				//if(M.dir != 1) return 0//They will always have to be facing North to get into the building
				for(var/obj/deco/Buildings/Gym_Exit/GE in world)
					if(GE.Type == Type)
						M.frozen = 1
						M.FadetoBlack()
						M.loc = GE.loc
						M.loc = locate(GE.x, GE.y + 1, GE.z)
						M.FadefromBlack()
						M.frozen = 0


			else if(ismob(M)) return 0
			else return 1



	Gym_Exit
		invisibility = 1
		SteppedOn(var/mob/Player/M)
			if(isPlayer(M))
				var/PlayerGym/PG = FindGym(Type)
				if(!PG) return

				for(var/obj/deco/Buildings/Gym_Entrance/GE in world)
					if(GE.Type == Type)
						M.frozen = 1
						M.FadetoBlack()
						M.loc = locate(GE.x, GE.y - 1, GE.z)

						M.FadefromBlack()
						M.frozen = 0


			else if(ismob(M)) return 0
			else return 1

area/Towns/PlayerGym
	luminosity = 1
