// Terms List //

//AWB - Area Wide Battle//
var/list/RouteNamesTypes = list("Route 303" = /area/Routes/Route_303, "Power Plant" = /area/Routes/Power_Plant, "Acconna Desert" = /area/Routes/Acconna_Desert, "Route 305"= /area/Routes/Route_305)
var/list/ClaimedRoutes = list("Route 303" = "Uncontended", "Power Plant" = "Uncontended", "Acconna Desert" = "Uncontended", "Route 305" = "Uncontended")
var/list/ContendingTeams = list() //This will show which teams are currently fighting.

area/Routes

	var/Team1
	var/Team2

	var/list/EnteredPlayers = list()
	var/list/Team1Players = list()
	var/list/Team2Players = list()
	var/list/RemovedPlayers = list() //If a player's ckey is in this list, they cannot reenter the battlefield
	var/list/NoTeam2Counter = 0
	ReleaseCheck(var/mob/Pokemon/P)
		if(Team1 && Team2)
			if(!EnteredPlayers.Find(P.Owner))
				return 0
		return ..()
	proc
		TeamAnnounce(var/Text)
			for(var/mob/Player/P in src)
				var/Team/T = Find_Player_Team(P.Team)
				P<<T.Team(Text)
		TeamPresent(var/Team) //This will return 1 if there are players of Team in the area. If not, then 0
			for(var/mob/Player/P in src)
				if(P.Team == Team) return 1
			return 0
		TeamWinTerritory(var/Team/W, var/Team/L)
			Team1 = null
			Team2 = null
			if(L)
				for(var/mob/Player/P in src)
					PlayerToOther(P, "a Territory War has ended.")
					P.frozen = 0
				L.Announce__toTeam("[W] has beaten [L] and claimed [src]! You have been defeated!")
			ClaimedRoutes[name] = W.name
			//Change the Flags!
			for(var/obj/Teams/Flag_Post/FP in src)
				FP.icon_state = W.name

			W.Announce__toTeam("[W] has claimed [src]! You are victorious!")

		PlayersLeft(var/Team) //Returns a list of players left in the match.
			var/list/Left = list()
			if(Team1 == Team) for(var/i in Team1Players) if(!RemovedPlayers.Find(i)) Left += i
			if(Team2 == Team) for(var/i in Team2Players) if(!RemovedPlayers.Find(i)) Left += i
			return Left

		PlayerRemoved(var/mob/Player/P, var/Reason)
			RemovedPlayers += P.ckey
			if(Reason == "Died")
				var/Team/T = Find_Player_Team(P.Team)
				var/list/Left = PlayersLeft(P.Team)
				if(P.Team == Team1) T<<T.Announce__toTeam("[P] has been defeated. [length(Left)]/[length(Team1Players)] members left to defend!")
				if(P.Team == Team2) T<<T.Announce__toTeam("[P] has been defeated. [length(Left)]/[length(Team2Players)] members left to defend!")
		PlayerToOther(var/mob/Player/P , var/Reason)
			if(Reason) P<<System("You have been teleported out of [src] because [Reason]")
			for(var/obj/Teams/PlayerSpawn/Other/O in src)
				P.loc = O.loc

		PlayerToSpawn(var/mob/Player/P, var/Team)
			if(Team == Team1)
				for(var/obj/Teams/PlayerSpawn/Team1/T1 in src)
					for(var/mob/Player/p in T1) continue //Don't spawn on a block where there is already a player
					P.loc = T1.loc
					EnteredPlayers += P.ckey
					Team1Players += P.ckey
					return

			else if(Team == Team2)
				for(var/obj/Teams/PlayerSpawn/Team2/T2 in src)
					for(var/mob/Player/p in T2) continue //Don't spawn on a block where there is already a player
					P.loc = T2.loc
					EnteredPlayers += P.ckey
					Team2Players += P.ckey
					return //This has to be here at the end, or it will add EnteredPlayers for each Spawn.
			var/Team/T = Find_Player_Team(P.Team)
			T<<T.Announce__toTeam("[P] has joined the fight!")









obj/Teams/

	PlayerSpawn
		invisibility = 99
		density = 0
		Team1
		Team2
		Other //Other gets put outside the limits of battle.



	Flag_Post
		icon = 'Team Flags.dmi'
		icon_state = "Uncontended"

	Blockade
		icon = 'Team Flags.dmi'
		icon_state = "RoadBlock"
		density = 0
		invisibility = 66



Team/verb
	Start_Territory_War()
		set category = "Teams"
		var/Team/T = Find_Player_Team(usr.Team)
		var/area/Routes/A = usr.loc.loc

		if(!A || !T) return
		if(islist(T)) T = input("Which Team?") in T
		var/list/verbs = T.RankVerbs[T.Members[usr.ckey]]
		if(!istype(A, /area/Routes) && ClaimedRoutes[A.type]) //If it hasn't been given by a GM first, it cannot be taken.
			usr<<System("This area is not able to be contended for.")
			return
		if(!verbs.Find(/Team/verb/Start_Territory_War))
			usr<<System("You don't have permission in this team to use this verb.")
			return
		if(A.Team1 || A.Team2) //This area is currently being fought over
			usr<<System("This area is currently being contended over.")
			return
		if(ClaimedRoutes[A.name] == T.name) //They already own this area.
			usr<<System("Your Team already has claimed this territory!")
			return
		A.PlayerToSpawn(usr, usr.Team) //Must send the person who started the advance to the territory spawn.
		T.AdvanceTerritory(Find_Player_Team(ClaimedRoutes[A.name]), A)
	Join_Territory_War()
		var/area/Routes/A = usr.loc.loc
		if(A.Team1 != usr.Team && A.Team2 != usr.Team)
			usr<<System("Your team is not fighting in this territory")
			return
		else if(A.RemovedPlayers.Find(usr.ckey))
			usr<<System("You have been removed from this territory war.")
			usr.verbs -= /Team/verb/Join_Territory_War
			return
		else
			A.PlayerToSpawn(usr, usr.Team)



Team/proc
	AdvanceTerritory(var/Team/T, var/area/Routes/A) //T is the team that is defending, src is the Team addvancing. A is the turf they are fighting over
		set background = 1
		var/list/Fighters = list()
		for(var/KEY in Members)
			var/mob/Player/M = GetOwner(KEY)
			if(M) Fighters += M
		for(var/KEY in T.Members)
			var/mob/Player/M = GetOwner(KEY)
			if(M) Fighters += M
		for(var/mob/M in Fighters)
			M<<Team("[src] is advancing onto [T]'s territory, <b>[A]</b>. Enter the territory, then use the Join Territory War verb to enter the war.")
			M.verbs += /Team/verb/Join_Territory_War
		//Initial Set-up//
		A.Team1 = src.name
		A.Team2 = T.name
		ContendingTeams += A.Team1
		ContendingTeams += A.Team2
		//Set up Barricades so New Players can't enter.
		for(var/obj/Teams/Blockade/B in A)
			B.density = 1
			B.invisibility = 0
		//Spawn players into the Spawns if they are in the area.
		for(var/mob/Player/P in A)
			if(P.Team == A.Team1 || P.Team == A.Team2) A.PlayerToSpawn(P, P.Team) //Must send the person who started the advance to the territory spawn.
			else A.PlayerToOther(P , "two teams([A.Team1] and [A.Team2]) are battling over the territory!")


		var/Timer = 6000
		while(Timer >=1)
			sleep(10)
			Timer -= 10
			if(!A.TeamPresent(A.Team1))
				break //Team 1 is always the advancing team. If they aren't there, Team 2 has expelled them and one.
			if(!A.TeamPresent(A.Team2)) A.NoTeam2Counter += 1
			else
				if(A.NoTeam2Counter)
					A.TeamAnnounce("[A.Team2] has added another player, defeat timer stopped.")
				A.NoTeam2Counter = 0
			if(A.NoTeam2Counter == 2)
				A.TeamAnnounce("[A.Team2] has 30 seconds to send in a member to defend the territory")
			if(A.NoTeam2Counter == 10)
				A.TeamAnnounce("[A.Team2] has 20 seconds to send in a member to defend the territory")
			if(A.NoTeam2Counter == 20)
				A.TeamAnnounce("[A.Team2] has 10 seconds to send in a member to defend the territory")
			if(A.NoTeam2Counter >= 30)
				break //Because there should be Team1 still here, they should win when this loop ends.


		if(!A.TeamPresent(A.Team1)) A.TeamWinTerritory(Find_Player_Team(A.Team2),Find_Player_Team(A.Team1))
		else A.TeamWinTerritory(Find_Player_Team(A.Team1),Find_Player_Team(A.Team2))

		//Area Clean-Up
		for(var/mob/Player/P in A)
			P.loc = LocFromNum(P.DieLoc)
			P.ControlingPokemon.ReturntoBall(0)
		A.Team1 = null
		A.Team2 = null
		A.NoTeam2Counter = 0

		A.EnteredPlayers = list()
		A.Team1Players = list()
		A.Team2Players = list()
		A.RemovedPlayers = list()
		ContendingTeams = list()

		for(var/obj/Teams/Blockade/B in A)
			B.density = 0
			B.invisibility = 1
		//Get rid of the Join_Territory_War verb for all members online.
		Fighters = list()
		for(var/KEY in Members)
			var/mob/Player/M = GetOwner(KEY)
			if(M) Fighters += M
		for(var/KEY in T.Members)
			var/mob/Player/M = GetOwner(KEY)
			if(M) Fighters += M
		for(var/mob/M in Fighters)
			M.verbs -= /Team/verb/Join_Territory_War


			/*for(var/KEY in A.EnteredPlayers)
				var/mob/Player/O = GetOwner(KEY)
				if(!O || A.RemovedPlayers.Find(KEY)) continue

				var/TH = TotalHealth(O.Party)
				if(TH <= 0)
					//They no longer have any Pokemon to fight with. Remove them from battle.
					A.PlayerToOther(O , "you have fallen in the frontlines of battle!")
					A.RemovedPlayers += KEY


		//10 minutes have passed, check to see if the defenders are still in the territory. Since they can't re-enter, they should still be there.
		world<<1
		sleep(60)
		if(!A.TeamPresent(A.Team1)) A.TeamWinTerritory(Find_Player_Team(A.Team2),Find_Player_Team(A.Team1))
		else A.TeamWinTerritory(Find_Player_Team(A.Team1),Find_Player_Team(A.Team2)) //The advancing team held the area for 10 minutes
		*/

obj/NewWorld/TeamLoad //One of these needs to be on the map so that Teams will load.
	invisibility = 1
	New()
		//Sets the Flags for who owns each territory.
		spawn(10)
			for(var/I in RouteNamesTypes)
				var/area/Routes/R
				for(var/area/Routes/r in world) if(istype(r, RouteNamesTypes[I])) R = r
				if(!R) return
				for(var/obj/Teams/Flag_Post/FP in R)
					FP.icon_state = ClaimedRoutes[R.name]
