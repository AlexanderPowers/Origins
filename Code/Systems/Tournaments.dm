//Vars//
var/
	Tournament/Tournament
	//IF THIS IS ON, IT WILL WORLD << TOURNAMENT PROCESS
	TournamentTesting = 1

mob/Player/var
	tmp/Tournament/EnteredTournament

mob/MGM/verb/Add_Dummy()
	var/mob/Player/P = new(usr.loc)
	P.ckey = "[rand(1000,9999999)]Dummy"
	Tournament.Entrants += P.ckey
	usr<<"[P.ckey] entered into Tournament"

	var/mob/Pokemon/PP = new/mob/Pokemon/Bulbasaur
	P.Party[1] = PP
	PP.Create(5)

//Datums
Tournament
	proc/Set_Up(var/Entrants = 8, var/WaitTime, var/mob/Player/Host, var/Prize = 0)
	proc/Start()
	proc/End(var/list/Win)

	var/
		mob/Player/Host //Who is hosting. Pretty sure this is just for the announcement.
		list/Entrants = list() //This is for before the tournament starts, to determine who has registered.
		MaxEntrants //This is the number of people needed for the Tournament (4, 8, 16)
		CurrentRound //This just monitors Tournaments progress through the procs
		Reward //This is determined by MaxEntrants in SetUp()
		Rounds[10] //..You should only need 5 here, but I've seem to put double just to make sure. Maybe future developments.
	Tag_Team_Tournament
		Set_Up(var/EntrantNum = 8, var/WaitTime, var/mob/Player/Hoster, var/Prize = 0)
			Host = Hoster
			MaxEntrants = EntrantNum
			//Create Tournament Layout
			var/Battles = 1
			for(var/i = 1, i <= 5, i++)
				var/Round/R = new
				Rounds[i] = R
				CurrentRound = i //This will determine which round the tournament starts at.
				for(var/b = 1, b<= Battles, b++) //Add the battles that will be happening in this Round
					var/Battle/B = new
					R.Battles[b] = B
					if(i != 1) //The finals will not reference to a future battle.
						var/Round/NextR = Rounds[i-1]
						//Assign the Next Battle
						if(b == 1 || b == 2) B.NextBattle = NextR.Battles[1]
						if(b == 3 || b == 4) B.NextBattle = NextR.Battles[2]
						if(b == 5 || b == 6) B.NextBattle = NextR.Battles[3]
						if(b == 7 || b == 8) B.NextBattle = NextR.Battles[4]
						//Assign the AddTo (This will determine if they will be team1 or team2 in the upcoming battle)
						if(IsOdd(b)) B.AddTo = "Team1"
						if(IsEven(b)) B.AddTo = "Team2"
				if(Battles * 2 == EntrantNum) break //This means we've created a tournament big enough for all players able to enter
				else Battles *= 2

			//Announce Tournament
			if(!Host) Host = "The Nexus Corporation"
			world <<"<font color = red><B> (System) [Host] is holding a [EntrantNum] team doubles tournament in [WaitTime] minutes.<BR><BR>(System) To enter, please enter the Nexus Building in Lycus Valley. Take the Elevator to BF2, and once in the Battle Hall, talk to the receptionist."


			spawn(WaitTime *600) //Wait howevermany minutes for the tournament.

			if(length(Entrants) == MaxEntrants)
				world <<System("<font color = red size = 3><B> [Host]'s [EntrantNum] team doubles tournament is now starting.")
				Start()

			else
				world <<System("<font color = red size = 3><B> [Host]'s [EntrantNum] team doubles tournament has been canceled due to lack of participation.")
				del src
		Start()
			//First assign entrants to the first round//
			//This Works...
			var/Round/FR = Rounds[CurrentRound]

			var/FRBattles
			for(var/Battle/b in FR.Battles)
				FRBattles += 1


			for(var/i = 1, i <= FRBattles, i++)
				var/Battle/B = FR.Battles[i]
				var/Doubles_Storage/E1 = pick(Entrants)
				for(var/K in E1.Team) B.Team1 += K
				del E1
				var/Doubles_Storage/E2 = pick(Entrants)
				for(var/K in E2.Team) B.Team2 += K
				del E2

			//Countdown till final Round

			FR.Start_Round()
		End()


//Single Tournament//---------------------------------------------------------------------------------------------
	Single_Tournament
		//Set Up//================================================================================================
		Set_Up(var/EntrantNum = 8, var/WaitTime, var/mob/Player/Hoster, var/Prize = 0, var/NPCFillin = 0)
			Host = Hoster
			name = "Tournament[rand(1,9999)]"
			MaxEntrants = EntrantNum
			//Create Tournament Layout
			var/Battles = 1
			for(var/i = 1, i <= 5, i++)
				var/Round/R = new
				Rounds[i] = R
				CurrentRound = i //This will determine which round the tournament starts at.
				for(var/b = 1, b<= Battles, b++) //Add the battles that will be happening in this Round
					var/Battle/B = new
					R.Battles[b] = B
					if(i != 1) //The finals will not reference to a future battle.
						var/Round/NextR = Rounds[i-1]
						//Assign the Next Battle
						if(b == 1 || b == 2) B.NextBattle = NextR.Battles[1]
						if(b == 3 || b == 4) B.NextBattle = NextR.Battles[2]
						if(b == 5 || b == 6) B.NextBattle = NextR.Battles[3]
						if(b == 7 || b == 8) B.NextBattle = NextR.Battles[4]
						//Assign the AddTo (This will determine if they will be team1 or team2 in the upcoming battle)
						if(IsOdd(b)) B.AddTo = "Team1"
						if(IsEven(b)) B.AddTo = "Team2"
				if(Battles * 2 == EntrantNum) break //This means we've created a tournament big enough for all players able to enter
				else Battles *= 2
			//Determine what the prize is for winning the tournament.
			if(!Prize) //There will be an else to this later...
				if(EntrantNum == 4) Reward = 15
				if(EntrantNum == 8) Reward = 30
				if(EntrantNum == 16) Reward = 60
			//Announce Tournament
			if(!Host) Host = "The Nexus Corporation"
			if(!NPCFillin) NPCFillin = pick(1,0)
			world <<System("<font color = red size = 3><B> [Host] is holding a [EntrantNum] entrant tournament in [WaitTime] minutes.<BR>[NPCFillin ? "This tournament will feature NPC Trainers" : "" ]<BR>To enter, please enter the Nexus Building in Lycus Valley. Take the Elevator to BF2, and once in the Battle Hall, talk to the receptionist.")
			spawn(WaitTime *600) //Wait howevermany minutes for the tournament.
			if(length(Entrants) == MaxEntrants)
				world <<System("<font color = red size = 3><B> [Host]'s [EntrantNum] entrant tournament is now starting.")
				Start()
				return
			else
				if(NPCFillin && length(Entrants)) //length(Entrants) stops tournaments where there are no Players.
					if(TournamentTesting) world << "Making NPCs"
					//Find_Average_Leave
					var/AverageLevel
					var/Total
					for(var/l in Entrants)
						var/mob/Player/P = GetOwner(l)
						if(isPlayer(P))
							for(var/mob/Pokemon/Poke in P.Party)
								AverageLevel += Poke.Level
								Total += 1
					AverageLevel = round(AverageLevel/Total)
					//Add Trainers
					var/Needed = MaxEntrants - length(Entrants)
					for(var/i = 1, i <= Needed, i++)
						var/mob/NPCTrainer/NPC = GenerateTrainerbyType(null, AverageLevel)
						NPC.GymleaderTrainer = name
						Entrants += NPC.ckey
					//Start
					world <<System("<font color = red size = 3><B> [Host]'s [EntrantNum] entrant tournament is now starting.")
					Start()
					return

				world <<System("<font color = red size = 3><B> [Host]'s [EntrantNum] entrant tournament has been canceled due to lack of participation.")
				del src


		//Start//====================================================================================================
		Start()
			//First assign entrants to the first round//
			//This Works...

			var/Round/FR = Rounds[CurrentRound]

			var/FRBattles
			for(var/Battle/b in FR.Battles)
				FRBattles += 1


			for(var/i = 1, i <= FRBattles, i++)
				var/Battle/B = FR.Battles[i]
				var/E1 = pick(Entrants)
				Entrants -= E1
				var/E2 = pick(Entrants)
				Entrants -= E2
				B.Team1 += E1
				B.Team2 += E2

			//Countdown till final Round


			FR.Start_Round()

		End(var/list/Win)
			if(!Win)
				world <<System("<font size = 3>The current tournament has been prematurely ended.")
				if(NextTournament <= world.realtime) NextTournament = world.realtime + (36000*pick(8,12))
			else
				for(var/l in Win)
					var/mob/Player/Winn = GetOwner(l)

					Winn.Event_Tokens += Reward
					world <<System("<font size = 3>[Winn] has won the tournament and won [Reward] Event Tokens!")
			for(var/mob/NPCTrainer/NPC in world)
				if(NPC.GymleaderTrainer == name)
					for(var/mob/Pokemon/P in NPC.Party) del P
					del NPC //Cleans up any NPCs made by the Tournament.
			del Tournament //So you can host another Tournament



var/list/RoundNames = list(1 = "Finals", 2 = "Semi-Finals", 3 = "Quarter-Finals", 4 = "Prelinaries")

Round
	var
		list/Battles[16]
	name = "Finals"
	proc/Start_Round()
		if(TournamentTesting) world << "Starting Round"
		var/Round/R = src
		var/Tournament/T = Tournament

		var/BattlesNUM
		for(var/Battle/b in R.Battles)
			BattlesNUM += 1
		Area(/area/Towns/Lycus_Valley/Indoors/Nexus/Tournament_Hall)<<System("The [RoundNames[T.CurrentRound]] have begun!")

		for(var/b = 1, b <= BattlesNUM, b++)
			var/Battle/B = R.Battles[b]


			spawn()
				var/obj/Battling/Court/C
				for(var/obj/Battling/Court/c in world)

					if(!c.Battle && c.Tournament)
						C = c
						break // We've found a court to play on, no need to continue
				var/Tagline
				var/FindPlayer
				//Sort Players
				var/Sorter = 0 //This counts how many players are in the team. If its more than 1, than it adds "and"
				for(var/ck in B.Team1)
					var/mob/Player/P1 = GetOwner(ck)
					if(isPlayer(P1)) FindPlayer = 1
					Sorter += 1
					if(P1)
						C.Team1 += P1

						if(Sorter == 1) Tagline += "[P1]"
						else Tagline += " and [P1]"
				Tagline += " VS "
				Sorter = 0
				for(var/ck in B.Team2)
					var/mob/Player/P2 = GetOwner(ck)
					if(isPlayer(P2)) FindPlayer = 1
					Sorter += 1
					if(P2)
						C.Team2 += P2

						if(Sorter == 1) Tagline += "[P2]"
						else Tagline += " and [P2]"
				Area(/area/Towns/Lycus_Valley/Indoors/Nexus/Tournament_Hall)<<"<font color = red>Match [b]: [Tagline]"
				if(!FindPlayer) //This means it is two NPCs battling... just choose a winner instead of having the battle go on.
					world<<"We have two NPCs Battling"
				//Set Up Court
				C.name = "Tournament Battle"
				//Mob Set Up will make all Players Court to C, even the NPCs. Thats how they know who their fighting.
				C.Mob_Set_Up()
				C.Court_Set_Up()

				for(var/mob/NPCTrainer/NPC in C.Team2)
					NPC.Auto_Battle()
					C.NPCBattle += 1
				for(var/mob/NPCTrainer/NPC in C.Team1)
					NPC.Auto_Battle()
					C.NPCBattle += 1

				var/list/Winners = C.Start_Battle()
				for(var/mob/NPCTrainer/NPC in C.Team1)
					NPC.Court = 0
				for(var/mob/NPCTrainer/NPC in C.Team2)
					NPC.Court = 0
				Tagline = null
				for(var/mob/P in Winners)
					B.Winner += P.ckey //Add this so the round knows who won.
					if(!Tagline) Tagline += "[P]"
					else Tagline += " and [P]"
					var/mob/Player/M = P
					M.HealAll()
				Area(/area/Towns/Lycus_Valley/Indoors/Nexus/Tournament_Hall)<<"<font color = red>Match [b]: [Tagline] has won the match!"
				//Check to see if the round is over
				var/NextRound = T.CurrentRound - 1
				if(NextRound == 0) //The Tournament has ended.
					for(var/Battle/BB in R.Battles)
						T.End(BB.Winner)
						return
				else
					var/Battle/NB = B.NextBattle

					for(var/mob/P in Winners)
						if(B.AddTo == "Team1") NB.Team1 += P.ckey
						if(B.AddTo == "Team2") NB.Team2 += P.ckey


					var/NonFinishedBattles
					var/Round/RR = T.Rounds[NextRound]
					for(var/Battle/BB in RR.Battles)
						if(!length(BB.Team1)) NonFinishedBattles += 1
						if(!length(BB.Team2)) NonFinishedBattles += 1

					if(!NonFinishedBattles) //The Round is over.
						Area(/area/Towns/Lycus_Valley/Indoors/Nexus/Tournament_Hall)<<System("The [RoundNames[T.CurrentRound]] are finsihed. The [RoundNames[T.CurrentRound-1]] will begin in 1 minute.")
						Tournament.CurrentRound -=1
						sleep(6)//)
						RR.Start_Round()
Battle
	var
		Battle/NextBattle
		AddTo = "Team1" //This can either be Team1 or Team2.
		list/Team1 = list()
		list/Team2 = list()
		list/Winner = list()

//Battle Court
obj/Battling/Court
	var/Tournament = 0 //If this is eqaul to one, it means it is within the Nexus Battle Hall.

mob/Player/
	var/
		list/RentalStorage = list()
		list/RentalPartys = list() //Will contain a list of previously used partys (No Mobs)

	proc/LoadSavedParty()
	proc/SaveCurrentParty()
		if(length(RentalPartys) >= 5)
			world <<"Hi"
//Rental_Lady
mob/NPC/Pokemon_Rentals_Receptionist
	icon = 'NPC.dmi'
	icon_state = "Receptionist"
	Portrait = 'Receptionist.png'
	Click()
		if(get_dist(src, usr) <= 2)
			usr.frozen = 1
			var/mob/Player/O = usr
			if(!istype(O,/mob/Player)) return
			O.Title_Check()
			if(O) O.ScrollText(src, "What can I do for you today?")
			if(!O) return

			var/list/Options = list("Rent Pokemon")
			if(O.GMCheck() || O.MasterGMCheck())
				Options += "Return Player's Pokemon"
			if(length(O.RentalStorage))
				Options += "Save Current Party"

			if(length(O.RentalPartys))
				Options += "Load Saved Party"
			Options += "''What do you do here?''"



			switch(input(O, "How can I help you today?") in Options)
				if("Return Player's Pokemon")
				if("Save Current Party")
					O.SaveCurrentParty()
				if("Load Current Party")
					O.LoadSavedParty()
				if("Rent Pokemon")
				if("''What do you do here?''")
					world <<"HI"


//Receptionist
mob/NPC/Tournament_Receptionist
	icon = 'NPC.dmi'
	icon_state = "Receptionist"
	Click()
		if(get_dist(src, usr) <= 2)
			usr.frozen = 1
			var/mob/Player/O = usr
			if(!istype(O,/mob/Player)) return
			O.Title_Check()
			if(O) O.ScrollText(src, "Welcome to the Nexus Battle Hall! What can I do for you today?")
			if(!O) return

			var/list/Options = list("Heal Pokemon")
			if(Tournament)
				if(O.GMCheck() || O.MasterGMCheck())
					Options += "End Tournament"

				if(!Tournament.Entrants.Find(O.ckey))
					Options += "Enter Tournament"


				else
					Options += "Leave Tournament"
				Options += "View Entrants"

			else
				if(O.GMCheck() || O.MasterGMCheck())
					Options += "Host Tournament"
				Options += "When is the next Tournament"


			switch(input(O, "How can I help you today?") in Options)
				//Heal Pokemon//
				if("When is the next Tournament")
					if(Tournament)  O.ScrollText(src, "There is currently a tournament being run.")
					else  O.ScrollText(src, "The next tournament will run at [Date(NextTournament,1,1,1,1,1,1)].")
				if("Heal Pokemon")
					if(O) O.ScrollText(src, "We will heal your Pokemon to full health.")
					O << 'Heal.mid'
					sleep(20)
					if(!O) return
					O.HealAll()

				//Host Tournament// For GMs only
				if("Host Tournament")

					if(O) O.ScrollText(src, "Which kind of Tournament would you like to hold today?")
					if(!O) return

					var/list/Tournaments = list("Single VS Tournament" = /Tournament/Single_Tournament, "Tag-Team Tournament"  = /Tournament/Tag_Team_Tournament)
					var/T = input("What kind of tournament?") in Tournaments
					switch(T)
						if("Single VS Tournament")
							var/Size = input("How many entrants?") in list(4,8,16)
							var/Wait = input("How many minutes till the tournament starts? ") as num
							var/NPCFills = 0
							if(alert(O,"Do you want to have NPC Trainers fill in for absent Player Trainers?","Tournament Receptionist","Yes","No") == "Yes") NPCFills = 1


							if(!Size || !Wait)
								O.frozen = 0
								return
							var/Type = Tournaments[T]
							Tournament = new Type
							Tournament.Set_Up(Size, Wait, O, 0,NPCFills)
						if("Tag-Team Tournament")
							var/Size = input("How many teams?") in list(4,8,16)
							var/Wait = input("How many minutes till the tournament starts? ") as num
							if(!Size || !Wait)
								O.frozen = 0
								return
							var/Type = Tournaments[T]
							Tournament = new Type
							Tournament.Set_Up(Size, Wait, O)


				//Enter Tournament//
				if("End Tournament")
					Tournament.End()
				if("Enter Tournament")
					var/Tournament/T = Tournament
					if(istype(T, /Tournament/Single_Tournament)) //Singles Tournament
						if(T.Entrants.Find(O.ckey))
							if(O) O.ScrollText(src, "You are already entered in the tournament.")
							if(O)
								O.frozen = 0
								return
						if(length(T.Entrants) != T.MaxEntrants)
							T.Entrants += O.ckey
							if(O) O.ScrollText(src, "You have been registered for the current tournament.")
							if(!O) return

						else
							if(O) O.ScrollText(src, "I am sorry to inform you that the current tournament has reached a maximum number of entrants. Please try again next time")
							if(O)
								O.frozen = 0
								return
					else if(istype(T, /Tournament/Tag_Team_Tournament)) //Doubles Tournament
						if(length(T.Entrants) != T.MaxEntrants)
							var/mob/P = O.Partner
							if(P && isPlayer(P)) //NO NPCs in Tournament
								if(alert(O,"Your partner is currently [P]. Enter Tournament with this person?",,"Yes","No") == "Yes")
									if(length(T.Entrants) == T.MaxEntrants || P != O.Partner) return //Tournament has filled, OR Partner has changed form before the alert
									if(!O) return
									var/Doubles_Storage/DS = new
									DS.Team += O.ckey
									DS.Team += O.Partner.ckey
									T.Entrants += DS
									if(O) O.ScrollText(src, "You and [P] have been registered for the current tournament.")
									if(!O) return

							else
								if(O) O.ScrollText(src, "You currently do not have a partner, and one is required for a Tag-Team Tournament. Please return when you have a partner.")
								if(O) O.frozen = 0
				if("Leave Tournament")
					var/Tournament/T = Tournament
					if(length(T.Entrants) != T.MaxEntrants)
						T.Entrants -= O.ckey
						if(O) O.ScrollText(src, "You have been unregistered for the current tournament.")
						if(!O) return

				if("View Entrants")
					var/Tournament/T = Tournament
					O<<"Tournament Entrants:"
					for(var/K in T.Entrants)
						O<<K






			usr.frozen = 0


Doubles_Storage
	var/list/Team = list()


//Automated Tournaments//
var/NextTournament //This is always set as a world.realtime

var/list/BannedMoves = list(/obj/Moves/Synthesis, /obj/Moves/Flame_Wheel, /obj/Moves/Spore, /obj/Moves/Aerial_Ace, /obj/Moves/Leech_Seed, /obj/Moves/Beat_Up, /obj/Moves/Ancient_Power, /obj/Moves/Whirlwind, /obj/Moves/Roar, /obj/Moves/Swords_Dance)

proc
	AutoTournamentWait() //Called by world.New()
		if(!NextTournament || NextTournament >= world.realtime) NextTournament = world.realtime + (36000*2)
		if(NextTournament <= world.realtime) //World.Realtime has surpased the time of the tournament, run it.if(NextTournament <= world.realtime)

			spawn() AutoTournamentStart()
		else
			spawn(NextTournament - world.realtime)
				AutoTournamentStart()


	AutoTournamentStart()
		var/TournamentType = pick(/Tournament/Tag_Team_Tournament,/Tournament/Single_Tournament,/Tournament/Single_Tournament,/Tournament/Single_Tournament)
		Tournament = new TournamentType //Create the Tournament

		var/ActivePlayers
		for(var/mob/Player/P in world)
			if(!P.AFK) ActivePlayers += 1

		var/Size
		//These are for SingleTournament
		if(ActivePlayers <= 7) Size = 4
		else if(ActivePlayers <= 15) Size = 8
		else Size = 16
		//These are DoublesTournaments
		if(istype(Tournament,/Tournament/Tag_Team_Tournament))
			Size /= 2
			if(Size == 2)
				del Tournament
				Tournament = new /Tournament/Single_Tournament
				Size = 4

		if(istype(Tournament, /Tournament))
			Tournament.Set_Up(Size, 8)
		NextTournament = world.realtime + (36000*pick(8,12))


//Rental Pokemon
var/list/RentalPokemon = list(\
	"Chikorita" = list("type" = /mob/Pokemon/Chikorita, "moves" = list(/obj/Moves/Giga_Drain, /obj/Moves/Toxic ,/obj/Moves/Body_Slam ,/obj/Moves/Light_Screen ,/obj/Moves/Bullet_Seed ,/obj/Moves/Attract)),
	"Bayleef" = list("type" = /mob/Pokemon/Bayleef, "moves" = list(/obj/Moves/Razor_Leaf , /obj/Moves/Body_Slam ,/obj/Moves/Synthesis ,/obj/Moves/Safeguard ,/obj/Moves/Iron_Tail ,/obj/Moves/Vine_Whip)),
	"Meganium" = list("type" = /mob/Pokemon/Meganium, "moves" = list(/obj/Moves/SolarBeam , /obj/Moves/PoisonPowder ,/obj/Moves/Reflect ,/obj/Moves/Leech_Seed ,/obj/Moves/Sunny_Day ,/obj/Moves/Hidden_Power)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	"" = list("type" = /mob/Pokemon/, "moves" = list(/obj/Moves/ , /obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/ ,/obj/Moves/)),
	)
