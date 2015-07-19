#define TEAM_SAVE "Teams.sav"
var/list/Teams = list() //The Team Datums will be stored here.

mob/var
	Team
	HeadsetFrequency = 91.5

Team

	//----------------------------------------------------------------------------------------------------------------------------------------------------------------
	var/list/Members = list() //Ckey == Rank
	var/list/Unlocked = list() //This is a list of unlocked portions of the base.
	var/list/RankVerbs = list(\
		"Leader" = list(/Team/verb/Add_Member,/Team/verb/Remove_Member,/Team/verb/Change_Rank,/Team/verb/Set_Ranks,/Team/verb/Manage_Bank,/Team/verb/Manage_Teleporter,/Team/verb/Manage_Supplies,/Team/verb/Upgrade_Base,/Team/verb/Establish_Base,/Team/verb/Start_Territory_War),\
		"Co-Leader" = list(/Team/verb/Add_Member,/Team/verb/Remove_Member,/Team/verb/Manage_Bank,/Team/verb/Manage_Teleporter,/Team/verb/Upgrade_Base,/Team/verb/Start_Territory_War),\
		"Builder" = list(/Team/verb/Leave_Team,/Team/verb/Upgrade_Base),\
		"Treasurer" = list(/Team/verb/Leave_Team,/Team/verb/Manage_Bank),\
		"Supplies Manager" = list(/Team/verb/Leave_Team,/Team/verb/Manage_Supplies),\

		"Recruit" = list(/Team/verb/Leave_Team),\
		)

	var/Colour = "white"
	var/Points = 0

	var/Bank = 0
	var/Dues = 2 // This is the percentage that goes from battles to the bank.

	var/list/BaseUpgrades = list()
	var/TeleportPassword
	var/TeamFrequency

	var/BaseLocation
	var/tmp/obj/BaseEntrance




	verb/ //This is all the verbs each member can possible have.
		Add_Member()
			set category = "Teams"
			var/Team/T = Find_Player_Team(usr.Team)

			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Add_Member))
				usr<<System("You don't have permission in this team to use this verb.")
				return
			var/mob/Player/P = GetPlayer(message = "Make who a member of [T.name]?")
			T.Add__Member(P, usr)
		Remove_Member()
			set category = "Teams"
			var/Team/T = Find_Player_Team(usr.Team)

			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Remove_Member))
				usr<<System("You don't have permission in this team to use this verb.")
				return

			T.Remove__Member(T.Generate_Member_List(usr))
		Leave_Team()
			set category = "Teams"
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			var/Team/T = Find_Player_Team(usr.Team)

			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Leave_Team))
				usr<<System("You don't have permission in this team to use this verb.")
				return
			if(alert("Are you sure you want to leave [T]?","Leave Team?", "No", "Yes") == "Yes")
				T.Remove__Member(P.ckey)

		Change_Rank()
			set category = "Teams"
			set desc = "Change the rank of an individual member."
			var/Team/T = Find_Player_Team(usr.Team)
			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Change_Rank))
				usr<<System("You don't have permission in this team to use this verb.")
				return
			var/K = T.Generate_Member_List(usr)
			if(!K) return
			if(T.Members[K] == "Leader")
				usr<<System("You cannot change the Leader's rank.")
			var/NewRank = input(usr, "Which rank should [PlayerNames[K]] be?") in T.RankVerbs
			if(NewRank == "Leader")
				usr<<System("You cannot appoint a new Leader")
			else
				T.Members[K] = NewRank
				T.Change__Rank(K, T.Members[K])
		Establish_Base()
			set category = "Teams"
			var/Team/T = Find_Player_Team(usr.Team)
			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Establish_Base))
				usr<<System("You don't have permission in this team to use this verb.")
				return
			T.Establish__Base(usr)
		Set_Ranks()
			set category = "Teams"
			var/Team/T = Find_Player_Team(usr.Team)
			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Set_Ranks))
				usr<<System("You don't have permission in this team to use this verb.")
				return
			T.Set__Ranks(usr)
		Manage_Bank()
			set category = "Teams"
			set hidden = 1
		Manage_Supplies()
			set category = "Teams"
			set hidden = 1
		Manage_Teleporter()
			set category = "Teams"
			set hidden = 1
		Upgrade_Base()
			set category = "Teams"
			set hidden = 1


	/*	Build_Mode()
			set category = "Teams"
			var/mob/Player/P = usr
			if(!isPlayer(usr)) return
			var/Team/T = Find_Player_Team(usr.Team)
			if(islist(T)) T = input("Which Team?") in T
			var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
			if(!verbs.Find(/Team/verb/Build_Mode))
				usr<<System("You don't have permission in this team to use this verb.")

			P.BaseBuilding = !P.BaseBuilding
			if(P.BaseBuilding)
				P<<System("Base Building toggled ON")

			else
				P<<System("Base Building toggled OFF")

				T.BaseBuilder.Save_Base()
				P<<System("Base Saved")*/








	Team_Inferno //Bad
		name = "Team Inferno"
		Colour = "#990000"
		TeleportPassword = "Blazing"
		TeamFrequency = 78.9
	Team_Static
		name = "Team Static"
		Colour = "#CC9900"
		TeleportPassword = "Thunderstrike"
		TeamFrequency = 103.2
	Team_Tidal
		name = "Team Tidal"
		Colour = "#000099"
		TeleportPassword = "Bubbles"
		TeamFrequency = 96.7

	proc/
		//Used to set the doorway of the base. Can be placed at a water's edge or
		Establish__Base(var/mob/Player/P)
			if(BaseEntrance) del BaseEntrance
			var/obj/BaseObjects/Entrance/E = new(locate(P.x,P.y + 1,P.z))
			BaseLocation = CoordsToNum(E.x, E.y, E.z)
			BaseEntrance = E
			E.Owner = name
			for(var/mob/Player/M in world)
				if(M.Team == name) //They are in the team, they need to see the base.
					if(istype(BaseEntrance.loc, /turf/Routes/Water))
						BaseEntrance.pixel_x = -16
						M.AddScreenOverlay('Submarine.dmi',null,BaseEntrance,"[name] BaseEntrance")
					else
						for(var/obj/O in BaseEntrance.loc)
							if(istype(O,/obj/deco/Cave) && O.icon == 'Cave.dmi' && O.dir == 2)
								BaseEntrance.icon = O.icon
								BaseEntrance.icon_state = O.icon_state
								BaseEntrance.dir = 2
								P.AddScreenOverlay('Cave.dmi',"Base Entrance",BaseEntrance,"[name] BaseEntrance")
								del O





		//Much like staff verbal verbs...
		Team_VerbalVerbs(var/Message, var/mob/Player/P)
			if(P.Headset && usr.ClothingOverlays["Accesories"] == "Headset")
				//Teleportation
				if(lowertext(Message) == lowertext(TeleportPassword) && BaseUpgrades.Find("Teleport Hub") && P.HeadsetFrequency == TeamFrequency)
					if(Get_Active_Members("length") < 5)
						var/Title = 'Headset.png'
						P<<"<B><font color=white>\icon[Title] \[Headset ([P.HeadsetFrequency])] [name] Abra Handler: </b><font color = white> The team must have 5 active members for you to be able to use this feature."
						return
					//They have to say the Password
					//They also have to have the Teleporter Hub purchased
					//They need to be on the Team Frequency
					for(var/mob/NPC/Teams/Abra_Handler/AH in world)
						if(AH.Team == name)
							var/obj/A = new(locate(P.x,P.y + 1,P.z))
							A.layer = 1000
							A.invisibility = usr.invisibility
							A.icon = '063Abra.dmi'
							flick("TeleportOut",A)
							sleep(12)
							if(!P) return
							P.loc=locate(AH.x,AH.y-1,AH.z)
							P.UpdateDayHUD()
							A.loc = locate(P.x + 1,P.y,P.z)
							flick("TeleportIn",A)
							spawn(20) del A


		//Returns a list of members active in the past week. Uses PlayerLastLogin
		Get_Active_Members(var/R = "list")
			var/list/Active = list()
			for(var/i in Members)
				if(world.realtime <= PlayerLoginTimes[i] + 6048000)
					Active += i
			if(R == "length") return length(Active)
			else return Active
		//Runs through this proc when the Player logs in
		//Gives verbs, or kicks them out if they were removed since last logout.
		Team_Login(var/mob/Player/P)
			//Team Battle checker
			var/FindSpawn
			for(var/obj/Teams/PlayerSpawn/PS in P.loc)
				FindSpawn = 1
				break
			var/area/Routes/R = P.loc.loc
			if(FindSpawn)
				if(istype(R))
					if(R.Team1 && R.Team2) //They are battling, put this person in the removed list. Then Spawn them out
						R.PlayerToOther(P , "you logged into an ongoing territory war.")
						R.RemovedPlayers += P.ckey
						//R.verbs -= /Team/verb/Join_Territory_War They don't have this verb yet.
					else R.PlayerToOther(P , "you logged out..")


			//Check to make sure they are still on the team

			if(Members[P.ckey])
				Change__Rank(P.ckey, Get_Rank(P.ckey)) //This should give them verbs
				//If there is a territory war going on, they have the option to join.
				if(ContendingTeams.Find(name))
					P.verbs += /Team/verb/Join_Territory_War
				//If they are the first member to login after the reboot, it creates the base with them
				if(!BaseEntrance)
					var/obj/BaseObjects/Entrance/E = new(LocFromNum(BaseLocation))
					BaseEntrance = E
					E.Owner = name
				if(BaseEntrance)
					if(istype(BaseEntrance.loc, /turf/Routes/Water))
						BaseEntrance.pixel_x = -16
						P.AddScreenOverlay('Submarine.dmi',null,BaseEntrance,"[name] BaseEntrance")
					else
						for(var/obj/O in BaseEntrance.loc)
							if(istype(O,/obj/deco/Cave) && O.icon == 'Cave.dmi' && O.dir == 2)
								BaseEntrance.icon = O.icon
								BaseEntrance.icon_state = O.icon_state
								BaseEntrance.dir = 2

								P.AddScreenOverlay('Cave.dmi',"Base Entrance",BaseEntrance,"[name] BaseEntrance")
								del O
								break

			else
				P.Team = null
				P<<System("You were removed as a member from [src]")

		//Generates a list of players on the Team. It returns the chosen player's ckey.
		Generate_Member_List(var/mob/P)
			var/list/options = list()
			for(var/K in Members)
				var/info = "[PlayerNames[K]]/([K])  [Members[K]]"   //[Statment ? "If True" : "If False"]
				options[info] = K
			var/M = input(P,"Which Member? ([length(options)] Players)") as null|anything in options
			if(!M) return 0
			M = options[M] //Should return the key
			return M

		//This can be used to change or set a player's rank on the team.
		Change__Rank(var/KEY, var/NEWrank)
			var/CurrentRank = Get_Rank(KEY)
			var/mob/Player/P = GetOwner(KEY)
			if(NEWrank && NEWrank != CurrentRank)
				if(P) P <<Team("Your rank in [src] has changed to [NEWrank].")
				Members[KEY] = NEWrank
			if(P)
				var/list/VERBS = RankVerbs[NEWrank]
				P.verbs -= typesof(/Team/verb)
				if(length(VERBS)) P.verbs += VERBS

		//Simply returns the player's Rank
		Get_Rank(var/ckey)
			return Members[ckey]
		Team(var/message)
			return "<b><font color = [Colour]>(Team) [message]</b>"
		Announce__toTeam(Message)
			for(var/mob/Player/P in world)
				if(Members.Find(P.ckey))
					P<<Team(Message)


		Add__Member(var/mob/Player/P, var/mob/Player/H)
			if(!P) return
			if(P.Team == name) return //They are already in this Team

			if(P.Court)
				H<<System("[P] is currently in a battle, or unavailable. Please try again later.")
				return
			if(P.Team)
				P<<System("[H] attempted to invite you to [name]. They were informed that you unfortunately declined")
				spawn(rand(20,55))
					H<<System("[P] has unfortunately declined your offer to join [name].")
					return
			else if(alert(P, "[H] is inviting you to join [name]. Would you like to join?","[name]","Yes","No") == "Yes")
				if(length(Members))
					world <<Team("[P] has been excepted into the ranks of [name]!")
					Change__Rank(P.ckey, "Recruit") //Will change and update their rank to Recruit
				else
					Change__Rank(P.ckey, "Leader") //Will change and update thier rank to Leader
					world <<Team("[P] is now the leader of [name]!")
				Members[P.ckey] = Get_Rank(P.ckey)
				P.Team = name
			else
				H<<System("[P] has unfortunately declined your offer to join [name]..")
				return



		Remove__Member(var/K)
			var/mob/Player/P = GetOwner(K)
			if(P) P.Team = null
			Members -= K
			world << Team("[PlayerNames[K]] is no longer part of [name]")
			Change__Rank(K)

		Set__Ranks(var/mob/Player/P)
			var/input = input(P, "What would you like to do") in list("Add Rank", "Remove Rank", "Edit Rank")
			switch(input)
				if("Add Rank")
					Assign_Rank_Verbs(input(P,"What will this rank be called?") as text,P)
				if("Remove Rank")
					input = input(P,"Which rank would you like to remove?") in RankVerbs
					var/NewRank = input(P, "For members already assigned to this rank, what should their new rank be?") in RankVerbs - input
					for(var/i in Members)
						if(Members[i] == input)
							Members[i] = NewRank
					RankVerbs -= input
				if("Edit Rank")
					input = input(P,"Which rank would you like to edit?") in RankVerbs
					var/DO = input(P, "What would you like to do?") in list("Edit rank verbs", "Edit rank name")
					switch(DO)
						if("Edit rank verbs")
							Assign_Rank_Verbs(input, P)
						if("Edit rank name")
							var/NewName = input(P,"What should this rank be known as?") as text
							for(var/i in Members)
								if(Members[i] == input)
									Members[i] = NewName
							RankVerbs[NewName] = RankVerbs[input]
							RankVerbs -= input


		Assign_Rank_Verbs(var/R, var/mob/Player/P)
			var/list/NewVerbs = list()
			if(R == "Leader")
				P<<System("The Leader role has access to all verbs, except Leave Team")
				NewVerbs = typesof(/Team/verb)
				NewVerbs -= /Team/verb/Leave_Team
			else
				for(var/verb/V in typesof(/Team/verb))
					if(V == /Team/verb/Leave_Team) 	NewVerbs += V
					else
						if(alert("Should [R] rank have [V]","Give Verbs to [R]","Yes","No") == "Yes")
							NewVerbs += V

			RankVerbs["[R]"] = NewVerbs




TeamRank
	Leader
	Recruit


//Head Set//Headset//
obj/Clothing/
	Accesories
		section = "Accesories"

		Headset
			icon = 'Items.dmi'
			icon_state = "Headset"
			verb
				Change_Frequency()
					var/NF = input("Enter a Frequency between 69.9 and 111.9") as num
					NF = round(NF,0.1)
					if(!IsBetween(NF,69.9,111.9))
						usr<<System("The Headset can only pick up frequencies between 69.9 and 111.9")
						return
					usr.HeadsetFrequency = NF





//Procs//-------------------------------------------------------------------------------
proc/Find_Player_Team(var/Team)
	if(istext(Team)) //Find the team by text, search the world list TEAMS
		for(var/Team/T in Teams)
			if(T.name == Team)
				return T
	return 0


//Admin Verb//---------------------------------------------------------------------------
mob/MGM/verb
	Team_Control()
		set category = "Staff"

		var/Team/T = input("Edit which Team?") in Teams

		var/input = input("What would you like to do?") in list("Add Member", "Remove Member", "Edit", "Edit Member Ranks", "Change Territory Control", "Reset Teams")
		switch(input)
			if("Change Territory Control")
				//Make a list in which the USR picks a Route.
				var/Choice = input(usr, "Which Territory are you changing ownership?") in RouteNamesTypes
				world<<Choice

				var/area/Routes/Territory
				for(var/area/Routes/R in world)
					if(istype(R, RouteNamesTypes[Choice])) Territory = R
				world<<Territory
				if(T && Territory)
					Territory.TeamWinTerritory(T)

			if("Add Member")
				var/mob/Player/P = GetPlayer(message = "Make who a member of [T.name]?")
				T.Add__Member(P, usr)

			if("Remove Member")

				T.Remove__Member(T.Generate_Member_List(usr))

			if("Edit")
				Edited(T)
			if("Reset Teams")
				if(alert("Reseting teams will delete all current settings, leaving only the default bases. MAKE SURE YOU WANNA DO THIS. The players will be very angry if you do this otherwise.","Reset Teams", "No", "Yes") == "Yes")
					Teams = list()
					var/list/Types = typesof(/Team)
					for(var/i in Types)
						if(i == /Team) continue
						Teams += new i






/*NewMap(map as text)
			set category = "Swap Maps"
			if(!map) map=input("Map name","Map name") as text
			var/_x=round(input("x size:","New map: x size",world.maxx) as num,1)
			var/_y=round(input("y size:","New map: y size",world.maxy) as num,1)
			var/_z=round(input("z size:","New map: z size",1) as num,1)
			if(_x<1 || _y<1 || _z<1)
				usr << "[_x],[_y],[_z] is an invalid map size."
				return
			var/swapmap/M=new(map,_x,_y,_z)
			for(var/turf/T in block(locate(M.x1,M.y1,M.z1),locate(M.x2,M.y2,M.z2)))
				for(var/atom/movable/O in T) del(O)
			usr << "Map [map] created: ([M.x1]-[M.x2],[M.y1]-[M.y2],[M.z1]-[M.z2])"
		SaveMap(map as text)
			set category = "Swap Maps"
			if(!map) map=input("Map name","Map name") as text
			if(!SwapMaps_Save(map))
				usr << "Map [map] not found."
			else
				usr << "Map [map] saved."
		LoadMap(map as text)
			set category = "Swap Maps"
			if(!map) map=input("Map name","Map name") as text
			var/swapmap/SM = SwapMaps_Load(map)
			if(!SM)
				usr << "Map [map] not found."
			else
				usr << "Map [map] loaded."
			sleep(150)
			del SM*/


//Mobs//---------------------------------------------------------------------------------------------------------------------
mob/NPC/Teams/
	Warehouse_Clerk

	//This is the mob that builds the base.
	Contractor
		icon = 'NPC.dmi'
		icon_state = "Omar"
		Pointer = 1
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P) || get_dist(P,src) > 2)	return
			if(P.TalkingTo["TeamContractor"]) return
			P.TalkingTo["TeamContractor"] = 1

			var/list/Verbs = P.verbs
			if(!Verbs.Find(/Team/verb/Upgrade_Base))
				if(usr) usr.ScrollText("Base Contractor", "Sorry bud, you need permission to work on the base.",'Engineer1.png')
				P.TalkingTo -= "TeamContractor"
				return
			else
				if(usr) usr.ScrollText("Base Contractor", "If you want to upgrade the base, just let me know. I can get things down for a price..",'Engineer1.png')



			Start
			var/input = input("What would you like to do?","Team Contractor") in list("Upgrade Base","Goodbye")
			switch(input)
				if("Goodbye")
					P.TalkingTo -= "TeamContractor"
					return
				if("Upgrade Base")
					var/Team/T = Find_Player_Team(P.Team)
					var/list/Upgrades = list("Meeting Room", "Teleport Hub", "Supplies Warehouse", "Science Lab")
					for(var/i in T.BaseUpgrades)
						Upgrades -= i
					var/Upgrade = input("What part of the base do you want upgraded?","Team Contractor") in Upgrades
					switch(Upgrade)
						if("Meeting Room")
							if(T.BaseUpgrades.Find("Meeting Room")) return //They don't have the upgrade
							if(usr) usr.ScrollText("Base Contractor", "The Meeting Room is a place where the members of the team may join for discussion. The Teams banker will also reside here, as well as a team roster and message board. It will cost 5000 Pokedollars, and you must always have 3 Active members.",'Engineer1.png')
							if(T.Bank >= 5000 && T.Get_Active_Members("length") >= 3)
								if(alert("Purchase the Meeting Room?","Base Contractor", "No", "Yes") == "Yes")
									T.BaseUpgrades += "Meeting Room"
									T.Bank -= 5000
									T.Announce__toTeam("[P] has purchased the Meeting Room!")
									goto Start

								else goto Start
							else
								if(usr) usr.ScrollText("Base Contractor", "You currently cannot purchase the Meeting Room.",'Engineer1.png')
								goto Start
						if("Teleport Hub")
							if(T.BaseUpgrades.Find("Teleport Hub")) return //They don't have the upgrade
							if(usr) usr.ScrollText("Base Contractor", "The Teleport Hub is where all your members may be teleported in by Ralts or Abra. The Pokemons handler can inform you on more of the specifics. This upgrade will cost 20000 Pokedollars, and you must have 5 active members.",'Engineer1.png')
							if(T.Bank >= 20000 && T.Get_Active_Members("length") >= 5)
								if(alert("Purchase the Teleport Hub?","Base Contractor", "No", "Yes") == "Yes")
									T.BaseUpgrades += "Teleport Hub"
									T.Bank -= 20000
									T.Announce__toTeam("[P] has purchased the Teleport Hub!")
									goto Start

								else goto Start
							else
								if(usr) usr.ScrollText("Base Contractor", "You currently cannot purchase the Teleport Hub.",'Engineer1.png')
								goto Start
			P.TalkingTo -= "TeamContractor"
			return



	Abra_Handler //Teleport guy
		icon = 'NPC.dmi'
		icon_state = "MomWhite"
		Team_Inferno
			name = "Abra Handler"
			Team = "Team Inferno"
		Team_Tidal
			name = "Abra Handler"
			Team = "Team Tidal"
		Team_Static
			name = "Abra Handler"
			Team = "Team Static"
		Pointer = 1
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P) || get_dist(P,src) > 2)
				return
			if(P.TalkingTo["TeamTeleporter"]) return
			P.TalkingTo["TeamTeleporter"] = 1


			var/list/Options = list("Ask for Teleport Cueword")
			var/list/Verbs = P.verbs
			if(Verbs.Find(/Team/verb/Manage_Teleporter))
				Options += "Change Teleport Cueword"
				Options += "Change Team Frequency"
			Options += "Goodbye"
			INPUT
			var/input = input("What would you like to do?","Abra Handler") in Options
			var/Team/T = Find_Player_Team(Team)
			switch(input)
				if("Goodbye")
					P.TalkingTo -= "TeamTeleporter"
					return
				if("Ask for Teleport Cueword")
					if(usr) usr.ScrollText("Abra Handler", "The current teleport cueword is [T.TeleportPassword]. Make sure to say that on the [T.TeamFrequency] frequency if you want to be teleported to base.",'Engineer1.png')
					goto INPUT
				if("Change Teleport Cueword")
					var/NewCueword = input("What should the new teleport cueword be?") as text
					if(!NewCueword || length(NewCueword) >= 15)
						if(usr) usr.ScrollText("Abra Handler", "Sorry, but I cannot use that cueword.",'Engineer1.png')
						goto INPUT
					T.TeleportPassword = NewCueword
					T.Announce__toTeam("[P] has changed the Teleport Cueword!")
					var/Title = 'Headset.png'
					for(var/mob/Player/M in world)
						if(M.HeadsetFrequency == T.TeamFrequency && M.ClothingOverlays["Accesories"] == "Headset")
							M<<"<B><font color=white>\icon[Title] \[Headset ([usr.HeadsetFrequency])] [Team] Abra Handler: </b><font color = white> Just so all members know, [P] has changed the teleport cueword to [T.TeleportPassword]."
					goto INPUT
				if("Change Team Frequency")
					var/NF = input("Enter a Frequency between 69.9 and 111.9") as num
					NF = round(NF,0.1)
					if(!IsBetween(NF,69.9,111.9))
						if(usr) usr.ScrollText("Abra Handler", "Sorry, but I cannot use that cueword.",'Engineer1.png')
						goto INPUT
					T.Announce__toTeam("[P] has changed the Team Frequency!")
					var/Title = 'Headset.png'
					for(var/mob/Player/M in world)
						if(M.HeadsetFrequency == T.TeamFrequency && M.ClothingOverlays["Accesories"] == "Headset")
							M<<"<B><font color=white>\icon[Title] \[Headset ([usr.HeadsetFrequency])] [Team] Abra Handler: </b><font color = white> Just so all members know, [P] has changed the team frequncy to [NF]. I will now be operating on that channel."
					T.TeamFrequency = NF
					goto INPUT
			P.TalkingTo -= "TeamTeleporter"






	Banker
		icon = 'MaleWhiteBase.dmi'
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Joy Robe", "Hair" = "JoyHairPink","Hood" = "Joy Hat")
		Pointer = 1
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P) || get_dist(P,src) > 2)	return
			if(P.TalkingTo["TeamBank"]) return
			P.TalkingTo["TeamBank"] = 1

			var/Team/T = Find_Player_Team(Team)
			var/list/Options = list("View Bank Total")
			var/list/Verbs = P.verbs
			if(Verbs.Find(/Team/verb/Manage_Bank))
				Options += "Adjust Recruit Dues"
			//	Options += "Give Member Credit"
			Options += "Goodbye"

			var/input = input("What would you like to do?","Team Banker") in Options
			switch(input)
				if("Goodbye")
					P.TalkingTo -= "TeamBank"
					return
				if("View Bank Total")
					P<<System("The Team's Bank Total is currently [T.Bank]")
				if("Adjust Recruit Dues")
					var/dues = input("Dues is a percentage that each member must contribute from their battles to the team's bank. Please enter a precentage between 1% and 10%.","Team Banker") in Options
					P <<dues
				if("Give Member Credit")
					P <<"CREDIT BAD!"
			P.TalkingTo -= "TeamBank"





area/TeamBase
	var/Owner = null //This will be set to the Team's name
	luminosity = 1



obj/BaseObjects
	var/Owner
	Entrance
		SteppedOn(var/mob/Player/M)
			if(isPlayer(M))
				for(var/obj/BaseObjects/Exit/E in world)
					if(E.Owner == Owner)
						M.frozen = 1
						M.FadetoBlack()
						M.loc = E.loc
						M.y += 1
						M.FadefromBlack()
						M.frozen = 0
						return ..()
				usr<<System("[Owner]'s base is currently under construction")


	Access_Points
		invisibility = 1
		var/ActiveMembers
		SteppedOn(var/mob/Player/M)
			if(isPlayer(M))
				var/Team/T = Find_Player_Team(Owner)
				if(T.BaseUpgrades.Find(name)) //Its been purcahsed
					if(T.Get_Active_Members("length") >= ActiveMembers)
						return 1
					else
						M<<System("You need [ActiveMembers] active members in order to access this room.")
						return 0
				else
					M<<System("You need to purcahse the [name] upgrade in order to access this room.")
		Meeting_Room
			ActiveMembers = 3
		Teleport_Hub
			ActiveMembers = 5



	Exit
		icon = 'Indoors.dmi'
		icon_state = "Daycare Carpet"
		Team_Inferno
			Owner = "Team Inferno"
		Team_Tidal
			Owner = "Team Tidal"
		Team_Static
			Owner = "Team Static"
		SteppedOff(var/mob/Player/M)
			if(isPlayer(M))
				if(M.dir == 2)
					for(var/obj/BaseObjects/Entrance/E in world)
						if(E.Owner == Owner)
							M.frozen = 1
							M.FadetoBlack()
							M.loc = E.loc
							M.y -= 1
							M.FadefromBlack()
							M.frozen = 0
							return ..()
					usr<<System("[Owner]'s base is currently under construction")
					return ..()

/*	Wall
		icon = 'TeamBaseTurfs.dmi'
		icon_state = "Wall"
		density = 1
		icon = 'TeamBaseTurfs.dmi'
		dir = 4
		layer = 31
		icon_state = "Fancy Wall"
		name = "Fancy Wall"
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P)) return

			if(P.BaseBuilding)
				var/Team/T = Find_Player_Team(Owner)
				if(T.Points >= 1)
					T.Points -= 1
					var/turf/L = loc
					loc = null
					for(var/obj/BaseObjects/Wall/WW in view(1,L))
						WW.GetDirection()
					for(var/obj/BaseObjects/Wall/WW in view(2,L))
						WW.GetDirection()
				else
					P<<System("[Owner] does not have enough points to purchase this space.")
			else
				P<<System("You need to be in Base Building to purchase this space.")

		proc/IsBlack()
			if(icon_state == name && dir == 8) return 1
			return 0
		proc/GetDirection()
			var/obj/BaseObjects/Wall/North
			var/obj/BaseObjects/Wall/South
			var/obj/BaseObjects/Wall/East
			var/obj/BaseObjects/Wall/West
			var/obj/BaseObjects/Wall/NorthEast
			var/obj/BaseObjects/Wall/NorthWest
			var/obj/BaseObjects/Wall/SouthEast
			var/obj/BaseObjects/Wall/SouthWest

			for(var/obj/BaseObjects/Wall/W in get_step(loc,NORTH)) North = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,SOUTH)) South = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,WEST)) West = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,EAST)) East = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,NORTHWEST)) NorthWest = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,NORTHEAST)) NorthEast = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,SOUTHWEST)) SouthWest = W
			for(var/obj/BaseObjects/Wall/W in get_step(loc,SOUTHEAST)) SouthEast = W

			var/All = 0

			if(North && South && East && West) All = 1


			if((North && South && East && !West) || (All && !North.IsBlack() && !South.IsBlack() && !East.IsBlack() && West.IsBlack()))
				icon_state = "[name]"; dir = 9

			if((North && South && !East && West) || (All && !North.IsBlack() && !South.IsBlack() && East.IsBlack() && !West.IsBlack()))
				icon_state = "[name]"; dir = 5

			if((North && !South && East && West) || (All && !North.IsBlack() && South.IsBlack() && !East.IsBlack() && !West.IsBlack()))
				icon_state = "[name]"; dir = 10

			if((!North && South && East && West) || (All && North.IsBlack() && !South.IsBlack() && !East.IsBlack() && !West.IsBlack()))
				icon_state = "[name]"; dir = 6

			//Corners
			if((!North && South && East && !West) || (All && North.IsBlack() && !South.IsBlack() && !East.IsBlack() && West.IsBlack()))
				icon_state = "[name] T"; dir = 2
			if((!North && South && !East && West) || (All && North.IsBlack() && !South.IsBlack() && East.IsBlack() && !West.IsBlack()))
				icon_state = "[name] T"; dir = 1
			if((North && !South && East && !West) || (All && !North.IsBlack() && South.IsBlack() && !East.IsBlack() && West.IsBlack()))
				icon_state = "[name] T"; dir = 8
			if((North && !South && !East && West) || (All && !North.IsBlack() && South.IsBlack() && East.IsBlack() && !West.IsBlack()))
				icon_state = "[name] T"; dir = 4
			//Ends
			if((!North && South && !East && !West))
				icon_state = "[name] T"; dir = 6
			if((North && !South && !East && !West))
				icon_state = "[name] T"; dir = 10
			if((!North && !South && !East && West))
				icon_state = "[name] T"; dir = 5
			if((!North && !South && East && !West))
				icon_state = "[name] T"; dir = 9

			//Sides
			if((!North && !South && East && West) || (North && North.IsBlack() && !South && East && West) || (South && !North && South.IsBlack() && East && West))
				icon_state = "[name]"; dir = 1
			if((North && South && !East && !West) || (North && South && East && East.IsBlack() && !West) || (North && South && !East && West && West.IsBlack()))
				icon_state = "[name]"; dir = 2


			//Black
			if(North && South && East && West && NorthWest && NorthEast && SouthEast && SouthWest)
				icon_state = "[name]"; dir = 8




turf/Base/
	icon = 'TeamBaseTurfs.dmi'
	FancyFloor
		icon_state = "Fancy Floor"*/





