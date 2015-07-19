//TEST VARS//

var/TestBattling = 0
//IF THIS VAR IS ON: It will output world strings through out the battle procedure. This is used to track where problems may be occouring.

area
	var/NoBattle = 0
	var/FieldStatus
	var/FieldStatusUser
obj/Battling/Settings
	var/
		list/
			BannedPokemonType = list() //Ban an entire type of Pokemon (EX. Fire, Water, etc). This lists length cannot exceed 17.
			BannedMoveType = list() //Bans an entire type of Move (EX. Fire, Water, etc). This lists length cannot exceed 17.
			BannedMoves = list() //Bans individual Moves (EX. Thunder, Earthquake, Aerial Ace, etc).
			BannedPokemon = list()

		LevelMaximum //Only Pokemon lower or equal than this level.
		LevelMinimum //Only Pokemon higher or equal than this level.
		PokemonMax  //If they are only allowed 3 Pokemon.

obj/Battling/Court


	invisibility = 99
	var/
//		WeatherStatus = null // "Rain Dance", "Sunny Day", "Sandstorm"

		list/Team1 = list()
		list/Team2 = list()
		list/Team1Defeated = list()
		list/Team2Defeated = list()
		list/Watchers = list()
		Battle = 0
		NPCBattle = 0
		list/Winners = list()
		list/Losers = list()

		swapmap/Arena //This is what loads with an empty court in it.

		Reason //Either No Contest, AFK, or Defeated
		list/PokeList1 = list() //The Pokemon being used by Team1
		list/PokeList2 = list() //The Pokemon being used by Team2
		obj/Battling/Settings/Settings //This is an object that records all settings for Battles. Is set at the begginer by the Challenger.




	proc/
		Battle_Total_Health(var/list/Pokemon) //Checks the Total_Health of a List of Pokemon
			var/TotalHP
			var/TotalPP
			for(var/mob/Pokemon/P in Pokemon)
				if(TestBattling == 2) world << P

				if(P)
					if(istype(P.Ball,/obj/Balls/Egg)) continue //This Pokemon is in an egg..
					if(Settings) //Check the settings first
						if(Settings.BannedPokemonType.Find(P.Type1) || Settings.BannedPokemonType.Find(P.Type2)) continue
						if(Settings.BannedPokemon.Find(P.type)) continue
					TotalHP += max(P.HP,0)

					//Check their moves, for banned and PP
					for(var/obj/Moves/M in P.Moves)
						if(Settings)
							if(Settings.BannedMoveType.Find(M.Type)) TotalPP += 0
							else if(Settings.BannedMoves.Find(M.type)) TotalPP += 0
							else TotalPP += max(M.PP,0)
						else TotalPP += max(M.PP,0)

			if(Settings && Settings.PokemonMax)
				if(length(Pokemon) < Settings.PokemonMax) //They have not used the Pokemon Max yet. Because it adds these Pokemon to the list AS the battle goes, it would be wrong to assume the battle is done unless the Pokemon Max has been reached."
					return "Pokemon Max not reached"

			if(TestBattling) world << "[TotalHP]HP and [TotalPP]PP sent to Battle()"
			if(!TotalHP || !TotalPP) return 0

			return TotalHP

		Battle_Logout(var/mob/Player/P)
			//Logging out will delete the Players Pokemon automatically, so there is
			//no need to remove them from the PokeLists. However, you still need to
			//set the Reason for loosing

			if(Team1.Find(P))
				Team1Defeated += P
				Team1 -= P
			if(Team2.Find(P))
				Team2Defeated += P
				Team2 -= P
			for(var/mob/Pokemon/Poke in PokeList1) if(Poke.Owner == P.ckey) PokeList1 -= Poke
			for(var/mob/Pokemon/Poke in PokeList2) if(Poke.Owner == P.ckey) PokeList2 -= Poke
			P.RemoveSection("WatchingBattle")
			if(P.Watcher) del P.Watcher

		Battle_Remove_Player(var/mob/Player/P)
		Battle_Forfeit(var/mob/Player/P)
			Reason = "Forfeit"
			P<<"<font color = red>(System) You have forfeited the match."
			if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall(0)
			// Remove them from the Battle
			if(Team1.Find(P))
				Team1Defeated += P
				Team1 -= P
			if(Team2.Find(P))
				Team2Defeated += P
				Team2 -= P
			if(P.Watcher) del P.Watcher
			if(P.client)
				P.client.eye = P
				winset(P, "OC", "is-visible=false")
				winset(P, "Forfeit", "is-visible=false")
			P.TimeHUD.WeatherEffect = null //Remove Weather Overlays
			P.UpdateDayHUD()
			P.RemoveSection("WatchingBattle")
			P.Court = null



		Battle_Sendout_Check(var/mob/Pokemon/P,var/mob/Player/O) //returns 0 if allowed, returns 1 if not allowed
			if(Settings)
				var/TotalMoves = 0
				var/BannedMoves = 0
				for(var/obj/Moves/M in P.Moves) //This checks to see if all the Moves the Pokemon has are banned.
					TotalMoves += 1
					if(Settings.BannedMoveType.Find(M.Type) || Settings.BannedMoves.Find(M.type)) BannedMoves += 1


				if(Settings.BannedPokemonType.Find(P.Type1))
					if(isPlayer(O)) O<<System("<b><font color = [TypesColours[P.Type1]]>[P.Type1]</font></B> type Pokemon have been banned from use in this battle")
					return 1
				else if(Settings.BannedPokemonType.Find(P.Type2))
					if(isPlayer(O)) O<<System("<b><font color = [TypesColours[P.Type2]]>[P.Type2]</font></B> type Pokemon have been banned from use in this battle")
					return 1
				else if(Settings.BannedPokemon.Find(P.type))
					if(isPlayer(O)) O<<System("<b>[P]</B> has been banned from use in this battle")
					return 1
				else if(BannedMoves >= TotalMoves)
					if(isPlayer(O)) O<<System("All of [P]'s move have been banned in this battle.")
					return 1
				else if(P.Level > Settings.LevelMaximum)
					if(isPlayer(O)) O<<System("All Pokemon entering this battle must be level [Settings.LevelMaximum] or less.")
					return 1
				else if(P.Level < Settings.LevelMinimum)
					if(isPlayer(O)) O<<System("All Pokemon entering this battle must be level [Settings.LevelMaximum] or higher.")
					return 1
				else if(isPlayer(O))
					if(Team1.Find(O))
						if(length(PokeList1) >= Settings.PokemonMax)
							if(isPlayer(O)) O<<System("This battle is limited to [Settings.PokemonMax] on each team.")
							return 1
					if(Team2.Find(O))
						if(length(PokeList2) >= Settings.PokemonMax)
							if(isPlayer(O)) O<<System("This battle is limited to [Settings.PokemonMax] on each team.")
							return 1
				else return 0

			else return 0
		Battle_Add_Pokemon(var/mob/Pokemon/Poke,var/mob/Player/P)
		//This is only used if there is a Max to the ammount of Pokemon you can use.
		//Returns 1 on success, 0 on failure to add.
			if(!Settings) return 1
			if(Settings.PokemonMax)
				if(Team1.Find(P))
					if(length(PokeList1) < Settings.PokemonMax)
						if(Battle_Sendout_Check(Poke)) PokeList1 += Poke
					else return 0
				if(Team2.Find(P))
					if(length(PokeList2) < Settings.PokemonMax)
						if(Battle_Sendout_Check(Poke)) PokeList2 += Poke
					else return 0

			else return 0

		Battle_Banned_Move_Check(var/obj/Moves/M,var/mob/Player/P) //returns 0 if allowed, returns 1 if not allowed
			if(Settings)
				if(Settings.BannedMoveType.Find(M.Type))
					P<<System("<b><font color = [TypesColours[M.Type]]>[M.Type]</font></B> type moves have been banned from use in this battle")
					return 1
				else if(Settings.BannedMoves.Find(M.type))
					P<<System("<b><font color = [TypesColours[M.Type]]>[M]</font></B> has been banned from use in this battle")
					return 1
				else return 0
			else return 0

		Battle()
			set background = 1
			var/list/QuestChecker
			var/InactiveTeam1 = 0
			var/InactiveTeam2 = 0
			//Start by seeing if you need to set the PokeLists.
			var/GenerateLists = 1

			if(Settings && Settings.PokemonMax) GenerateLists = 0
			if(GenerateLists) //When there is a PokemonMax, the lists are set as the Pokemon are sent out.
				if(TestBattling) world << "Generating Lists for Battle()"
				for(var/mob/m in Team1)
					var/mob/Player/M = m
					//Sometimes a quest may replace the Pokemon in your Party for a Battle.
					//Therefore we call QuestCheck
					if(isPlayer(M)) QuestChecker = M.QuestCheck("Battle Replace Party") //Should return a list of Pokemon to replace the party with in Battle.
					if(TestBattling == 2 && QuestChecker) world <<"QuestChecker being used!"
					if(islist(QuestChecker)) for(var/mob/Pokemon/P in QuestChecker) PokeList1 += P
					else for(var/mob/Pokemon/P in M.Party) PokeList1 += P
				for(var/mob/m in Team2)
					var/mob/Player/M = m
					//Sometimes a quest may replace the Pokemon in your Party for a Battle.
					//Therefore we call QuestCheck
					if(isPlayer(M)) QuestChecker = M.QuestCheck("Battle Replace Party") //Should return a list of Pokemon to replace the party with in Battle.
					if(islist(QuestChecker)) for(var/mob/Pokemon/P in QuestChecker) PokeList2 += P
					else for(var/mob/Pokemon/P in M.Party) PokeList2 += P
			//Start the Battle, keep checking to see if that battle ends
			if(TestBattling) world << "Battle Loop running"
			while(!Reason)
				sleep(10)
				//List of Reasons//
				//"No Contest" - Both trainers have vanished. Rare, but just in case.
				//"Missing Team" - The amount of trainers in one team is 0. This is from logout.
				//"Forfeit" - This is set when someone Forfeits.
				//"Winner Found" - All Pokemon in one Party are unable to battle. The opposing team wins.
				//"AFK" - One team has been declared AFK for not sending out a Pokemon.

				//Check for Reason: No Contest/Missing Team
				if(!length(Team1) && !length(Team2))
					Reason = "No Contest"
					break
				else if(!length(Team1))
					Winners = Team2.Copy()
					Reason = "Missing Team"
					break
				else if(!length(Team2))
					Winners = Team1.Copy()
					Reason = "Missing Team"
					break
				//Check for Reason: Winner Found
				if(!Battle_Total_Health(PokeList1))
					if(TestBattling) world << "Team 2 has won!"
					Winners = Team2.Copy()
					Losers = Team1.Copy()
					Reason = "Winner Found"
					break
				if(!Battle_Total_Health(PokeList2))
					if(TestBattling) world << "Team 1 has won!"
					Winners = Team1.Copy()
					Losers = Team2.Copy()
					Reason = "Winner Found"
					break



				//Check for Reason: AFK
				for(var/mob/M in Team1)
					var/mob/Player/PL = M
					if(isPlayer(PL) && PL.QuestCheck("Check Battle Inactive")) continue //They are exempt from the AFK checker if a quest allows it.
					if(!M.ControlingPokemon && !Team1Defeated.Find(M)) InactiveTeam1 += 10; else InactiveTeam1 = max(0,InactiveTeam1 - 5)
				for(var/mob/M in Team2)
					var/mob/Player/PL = M
					if(isPlayer(PL) && PL.QuestCheck("Check Battle Inactive")) continue //They are exempt from the AFK checker if a quest allows it.
					if(!M.ControlingPokemon && !Team2Defeated.Find(M)) InactiveTeam2 += 10; else InactiveTeam2 = max(0,InactiveTeam2 - 5)

				if(InactiveTeam1 >= 900)
					if(NPCBattle & InactiveTeam1 >= 6000) //They've been AFK in an NPC battle. Normally NPC battles don't time out, but this one ends to prevent lag.
						Winners = Team2.Copy()
						Reason = "AFK"
						break
					else
						Winners = Team2.Copy()
						Reason = "AFK"
						break
				if(InactiveTeam2 >= 900)
					if(NPCBattle & InactiveTeam2 >= 6000) //They've been AFK in an NPC battle. Normally NPC battles don't time out, but this one ends to prevent lag.
						Winners = Team1.Copy()
						Reason = "AFK"
						break
					else
						Winners = Team1.Copy()
						Reason = "AFK"
						break

			return Winners //Returns the winners for Gymleader battles ect.





		Start_Battle() //When all the details of a match have been confirmed, then start the game.
			Battle = 1 //The Battle Starts
			if(TestBattling) world << "Starting of Battle, before Battle()"

			Battle()
			if(TestBattling) world << "Battle Ending, Reason: [Reason]"
			//Find out who was battling

			if(length(Winners) && !Winners.Find("No Contest"))
				if(NPCBattle) //AN NPC BATTLE...............................................................
					var/NPCwon //A far to check for the winner if NPC
					for(var/mob/NPCTrainer/N in Winners)
						if(!istype(N.Partner,/mob/Player)) NPCwon = N


					if(NPCwon) //The NPCs won
						for(var/mob/Player/Players in Team1)
							Players.Money -= round(Players.Money/3) //They loose a fifth their money if they loose
					else //The Players Won



						for(var/mob/NPCTrainer/NPCT in Team2)
							for(var/mob/Player/Player in Team1)
								if(!Player.NPCWins[NPCT.type]) //They haven't battle before, so they get more money.
									Player.AddMoney(round(NPCT.MoneyGiven/length(Team1)),"Battle Win")
								else
									Player.AddMoney(round((NPCT.MoneyGiven/length(Team1))/2),"Battle Win")
								Player.NPCWins[NPCT.type] += 1

				else //A PLAYER BATTLE.......................................................................
					if(length(Winners) == length(Losers) == 1)
						for(var/mob/Player/P in Losers)
							for(var/mob/Player/PP in Winners)
								P.Loses[PP.ckey] += 1
								PP.Wins[P.ckey] += 1

					var/Points
					var/TTTeam
					for(var/mob/Player/M in Winners)
						for(var/mob/Player/J in Losers)
							if(J == M) continue
							if(length(M.Team) && length(J.Team))
								for(var/i in M.Team)
									for(var/j in J.Team)
										if(i == j)
											Points = 0
											break
										if(i != j)
											Points += 5
											TTTeam = i
											M<<System("You gained 5 points for [i]")
					if(Points && TTTeam)
						var/Team/T = Find_Player_Team(TTTeam)
						T.Points += Points


			for(var/mob/Player/M in Watchers)
				//This should only be for Players. NPCs will be deleted anyways, so they don't need to be fixed.
				//Plus, we need the Court value for Auto_Battle()
				//This includes Battlers and Watchers alike.
				var/mob/Player/P = M //For the Battlers, it returns their Pokemon to their Pokeball.

				if(istype(P,/mob/Player))
					if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall(0,1)
				M.RemoveSection("WatchingBattle")
				M.Court = null
				//Reset Weather Settings
				M.TimeHUD.WeatherEffect = null
				M.UpdateDayHUD()
				if(M.client)
					M.client.eye = M
					winset(P, "OC", "is-visible=false")
					winset(P, "Forfeit", "is-visible=false")
					winset(M, "StopWatch", "is-visible=false")



			var/list/W = Winners.Copy()
			W["Reason"] = Reason
			End_Battle() //This just cleans up all the variables for the next battle
			return W
		End_Battle() //We no longer need to reset all the COURT variables, because a new one is made with each battle now.
			/*Team1 = list()
			Team2 = list()
			Team1Defeated = list()
			Team2Defeated = list()
			Watchers = list()
			Battle = 0
			NPCBattle = 0
			Winners = list()
			Losers = list()
			Reason = null
			PokeList1 = list() //The Pokemon being used by Team1
			PokeList2 = list() //The Pokemon being used by Team2
			Settings = null//This is an object that records all settings for Battles. Is set at the begginer by the Challenger.
			*/

			var/area/A = loc.loc
			for(var/mob/O in A) //Look for mobs like Pokemon
				O.loc = null //Just removes them from the battlefield. It could be a Players Pokemon.
			loc = null //If the court sits on the Battlefield, it will delete itself, therefore ending the proc before returning its value.
			spawn(100) del src //We still need delete the court after its no longer in use. 10 Seconds should give it enough time to send through the info.
			Arena.Unload() //Deletes the arena they just battled in.


		Mob_Set_Up() //This is for setting up mobs only
			var/list/All = list() //For referencing all mobs in the battle.
			All += Team1.Copy()
			All += Team2.Copy()
			for(var/mob/P in All)
				if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall()
				P.Watcher = new
				P.Watcher.invisibility = P.invisibility
				P.Watcher.name = P.name
				P.Watcher.icon = P.icon
				P.Watcher.icon_state = initial(P.icon_state)
				P.Watcher.overlays = P.overlays
				P.Watcher.overlays -= /obj/HUD/OMG
				P.Watcher.Owner = P
				if(P.client)
					P.client.eye = src
					P.client.perspective=EYE_PERSPECTIVE
					if(z == 3) winset(P, "OC", "is-visible=true") //Not for Tournaments
					winset(P, "Forfeit", "is-visible=true")
				P.Court = src
				Watchers += P
				P.overlays += image('Clothing.dmi', "WatchingBattle")
			switch(length(Team1)) // Set the Watchers up and put the View on the field.
				if(1) for(var/mob/P in Team1)
					P.Watcher.loc = locate(x + 8,y,z)
					P.Watcher.dir = get_dir(P.Watcher,locate(x,P.Watcher.y,z))
				if(2)
					var/Counter
					for(var/mob/P in Team1)
						P.Watcher.loc = locate(x + 8,y - 1 + Counter,z)
						P.Watcher.dir = get_dir(P.Watcher,locate(x,P.Watcher.y,z))
						Counter += 2
			switch(length(Team2)) // Set the Watchers up and put the View on the field.
				if(1) for(var/mob/P in Team2)
					P.Watcher.loc = locate(x - 8,y,z)
					P.Watcher.dir = get_dir(P.Watcher,locate(x,P.Watcher.y,z))
				else
					var/Counter
					for(var/mob/P in Team2)
						P.Watcher.loc = locate(x - 8,y - 1 + Counter,z)
						P.Watcher.dir = get_dir(P.Watcher,locate(x,P.Watcher.y,z))
						Counter += length(Team2)

		Court_Set_Up()
		/*	var/obj/Battling/Court_Set_Up/C
			var/mob/m
			var/area/A

			//In order to find out which field to generate,
			for(var/mob/M in Team1)
				m = M
			if(!m) return
			else
				A = m.loc.loc
				if(A.CSU) C = new A.CSU
			if(!C) C = new/obj/Battling/Court_Set_Up/Forest
			if(z == 3) //If were on the Battling Layer Z. This ensures that overworld courts do not get bugged.
				for(var/ny = y-8, ny<=y+8, ny++) //Then place grass everywhere to ensure its back to what it was.
					for(var/nx = x-8, nx<=x+8, nx++)
						if(isloc(locate(nx,ny,3)))
							new/turf/Routes/Grass (locate(nx,ny,3))
				C.Court_Set_Up(src)*/

area/
	var/ArenaType

//Arena Set Up//-----------------------------------------------------------------------------------------------------------------------------------------------

//-Builds an arena using swap maps
//-Finds the Court PrePlaced in the design
//-Sets all turfs, within the visible area, to belong to the Court.
//-Return the Court for proc control

proc/ArenaSetUp(var/ArenaType)
	var/swapmap/M = SwapMaps_CreateFromTemplate("map_Battlefield_[ArenaType]", "NewArena")
	var/atom/MP = locate(round((M.x1+M.x2)/2),round((M.y1+M.y2)/2),M.z1) //This is the middle point of the battlefield. We will use it to find the COURT OBJ
	for(var/obj/Battling/Court/C in view(10, MP))
		C.Arena = M
		return C

//Watchers//
mob/Watcher
	var/mob/Owner
	Click()
		if(Owner == usr)
			if(usr.MasterGMCheck())
				usr.Court.Winners += usr



Challenge
	var
		list/Team1 = list()
		list/Team2 = list()
		Active
		Text

mob/verb/AcceptChallenge()
	set hidden = 1
	if(Court || Watcher) return
	winset(src, "Challenge", "is-visible=false")
	var/Challenge/CH
	for(var/Challenge/C in Challenges) if(C.Active) CH = C

	var/obj/Battling/Court/C = ArenaSetUp("Forest")


	if( !(CH.Team1) || !(CH.Team2) ) return
	C.Team1 = CH.Team1.Copy()
	C.Team2 = CH.Team2.Copy()
	C.name = CH.Text
	del CH

	C.Mob_Set_Up()
	C.Court_Set_Up()
	C.Start_Battle()

mob/verb/DenyChallenge()
	set hidden = 1
	for(var/Challenge/C in Challenges) if(C.Active) del C
	winset(src, "Challenge", "is-visible=false")
	ViewChallenges()

mob/proc/ViewChallenges()
	set background = 1
	winset(src, "Challenge", "is-visible=false")
	if(Court) return
	for(var/Challenge/C in Challenges)
		winset(src, "Challenge", "is-visible=true")
		winset(src, "Challenge.Who", "text='[C.Text]'")
		C.Active = 1
		return
mob
	proc/Find_Team()
		var/obj/Battling/Court/C = Court
		for(var/mob/M in C.Team1)
			if(M == src) return "Team1"
		for(var/mob/M in C.Team2)
			if(M == src) return "Team2"

mob/Player/

	verb/Challenge()
		set src in oview(4)

		var/mob/Player/M = usr
		if(!istype(M,/mob/Player)) return

		if(M.client) if(winget(M, "PM ON", "is-checked") == "false")
			M<<System("You have disabled Battle Challenges. Too turn them back on, look in the Options tab.")
			return
		if(client) if(winget(src, "PM ON", "is-checked") == "false")
			M<<System("[src] has disabled Battle Challenges.")
			return

		var/list/Options = list()
		var/Challenge/C = new

		C.Team1 += src
		C.Team2 += M
		Options["[M] VS [src]"] = "1 VS 1" //The challenger vs the challengee is always an option

		if(M.Partner && Partner) //If they each have a team, ask if they would like a double battle.
			Options["[M] + [M.Partner] VS [src] + [src.Partner]"] = "2 VS 2"
			Options["[M] + [M.Partner] VS [src]"] = "2 VS 1"
			Options["[M] VS [src] + [src.Partner]"] = "1 VS 2"
			C.Team1 += src.Partner
			C.Team2 += M.Partner
			C.Text = "[M] and [M.Partner] are challenging you and [Partner] to a 2 VS 2 Battle."

		var/input = input(M, "What kind of battle would you like?") in Options

		//Checks//
		var/area/A = loc.loc
	//	if(src == usr) return // You can't challenge yourself
		if(M.Court || !length(M.Party)) return //The challenger can't battle because they are already battling or they have no Pokemon to battle with.
		if(Court) //If the Challengee already has a Court, they are already battling
			M<<System("[src] is currently in the middle of a battle.")
			return
		if(A)
			if(A.NoBattle || !A.ReleaseCheck)
				usr<<System("Battles are not permitted in this area.")
				return
		if(!src || !M)
			del C
			return //In case the usr or the Challengee has logged out

		switch(Options[input])
			if("1 VS 1")
				C.Text = "[M] is challenging you to a 1 VS 1 Battle."
				C.Team2 = list(M)
				C.Team1 = list(src)
			if("1 VS 2")
				C.Text = "[M] is challenging you to a 1 VS 2 Battle with your partner, [Partner]."
				C.Team2 = list(M)
			if("2 VS 1")
				C.Text = "[M] and [M.Partner] are challenging you to a 2 VS 1 Battle."
				C.Team1 = list(src)
		Challenges += C

		spawn(300)
			del C // They have 30 seconds to respond
			ViewChallenges()
		ViewChallenges()
		// If they accept, go to AcceptChallenge()

proc/Set_Up_NPC_Battle(var/T1,var/T2)


	 //Find a Court//
	var/obj/Battling/Court/C = ArenaSetUp("Forest")


	C.Battle = 1
	C.NPCBattle = 1 //So we know this battle has NPCs in it.

	var/mob/NPCTrainer/O1 = new T1

	O1 = O1.GenerateTrainer(T1, C, 5)
	O1.loc = locate(2,249,2) //We set this because the Court needs to know which variation to set up (Forest, Lake, Powerplant, etc)
	var/mob/NPCTrainer/O2 = new T2

	O2 = O2.GenerateTrainer(T2, C, 5)
	O2.loc = locate(2,249,2) //We set this because the Court needs to know which variation to set up (Forest, Lake, Powerplant, etc)

	C.Team1 += O1
	C.Team2 += O2

	C.Mob_Set_Up()
	C.Court_Set_Up()
	spawn() C.Start_Battle()

	spawn() O1.Auto_Battle()
	spawn() O2.Auto_Battle()

	return C

mob/NPCTrainer
	var/
		Party[6]

		TextAfterLoose
		TextAfterWin
		TextBeforeAccepted
		TextBeforeBattle
		TextPassByAfterWin

		MeetSound = 'Male Trainer Encounter.mid'
		BattleSound = 'Trainer Battle.mid'


		MoneyGiven
		Pokes = list()
	verb/Chall()
		set name = "Challenge"
		set src in view(1)
		var/mob/Player/M
		if(istype(usr,/mob/Player)) M = usr
		if(TalkingTo.Find(M)) return //They are already talking to the player, and should not repeat the process
		TalkingTo += M
		if(!M) return
		if(world.realtime - M.NPCTimes[type] < 36000*2)// && !M.MasterGMCheck()) //2 Hours.
			if(Tests["NPC"]) world <<7
			var/list/T = list("Didn't we battle quite recently?","Go away..I'm busy training.","Great battle last time, but why don't you come back later. I'm done battling for a bit.","My Pokemon have all fainted from training so hard.","Why don't you give your Pokemon a break.", "You should go train your pokemon a bit!")
			M<<Dialog(src,pick(T))
			M<<System("This trainer can be battled again [Date(M.NPCTimes[type] + 72000,1,1,1,1,1)]")
			return
		if(Tests["NPC"]) world <<8
		if(M.Court || M.Watcher) return
		if(TextBeforeAccepted) M<<Dialog("[name]", "[TextBeforeAccepted]")
		if(M.NPCTimes[type]) if(alert(M,"Challenge [src]?",,"Yes","No") == "No") return
		Challenge(M)
		TalkingTo[M] = null //They are no longer talking to the player.

	proc/GenerateTrainer(var/Trainer, var/C, var/mob/Player/P)

		var/mob/NPCTrainer/TT
		if(ismob(Trainer)) TT = Trainer //This is for NPCTrainers generated, not already in the source
		else TT = new Trainer

		TT.ckey = "<[rand(1,9999)]>[TT.name]"
		TT.Court = C
		var/Counter = 0
		var/L = null
		var/LEVEL = 0
		//Create the Pokemon
		for(var/I in TT.Pokes)
			Counter += 1
			//If its a list, there are more details about the Pokemon in it. If its just a type, then its a default type.
			var/mob/Pokemon/PP
			if(isnum(TT.Pokes[I]))
				PP = new I
				if(isnum(P)) LEVEL = TT.Pokes[I] + (7 * P)
				else LEVEL = TT.Pokes[I] + (7 * P.Badges())


			else if(islist(I))
				var/list/Co = I
				L = Co.Copy()

				if(L["set level"]) LEVEL = L["set level"]
				else
					LEVEL = L["level"]
					if(isnum(P))
						LEVEL += 7 * P //P is a number, set when the proc is called. IT IS NOT A MOB.
					else
						LEVEL += 7 * P.Badges()

				if(L["set type"])
					var/NT = L["set type"]
					PP = new NT
				else
					var/NT = L["type"]
					PP = new NT


			CheckEvolve
			PP.Level = LEVEL
			//Should they Evolve?
			var/GEvo = 1
			if(L) if(L["set type"]) GEvo = 0

			if(GEvo) for(var/i in PP.Evolve)
				if(findtext(i,"Level ") || findtext(i,"WildLevel "))
					var/EvolveLevel = text2num(copytext(i,7))
					if(EvolveLevel <= PP.Level)
						var/K = PP.Evolve[i]
						var/PPP = new K
						del PP
						PP = PPP
						goto CheckEvolve

			PP.Create(PP.Level)

			if(L)

				if(L["catchable"])
					PP.OriginalTrainer = "Catchable"
					TT.MoneyGiven = 0 //They don't give out money if they have a catchable Pokemon.
				if(L["icon"]) PP.icon = L["icon"] //If no new icon is supplied, it simply uses the regular one.
				if(L["moves"])
					var/list/Co = L["moves"]
					var/list/MO = Co.Copy()
					PP.Moves = list()
					PP.LearnMoves = list()
					for(var/m in MO)
						var/obj/Moves/AAA = new m
						AAA.Owner = PP
						PP.Moves += AAA
				L = list()

			PP.Ball = new/obj/Balls/Poke_Ball
			PP.Owner = TT.ckey
			TT.Party[Counter] = PP
		//Generate Money Given
		var/EXP
		for(var/mob/Pokemon/p in TT.Party)
			for(var/i in p.Stats)
				if(i == "EXP") continue
				EXP += p.Stats[i]

		TT.MoneyGiven = (EXP / 1.5)
		return TT

	proc/Challenge(var/mob/Player/P, var/PlayerPartner = 1) //Unless PlayerPartner is 1, then they cannot battle with a partner.
		var/list/NPCTrainers = list()
		PassedBy += P
		TalkingTo += P
		if(MeetSound) P.BackgroundMusic(MeetSound,0)
		overlays += /obj/HUD/OMG
		spawn(20) overlays -= /obj/HUD/OMG
		P.frozen = 1
		//This is for when it is a full NPC cinamatic battle//

		P.ScrollText(src, TextBeforeBattle)
		if(!P) return 0//in case she logged out during the ScrollText
		P.frozen = 0

		var/obj/Battling/Court/C = ArenaSetUp("Forest")//Create a Court

		C.Battle = 1
		C.NPCBattle = 1 //So we know this battle has NPCs in it.

		//Create a new Mob to battle.----------------------------------------------------------------------
		C.Team2 += GenerateTrainer(type, C, P) //Make their Partner IF they have one.
		if(Partner) C.Team2 += GenerateTrainer(Partner, C, P) //Make their Partner IF they have one.

		if(P.Partner)
			if(isPlayer(P.Partner))
				var/mob/Player/CP = P.Partner
				if(!CP.Court) C.Team1 += CP //If they are not already battling, then add them
			if(ispath(P.Partner))
				var/mob/NPCTrainer/Ptner = GenerateTrainer(P.Partner, C, P)
				C.Team1 += Ptner
				NPCTrainers += Ptner
				Ptner.Partner = P

		NPCTrainers += C.Team2
		C.Team1 += P

		if(BattleSound) P.BackgroundMusic(BattleSound,0)


		C.Mob_Set_Up()

		for(var/mob/NPCTrainer/NPC in C.Team2)
			NPC.Auto_Battle()
		for(var/mob/NPCTrainer/NPC in C.Team1)
			NPC.Auto_Battle()
		if(TestBattling) world <<"NPC is ready to start Battle: NPC>Challenge()"
		var/list/Winners = C.Start_Battle()
		if(TestBattling) world <<"NPC is finished with battle: NPC>Challenge()"
		Battlers -= P
		//Delete Stuff
		P.BackgroundMusic()
		for(var/mob/NPCTrainer/NPC in NPCTrainers) //It looks for
			if(P)
				if(NPC.type != P.Partner) P.NPCTimes[NPC.type] = world.realtime //This marks the last time the Player battled with this NPC.
		spawn(40)
			for(var/mob/NPCTrainer/NPC in NPCTrainers) //It looks for
				for(var/mob/Pokemon/PP in NPC.Party)
					del PP
				del NPC
		TalkingTo -= P
		return Winners


	proc/Auto_Battle()
		set background = 1
		spawn(20)

			//Vars we will be using//
			var/mob/Pokemon/Target
			var/mob/Pokemon/Fighting
			var/mob/Pokemon/Switchout
			var/atom/Turf
			var/list/options = list(1,2,3,4,5,6)
			//
			//var/Done = 0

			while(Court && !length(Court.Winners)) //While they are still considered battling. It will remove them if they don't have any pokemon.
				if(Fighting && !Switchout) //This means they already have a Pokemon ON the field, and do not plan on switching Pokemon.
					if(Fighting.HP <= 0) //The Pokemon is unable to battle, so it must be recalled.
						Fighting = null
						continue //The Pokemon can no longer Fight
					if(!Fighting.loc && !Fighting.InBall) //They've been returned?
						Fighting = null
						continue
					if(Fighting.Owner != ckey) //This is if the Pokemon changes owners halfway through, meaning it probably got caught (Snorlax)
						for(var/i in options)
							var/mob/Pokemon/pp = Party[i]

							if(pp && pp.Owner != ckey)
								//Switchout = 1
								Fighting = null
								Party[i] = null
								options -= i
								break

						continue


					Target = null
					for(var/mob/Pokemon/P in view(20, Court))
						if(P.invisibility) continue //They can't see invisible Pokemon
						var/mob/O1 = GetOwner(P.Owner)
						if(O1.Find_Team() != Find_Team()) Target = P
					if(Target)
						Fighting.Target = Target
						//--------------
						if(Turf)
							//Checks for SleepPowders
							if(Fighting.StepAway) step_away(Fighting,Fighting.StepAway)

							if(!Fighting.Step_To(Turf))

								Turf = null
							var/Auto = 0
							var/list/K = view(Fighting, 1)
							if(Target in K) Auto = 1//If its really close...then attack anyways

							if(Fighting.loc == Turf || Auto || Target.Status == "Sleep") //Has it reached its destionation?
								var/obj/Moves/M = Fighting.AbleAttack()
								if(M)
									M.Check(Fighting,Target)
								Turf = null
								continue
						else if(!Turf)
							var/list/Possible = list(locate(Target.x + 4, Target.y, Target.z),locate(Target.x - 4, Target.y, Target.z),locate(Target.x, Target.y - 4, Target.z),locate(Target.x, Target.y + 4, Target.z))
							for(var/turf/Routes/Water/W in Possible)
								if(Fighting.Type1 == "Water" || Fighting.Type2 == "Water" || Fighting.Type1 == "Flying" || Fighting.Type2 == "Flying") continue
								else Possible -= W
							while(!Turf)
								if(!length(Possible))
									Turf = get_step(Fighting,pick(1,2,4,8))
									break
								else if(Target)
									Turf = pick(Possible)
									if(Turf)
										if(!istype(Turf.loc,/area/BattleCourt))
											Turf = null; Possible -= Turf; continue //The turf isnt in the battlefield, so they can't go there.
										if(!Turf.Enter(Fighting))
											Turf = null; Possible -= Turf; continue
										for(var/atom/movable/M in Turf)
											if(M.density)
												Possible -= Turf
												Turf = null
												break

								sleep(1)
					else //If there are no Pokemon on the field for it to attack, it steps to 5 spaces in front of its trainer.
						if(!Watcher) break
						var/atom/T = Get_Steps(Watcher, src.Watcher.dir, 5)
						if(Fighting.loc != T && !T.density)
							Fighting.Step_To(T)
						else Fighting.dir = get_dir(Fighting,Get_Steps(src.Watcher, src.Watcher.dir, 6))
				else //If a Pokemon needs to be sent out.
					if(Fighting) Fighting.ReturntoBall() //Return the Pokemon that is alreight out
					Switchout = null
					while(!Switchout)
						sleep(5)
						if(!length(options))
							break
						var/option = pick(options)
						Switchout = Party[option]


						if(!Switchout)
							options -= option
							continue
						if(Switchout && Switchout.HP <= 0)
							options -= option
							Switchout = null
							continue
						if(Switchout.NoSend)
							var/effected
							var/fighting
							for(var/mob/Pokemon/PPP in Party)
								if(PPP.NoSend) effected += 1
								if(PPP.HP >= 1) fighting += 1
							if(fighting > effected) if(world.realtime <= Switchout.NoSend)
								Switchout = null
								continue

					if(Switchout)
						var/atom/T
						while(!T)
							if(!Watcher) return
							if(Watcher.dir == 4) T = locate(Watcher.x + rand(1,4), Watcher.y + rand(1,4),Watcher.z)
							if(Watcher.dir == 8) T = locate(Watcher.x - rand(1,4), Watcher.y + rand(1,4),Watcher.z)
							if(invisibility)
								T = Watcher.loc
							if(istype(T,/turf/Routes/Water))
								if(Switchout.Type1 != "Water" || Switchout.Type2 != "Water"|| Switchout.Type1 != "Flying"|| Switchout.Type2 != "Flying")
									T = null
							sleep(1)
						Fighting = Switchout
						Switchout = null
						var/obj/FAKE = new //Creates a fake object for the missile
						FAKE.icon = 'Pokeballs.dmi'
						FAKE.icon_state = "throw Pokeball"
						if(!invisibility)
							missile(FAKE, src.Watcher, T)
							sleep(max(0,get_dist(T,Watcher)-1))
							Fighting.AddMeter(1)
							flick("Send",Fighting)
						del FAKE
						 //Sleep the distance from the player to the place the pokeball was thrown (so it doesn't just pop there..)
						Fighting.loc = T

						Fighting.dir = 2


						/*for(var/mob/Player/P in world)  //Sound is temporarily being taken out to see if this is the cause for NPC Glitches.
							var/list/K = view(P.client,11)
							if(winget(P, "SOUNDS ON", "is-checked") == "true") if(Fighting in K) P<<Fighting.Cry*/
						ControlingPokemon = Fighting
						Fighting.Meter.overlays += /obj/HUD/Owned

				if(Fighting) sleep(max(1,Fighting.GetSpeed() + 2))
				else sleep(5)

			/*
			var/mob/Pokemon/Opponent //This is the Opponents Pokemon.
			var/mob/Pokemon/P //This is the Pokemon the NPC is currently using
			var/mob/Pokemon/Switchout //This is the Pokemon that is switching..in
			var/turf/Turf //The area they are going to be attacking from.

			while(Court && Battling)
				Opponent = Battling.ControlingPokemon
				P = ControlingPokemon
				if(Switchout)
					if(P)
						//Recall the Pokemon
						P.ReturntoBall()
					//Find The Location
					var/atom/T = get_step(src.Watcher,src.Watcher.dir)
					Get_Steps(T, src.Watcher.dir, rand(2,6))
					//Send it Out
					P = Switchout
					Switchout = null
					var/obj/FAKE = new //Creates a fake object for the missile
					FAKE.icon = 'Pokeballs.dmi'
					FAKE.icon_state = "throw [P.Ball.icon_state]"

					if(T) T = locate(T.x,T.y + rand(3,3), T.z)
					missile(FAKE, src.Watcher, T)
					del FAKE
					sleep(max(0,get_dist(T,src.Watcher)-1)) //Sleep the distance from the player to the place the pokeball was thrown (so it doesn't just pop there..)
					P.loc = T
					P.dir = 2
					P.AddMeter()
					flick("Send",P)
					ControlingPokemon = P
					P.Meter.overlays += /obj/HUD/Owned

				if(!P)
					while(!Switchout)
						sleep(1)
						Switchout = Party[rand(1,6)]
						if(Switchout && Switchout.HP <= 0)
							Switchout = null
							continue
					continue
				else if(P)
					Opponent = Battling.ControlingPokemon
					P.Target = Opponent
					if(!Opponent)
						var/atom/T = Get_Steps(src.Watcher, src.Watcher.dir, 5)
						if(P.loc != T && !T.density)
							P.Step_To(T)
						else P.dir = get_dir(P,Battling.Watcher)
					else
						if(Turf)

							P.Step_To(Turf)
							if(P.loc == Turf) //Has it reached its destionation?
								var/obj/Moves/M = P.AbleAttack()
								if(M)
									M.Check(P,Opponent)
								Turf = null
								continue
						else if(!Turf)

							while(!Turf)
								Opponent = Battling.ControlingPokemon
								var/l = pick("x","y")
								if(Opponent)
									switch(l)
										if("x")
											Turf = locate(Opponent.x + rand(-4,4),Opponent.y,Opponent.z)
										if("y")
											Turf = locate(Opponent.x,Opponent.y + rand(-4,4),Opponent.z)
								if(Turf)
									if(!istype(Turf.loc,/area/BattleCourt)) Turf = null
									for(var/atom/movable/M in Turf)
										if(M.density)
											Turf = null
											break
								sleep(1)
				sleep(max(1,P.GetSpeed() + 2))*/
//Battle Commands//

mob/verb/
	ForfeitBattle()
		set hidden = 1
		if(alert(usr, "Do you want to foreit the Battle?",,"No","Yes") == "Yes")
			if(usr && istype(usr,/mob/Player))
				var/mob/Player/O = usr
				//if(O.QuestCheck("Check Forfeit")) return

				if(O.Court)
					if(O.Court.NPCBattle)
						O<<System("You cannot run from an NPC Battle!")
						return
					else O.Court.Battle_Forfeit(O)


atom/proc/FindCourt() //Finds the closest Court object to be used.
	var/obj/Battling/Court/CC = null
	for(var/obj/Battling/Court/C in view(15, src))
		if(!CC) CC = C
		else if(get_dist(src, C) < get_dist(src,CC)) CC = C

area/BattleCourt
	luminosity = 1

	//Now areas cannot distinquish one from another, because the same one is loaded with every court.
	//To make things easier, nothing comes in or out of the area.
	//The only way to get something into the area is to throw a Pokemon on.

	Exit(var/atom/M)
				//We no longer have to check for when no ones battling, cause no one should be there then.
		if(istype(M,/obj/Overworld))
			var/obj/Overworld/OO = M
			var/atom/A = get_step(M,M.dir)
			A = A.loc
			if(istype(A,/area/BattleCourt)) return 1
			else
				OO.Bump(null)
				return 0
		if(istype(M,/mob/Pokemon))
			var/atom/A = get_step(M,M.dir)
			A = A.loc
			if(istype(A,/area/BattleCourt)) return 1
			else
				return 0
		else return 0



	A
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	B
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	C
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	D
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	E
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	F
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	G
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	H
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	I
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	J
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	K
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k
	Tournament
		a
		b
		c
		d
		e
		f
		g
		h
		i
		j
		k


//Court Set Up//---------------------------------------------------------------------------------------------------------------




//Battle Settings//
mob/Player/
	var
		BattleSettings = list("BannedPokemon", "BannedMoves","BannedPokemonTypes","BannedMoveTypes","LevelMinimum","LevelMaximum","Owner")

	verb
		Battle_Options()
			set category = "Commands"
			winset(usr, "Battle Options", "is-visible=true")


		BO(var/T as text)
			set hidden = 1
			switch(T)
				if("BannedPokemon")
					var/input = input("What would you like to do") in list("View banned Pokemon","Add banned Pokemon","Remove banned Pokemon")
					var/list/PokemonTypes = typesof(/mob/Pokemon)
					var/list/PokemonList = list()
					for(var/i in PokemonTypes)
						var/Poke = copytext("[i]",14)
						PokemonList[Poke] = i

					var/list/Banned = BattleSettings["BannedPokemon"]

					if(!islist(Banned)) Banned = list()

					switch(input)
						if("Add banned Pokemon")
							var/Type = input("Ban which type of Pokemon?") in PokemonList
							if(!Banned.Find(Type)) Banned += PokemonList[Type]
							BattleSettings["Owner"] = ckey
						//if("Remove banned Pokemon")
							//var/Type = input("Ban which type of Pokemon?") in Banned
							//Banned -= PokemonList[Type]
						//	BattleSettings["Owner"] = ckey

					var/html = "<B><U>Banned Pokemon:<BR><BR></u></b>"
					for(var/i in Banned)
						html += "[copytext("[i]",14)],"


				if("BannedMoves")
					var/input = input("What would you like to do") in list("View banned Moves","Add banned Moves","Remove banned Moves")
					var/list/Moves = typesof(/obj/Moves)
					var/list/MovesList = list()
					for(var/i in Moves)
						var/Move = copytext("[i]",14)
						MovesList[Move] = i

					var/list/Banned = BattleSettings["BannedMoves"]

					if(!islist(Banned)) Banned = list()

					switch(input)
						if("Add banned Moves")
							var/Type = input("Ban which move?") in Moves
							if(!Banned.Find(Type)) Banned += Moves[Type]
							BattleSettings["Owner"] = ckey
						if("Remove banned Moves")
							var/Type = input("Unban which move?") in Banned
							Banned -= Moves[Type]
							BattleSettings["Owner"] = ckey

					var/html = "<B><U>Banned Moves:<BR><BR></u></b>"
					for(var/i in Banned)
						html += "[copytext("[i]",14)],"
				if("BannedPokemonTypes")
					var/input = input("What would you like to do") in list("View banned types","Add banned type","Remove banned type")
					var/list/Banned = BattleSettings["BannedPokemonTypes"]
					if(!Banned) Banned = list()
					switch(input)
						if("Add banned type")
							var/Type = input("Ban which type of Pokemon?") in TypesColours
							if(!Banned.Find(Type)) Banned += Type
							BattleSettings["Owner"] = ckey
						if("Remove banned type")
							var/Type = input("Ban which type of Pokemon?") in Banned
							Banned -= Type
							BattleSettings["Owner"] = ckey
					var/html = "<B><U>Banned Pokemon Types:<BR><BR></u></b>"
					for(var/i in Banned)
						html += "[i],"
					usr<<output(html, "BannedViewing")

				if("BannedMoveTypes")
					var/input = input("What would you like to do") in list("View banned types","Add banned type","Remove banned type")
					var/list/Banned = BattleSettings["BannedMoveTypes"]
					if(!Banned) Banned = list()
					switch(input)
						if("Add banned type")
							var/Type = input("Ban which type of move?") in TypesColours
							if(!Banned.Find(Type)) Banned += Type
							BattleSettings["Owner"] = ckey
						if("Remove banned type")
							var/Type = input("Ban which type of move?") in Banned
							Banned -= Type
							BattleSettings["Owner"] = ckey
					var/html = "<B><U>Banned Move Types:<BR><BR></u></b>"
					for(var/i in Banned)
						html += "[i],"
					usr<<output(html, "BannedViewing")

				if("LevelMinimum")
					var/Setting = input("What should the Level Minimum be in Battles?") as num
					if(!IsBetween(Setting,0,200))
						usr<<System("The Level Minimum must be in the range of 0-200")
						return
					BattleSettings["LevelMinimum"] = Setting
					BattleSettings["Owner"] = ckey

					if(Setting) winset(usr, "Battle Options.MinimumButton", "text='Pokemon Level Minimum: [BattleSettings["LevelMinimum"]]'")
					else winset(usr, "Battle Options.MinimumButton", "text='Pokemon Level Minimum: None'")
				if("LevelMaximum")
					var/Setting = input("What should the Level Maximum be in Battles?") as num
					if(!IsBetween(Setting,0,200))
						usr<<System("The Level Maximum must be in the range of 0-200")
						return
					BattleSettings["LevelMaximum"] = Setting
					BattleSettings["Owner"] = ckey

					if(Setting) winset(usr, "Battle Options.MaximumButton", "text='Pokemon Level Maximum: [Setting]'")
					else winset(usr, "Battle Options.MaximumButton", "text='Pokemon Level Maximum: None'")

