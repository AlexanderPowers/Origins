//Turfing//----------------------------------------------------------------------------------------------
obj/Contests
	deco
		icon = 'ContestHall.dmi'
		Stage_Edging
			icon_state = "Stage Edging 1"
		Podium
			icon_state = "Stand"
			pixel_y = -22




turf/Buildings
	Contest_Hall
		icon = 'ContestHall.dmi'
		Stairs
			icon_state = "Stage StairsLeft"
		Floor
			icon_state = "Floor"
		Stage_Floor
			icon_state = "Stage Floor"
		Wall
			density = 1
			icon_state = "Wall Single"






//Judges and NPCs
obj/Contests
	Judges
		var/PreferedType
		var/list/PreferedPokemon = list()
		var/PreferedContestType = "Cool"
		var/PreferedDesign
		var/PreferedColour
		icon = 'ContestJudges.dmi'

		Candy
			PreferedPokemon = list(/mob/Pokemon/Paras, /mob/Pokemon/Parasect)
			PreferedType = "Bug"
			PreferedContestType = "Smart"
			PreferedColour = "Pink"
			PreferedDesign = "Heart"
			icon_state = "Candy"
		Nurse_Joy
			PreferedPokemon = list(/mob/Pokemon/Chansey, /mob/Pokemon/Blissey)
			PreferedContestType = "Smart"
			PreferedColour = "Pink"
			PreferedDesign = "Heart"
			icon_state = "Nurse Joy"
		Steven
			PreferedPokemon = list(/mob/Pokemon/Skarmory, /mob/Pokemon/Geodude, /mob/Pokemon/Graveler, /mob/Pokemon/Golem)
			PreferedType = "Steel"
			PreferedContestType = "Tough"
			icon_state = "Steven"
			PreferedColour = "Black"
		Officer_Jenny
			PreferedPokemon = list(/mob/Pokemon/Growlithe, /mob/Pokemon/Arcanine, /mob/Pokemon/Houndour, /mob/Pokemon/Houndoom)
			PreferedType = "Fire"
			PreferedContestType = "Cool"
			icon_state = "Officer Jenny"
			PreferedColour = "Blue"
		Richie
			PreferedPokemon = list(/mob/Pokemon/Dodrio, /mob/Pokemon/Yanma, /mob/Pokemon/Larvitar, /mob/Pokemon/Poliwhirl, /mob/Pokemon/Sneasel, /mob/Pokemon/Lapras, /mob/Pokemon/Rapidash, /mob/Pokemon/Shuckle, /mob/Pokemon/Gligar, /mob/Pokemon/Xatu)
			PreferedType = "Flying"
			icon_state = "Richie"

		Arial
			PreferedPokemon = list(/mob/Pokemon/Pidgeot, /mob/Pokemon/Dodrio, /mob/Pokemon/Gligar, /mob/Pokemon/Murkrow, /mob/Pokemon/Aerodactyl, /mob/Pokemon/Fearow)
			PreferedType = "Flying"
			icon_state = "Arial"
			PreferedColour = "Green"

//Receptionist and Registeration//---------------------------------------------------------------------------------------------------------------------
mob/NPC/Contest_Receptionist
	icon = 'NPC.dmi'
	icon_state = "Receptionist"
	var/HallLocation = /obj/Contests/Locations/Net_City_Contest_Hall

	Click()
		var/mob/Player/P = usr
		if(!isPlayer(P)) return

		var/list/options = list("Register", "Rules", "View Contestants", "Nevermind")
		var/input = input(P, "What would you like?", "Contest Receptionist", "Nevermind") in options
		switch(input)
			if("View Contestants")
				P<<"<B>Current Contestants:"
				for(var/i in NextContestants)
					P<<"[PlayerNames[i]] ([i])"
			if("Register")
				if(NextLocation)
					if(NextLocation == HallLocation)
						P.ScrollText("Contest Receptionist", "Would you like to register for the contest to be held here at [Date(NextTime,1,1)]")
						if(!P) return
						if(alert(P, "Would you like to Register?","Register","Yes","No") == "Yes")
							if(!P) return
							else if(length(NextContestants) >= 8)
								P.ScrollText("Contest Receptionist", "I am sorry, but 8 contestants have already entered this Contest. Please try again later.")
							else if(CurrentContest)
								P.ScrollText("Contest Receptionist", "I am sorry, but you are too late to register. The contest has already begun.")

							else if(NextContestants.Find(P.ckey))
								P.ScrollText("Contest Receptionist", "You have already been registered for this contest.")
							else
								P.ScrollText("Contest Receptionist", "You must choose a Pokemon to enter with.")
								var/mob/Pokemon/RPoke = P.Party_Choose("Enter which Pokemon?", P.Party)
								if(!RPoke) return
								P.RoundPokemon = RPoke
								NextContestants += P.ckey
								P.ScrollText("Contest Receptionist", "You have been registered for the contest. We will globally announce when the contest is about to begin.")
					else
						P.ScrollText("Contest Receptionist", "There is currently no scheduled Contest. Sorry for the inconvience.")
						return
				else //No Contest has been set yet.
					P.ScrollText("Contest Receptionist", "There is currently no scheduled Contest. Sorry for the inconvience.")
					return

mob/NPC/Contest_Receptionist2
	name = "Contest Receptionist"
	icon = 'NPC.dmi'
	icon_state = "Receptionist"
	var/HallLocation = /obj/Contests/Locations/Ridgeport_Contest_Hall

	Click()
		var/mob/Player/P = usr
		if(!isPlayer(P)) return

		var/list/options = list("Register", "Rules", "View Contestants", "Nevermind")
		var/input = input(P, "What would you like?", "Contest Receptionist", "Nevermind") in options
		switch(input)
			if("View Contestants")
				P<<"<B>Current Contestants:"
				for(var/i in NextContestants)
					P<<"[PlayerNames[i]] ([i])"
			if("Register")
				if(NextLocation)
					if(NextLocation == HallLocation)
						P.ScrollText("Contest Receptionist", "Would you like to register for the contest to be held here at [Date(NextTime,1,1)]")
						if(!P) return
						if(alert(P, "Would you like to Register?","Register","Yes","No") == "Yes")
							if(!P) return
							else if(length(NextContestants) >= 8)
								P.ScrollText("Contest Receptionist", "I am sorry, but 8 contestants have already entered this Contest. Please try again later.")
							else if(CurrentContest)
								P.ScrollText("Contest Receptionist", "I am sorry, but you are too late to register. The contest has already begun.")

							else if(NextContestants.Find(P.ckey))
								P.ScrollText("Contest Receptionist", "You have already been registered for this contest.")
							else
								P.ScrollText("Contest Receptionist", "You must choose a Pokemon to enter with.")
								var/mob/Pokemon/RPoke = P.Party_Choose("Enter which Pokemon?", P.Party)
								if(!RPoke) return
								P.RoundPokemon = RPoke
								NextContestants += P.ckey
								P.ScrollText("Contest Receptionist", "You have been registered for the contest. We will globally announce when the contest is about to begin.")
					else
						P.ScrollText("Contest Receptionist", "There is currently no scheduled Contest. Sorry for the inconvience.")
						return
				else //No Contest has been set yet.
					P.ScrollText("Contest Receptionist", "There is currently no scheduled Contest. Sorry for the inconvience.")
					return






//Areas
area
	Contest_Arenas
		luminosity = 1

		var/City
		Net_City_Contest_Hall //Net City
			Stage
			City = "Net City"
		Ridgeport_Contest_Hall //Ridgeport
			Stage
			City = "Ridgeport"

//Contest Set-Up
obj/Contests

	Locations //These are where the contest halls will be located, placed in the center of the ring.
		var/Ribbon
		Net_City_Contest_Hall
		Ridgeport_Contest_Hall

	Contest
		var/list/Rounds = list() //Each players gets a round
		var/list/Judges = list() //List of Judges that are judging the CurrentContest
		var/area/Stage = null //This is set the the area the Location is in when the contest starts
		var/area/Arena = null
		var/Reboot //If a reboot was to happen during the contest, the Reboot will simply happen after the Contest.
	Round
		var/
			Owner
			list/Score = list("Targets" = 0, "Paths" = 0, "Judge Appeal")//This is that persons score, Targets /10, Judge Appeal/20

			//There are 10 targets to hit. Once they are all hit, the appeal is over.
			//Judge Appeal is for extra points for liked Pokemon Type, and Colours.

			mob/Pokemon/Pokemon //This should contain the Pokemon that the user will be using.
			Timer //This is how long it took for them to do their appeal
			Done //The appeal is done after this.

			Pattern



		proc/Send_Pokemon()
		proc/Begin()
			//So after the countdown begins, paths and targets should appear. One at a time.
			//They get 30 Pattern Tiles, 10 Targets.
			spawn(600) Done = 1 //They have 1 minute, in which the Round will automatically end.
			PickTarget(10)
			LayPath()

		proc/PickTarget(var/max = 40)
			spawn(1)
				if(!Pokemon || Done) return //If they have no pokemon, something has gone wrong. Stop the appeal.
				sleep(rand(1,max)) //Wait so they don't pop at the same time.
				var/list/Moves = list()
				for(var/obj/Moves/M in Pokemon.Moves)
					if(M.Type != "Unprogramed") Moves += M.Type
				var/mob/Pokemon/Target/T = new(locate(CurrentContest.x + rand(-7,7), CurrentContest.y + rand(-5,3), CurrentContest.z))
				T.icon_state = "[pick(Moves)]"
		proc/LayPath(var/max = 40)
			spawn(1)
				if(!Pokemon || Done) return
				sleep(rand(1,max))
				var/list/Patterns = typesof(/obj/Contests/Path/Shapes)
				Patterns -= /obj/Contests/Path/Shapes
				var/obj/Contests/Path/Shapes/S = pick(Patterns)
				S = new S

				S.Owner = Owner
				S.loc = locate(CurrentContest.x + rand(-7,7), CurrentContest.y + rand(-5,3), CurrentContest.z)
				S.Arrange()






		proc/PickPattern(var/max = 70)
			sleep(rand(1,max))

//Paths//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Contests
	Path
		icon = 'ContestHall.dmi'
		icon_state = "Directional Tile"
		var/obj/Contests/Path/Shapes/BuilderOwner
		var/Owner
		SteppedOff(var/mob/Pokemon/P)
			if(!isPokemon(P)) return 1
			spawn(0)
				if(P.dir == dir)
					var/mob/Player/O = GetOwner(P.Owner)
					if(O.ckey == BuilderOwner.Owner)
						BuilderOwner.DeletePeice(src)
			return 1
		SteppedOn(var/mob/Pokemon/P)
			if(!isPokemon(P)) return 1
			spawn(0)
				if(P.dir == dir)
					var/mob/Player/O = GetOwner(P.Owner)
					if(O.ckey == BuilderOwner.Owner)
						BuilderOwner.DeletePeice(src)
			return 1

		Shapes
			invisibility = 1
			SteppedOff()
				..()
			var/list/Peices = list()
			proc/Arrange()
			proc/DeletePeice(var/obj/Contests/Path/Path)
				Peices -= Path
				del Path
				if(!length(Peices))
					var/mob/Player/P = GetOwner(Owner)
					if(!P) return
					var/obj/Contests/Round/R = P.Round
					if(!R) return
					R.Score["Paths"] += 1
					R.LayPath(40)
					del src


			L_Shape
				Arrange()
					var/turf/T1 = locate(x,y+3,z)
					if(!findtext("[T1.loc.type]","Stage"))
						y -= 3
					T1 = locate(x+2,y,z)
					if(!findtext("[T1.loc.type]","Stage"))
						x -= 2
					for(var/i = 1, i <= 3, i++)
						var/obj/Contests/Path/P = new(locate(x,y+i,z))
						Peices += P
						P.dir = 2
						P.BuilderOwner = src
					for(var/i = 0, i <= 2, i++)
						var/obj/Contests/Path/P = new(locate(x+i,y,z))
						P.dir = 4
						Peices += P
						P.BuilderOwner = src
					//Important
					loc = null

			Line_Horizontal
				Arrange()
					var/turf/T1 = locate(x+6,y,z)
					if(!findtext("[T1.loc.type]","Stage"))
						x -= 6
					var/DIR = pick(4,8)
					for(var/i = 0, i <= 6, i++)
						var/obj/Contests/Path/P = new(locate(x+i,y,z))
						Peices += P
						P.dir = DIR
						P.BuilderOwner = src
					loc = null

			Line_Vertical
				Arrange()
					var/turf/T1 = locate(x,y+6,z)
					if(!findtext("[T1.loc.type]","Stage"))
						y -= 4
					var/DIR = pick(1,2)
					for(var/i = 0, i <= 4, i++)
						var/obj/Contests/Path/P = new(locate(x,y+i,z))
						Peices += P
						P.dir = DIR
						P.BuilderOwner = src
					loc = null
			//Figure_8
			//Z_Shape
			W_Shape
				Arrange()
					var/turf/T1 = locate(x,y+3,z)
					if(!findtext("[T1.loc.type]","Stage"))
						y -= 3
					T1 = locate(x+4,y,z)
					if(!findtext("[T1.loc.type]","Stage"))
						x -= 4
					for(var/i = 0, i <= 3, i++)
						if(i != 0)
							var/obj/Contests/Path/P = new(locate(x,y+i,z))
							Peices += P
							P.dir = 2
							P.BuilderOwner = src
						var/obj/Contests/Path/PP = new(locate(x+4,y+i,z))
						Peices += PP
						PP.dir = 1
						PP.BuilderOwner = src
					for(var/i = 0, i <= 3, i++)
						var/obj/Contests/Path/P = new(locate(x+i,y,z))
						P.dir = 4
						Peices += P
						P.BuilderOwner = src
					var/obj/Contests/Path/P = new(locate(x+2,y+1,z))
					P.dir = 2
					Peices += P
					P.BuilderOwner = src
					//Important
					loc = null
			//Q_Shape
			//M_Shape


		Enter




//Targets//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/mob/Pokemon/Target
	pixel_y = -16
	pixel_x = -16
	icon = 'ContestTargets.dmi'
	Click() //Default its Click to do nothing
	Create(var/Type)

	DeathCheck(var/mob/Pokemon/Killer) //This means there is a potential they did Damage, so they hit the target.
		loc = null //Move the target so it cannot be seen.
		var/obj/Moves/LA = Killer.LastAttack //Quickly capture which attack we are focusing on for points.
		if(!LA) return //There needs to be an attack to access if the types are the same.
		var/mob/Player/P = GetOwner(Killer.Owner)
		if(!P) return
		var/obj/Contests/Round/R = P.Round
		if(!R) return

		if(LA.type == icon_state) R.Score["Targets"] += 1 //Same type gets 1 points
		else R.Score["Targets"] += 0.5 //Not same type gets half a point

		//Check if the Judges liked it.
		for(var/obj/Contests/Judges/J in CurrentContest.Judges)
			var/Points = 0
			if(J.PreferedPokemon.Find(Killer.type)) Points += 0.25
			if(J.PreferedType == LA.Type) Points += 0.25

			R.Score["Judge Appeal"] = min(20, R.Score["Judge Appeal"] + Points)

			if(Points == 1)
				J.overlays += /obj/HUD/OMG
				spawn(20)
					J.overlays -= /obj/HUD/OMG
			if(Points == 2)
				J.overlays += /obj/HUD/LOVE
				spawn(20)
					J.overlays -= /obj/HUD/LOVE

		R.PickTarget()
		spawn(40) del src


	Paralysis(var/mob/Pokemon/P)
		DeathCheck(P)
	Sleep(var/mob/Pokemon/P)
		DeathCheck(P)
	Poison(var/mob/Pokemon/P)
		DeathCheck(P)
	Confuse(var/mob/Pokemon/P)
		DeathCheck(P)
	GiveTempStat(var/mob/Pokemon/P)
		DeathCheck(P)
		sleep(50)
	Leech_Drain(var/mob/Pokemon/P)
		DeathCheck(P)

proc/
	Find_Next_Time()
		var/TOD = world.timeofday - (5*32000)
		if(TOD < 320000) NextTime = 320000 //If its between 00AM and 10AM, set the contest at 10AM
		else if(TOD >= 320000 && TOD < 576000) NextTime = 576000
		else NextTime = 320000
	Find_Next_Location()
		var/list/Locs = typesof(/obj/Contests/Locations)
		Locs -= /obj/Contests/Locations
		NextLocation = pick(Locs)
	Find_Next_Judges()
		var/list/Judges = typesof(/obj/Contests/Judges)
		Judges -= /obj/Contests/Judges
		for(var/i = 1, i <= 3, i++) //We need 3 judges
			var/J = pick(Judges)
			if(!NextJudges.Find(J))
				Judges -= J
				NextJudges += J //We have a Judge who isn't already on the panel.
			else i -= 1



var/list/ContestLocations = list()//Mightnot need.
var/obj/Contests/NextLocation
var/NextTime
var/list/NextContestants = list("")//This is by ckey.
var/list/NextJudges = list()
var/obj/Contests/Contest/CurrentContest = null
var/list/PreviousContest = list()
var/RegistrationOpen = 0

mob/Player
	var //Player vars
		tmp/obj/Contests/Round/Round
		tmp/mob/Pokemon/RoundPokemon
	Logout()
		..()
		NextContestants -= ckey



proc/ShowWinners(var/list/L, var/mob/Player/P)
	spawn()
		if(!P.client || !isPlayer(P))
			return
		winset(P, "ContestWinner", "is-visible=true")
		for(var/i = 1, i<= 8, i++)
			var/list/Score = L[i]
			if(L)
				winset(P, "ContestWinner.Rank[i]", "is-visible=true")
				winset(P, "ContestWinner.ContestName[i]", "is-visible=true")
				winset(P, "ContestWinner.ContestPoints[i]", "is-visible=true")
				winset(P, "ContestWinner.ContestPoke[i]", "is-visible=true")

				winset(P, "ContestWinner.ContestName[i]", "text='[PlayerNames[Score["Owner"]]]'")
				winset(P, "ContestWinner.ContestScore[i]", "text='[Score["Total"]]'")

				var/icon/I = new('PokedexIcons.dmi', "[Score["Poke"]]")
				var/iconfile = fcopy_rsc(I)
				winset(src, "ContestWinner.ContestPoke[i]", "image=\ref[iconfile]")
			else
				winset(P, "ContestWinner.Rank[i]", "is-visible=false")
				winset(P, "ContestWinner.ContestName[i]", "is-visible=false")
				winset(P, "ContestWinner.ContestPoints[i]", "is-visible=false")
				winset(P, "ContestWinner.ContestPoke[i]", "is-visible=false")
proc/ContestAnnounce(var/Text)
	var/area/A = CurrentContest.Arena
	for(var/mob/Player/M in A)
		M<<"<font color = #FF00FF>(Contest) [Text]"

	A = CurrentContest.Stage
	for(var/mob/Player/M in A)
		M<<"<font color = #FF00FF>(Contest) [Text]"
proc/Start_Contest(var/obj/Contests/Locations)
	set background = 1
	if(!NextLocation || !length(NextJudges) || !length(NextContestants)) return

	CurrentContest = new/obj/Contests/Contest (null)
	var/atom/NL=locate(NextLocation)
	CurrentContest.loc = NL.loc





	//Set up the contestants.
	for(var/key in NextContestants)
		var/obj/Contests/Round/R = new
		R.Owner = key
		CurrentContest.Rounds += R
	NextContestants = list() //Reset Next Contestants variable.

	//Set up the Judges
	var/counter = -1
	for(var/i in NextJudges)
		CurrentContest.Judges += new i(locate(CurrentContest.x + counter, CurrentContest.y + 5, CurrentContest.z))
		counter += 1
	NextJudges = list()

	//Find the areas (Stage and Surrounding Area)
	var/turf/T = CurrentContest.loc
	CurrentContest.Stage = T.loc
	T = locate(T.x, T.y - 7, T.z)
	CurrentContest.Arena = T.loc

	world << "<font color = #FF00FF>(Contest) The Contest has begun. All contestants are asked to stay in the Arena until all appeals have been completed. Thank you."

	//Start the Appeals!
	for(var/obj/Contests/Round/R in CurrentContest.Rounds)
		sleep(10)
		var/mob/Player/P = GetOwner(R.Owner)
		if(!P)
			ContestAnnounce("[PlayerNames[R.Owner]] has been disqualified for not being present at the time of their appeal.")
			del R
			continue
		else //The Player excists in the world

			if(get_dist(CurrentContest, P) >= 15) //They are not in the arena.
				P<<System("In order to participate in a Contest, you must be in the arena at the start of appeals.")
				ContestAnnounce(" [PlayerNames[R.Owner]] has been disqualified for not being present at the time of their appeal.")

				del R
				continue

			P.Round = R
			R.Pokemon = P.RoundPokemon
			ContestAnnounce( "[P] will now make their appeal.")
			if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall(0)
			if(P.client) P.client.eye = CurrentContest
			P.loc = locate(CurrentContest.x, CurrentContest.y - 6, CurrentContest.z)
			P.dir = 1
			sleep(40)
			var/obj/HUD/Ditto_Numbers/D = new
			P.client.screen += D
			for(var/i = 3, i>=0, i--)
				D.icon_state = "[i]"
				sleep(10)
			del D





			spawn() R.Begin()

			while(!R.Done)
				if(!P || !P.client || (P.client.inactivity/10) >= 30)
					R.Done = 1
				R.Timer += 1
				sleep(10) //The timer will count in seconds.
			//Remove from Stage
			P.RoundPokemon = null
			if(P.client) P.client.eye = P
			P.loc = locate(CurrentContest.x, CurrentContest.y - 9, CurrentContest.z)
			if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall(0)

			ContestAnnounce("[PlayerNames[R.Owner]] has finished their appeal.")

			P.Round = null //They are done, so they cannot mess with their score anymore.
			for(var/atom/movable/C in CurrentContest.Stage)
				if(istype(C,/mob/Pokemon/Target) || istype(C,/obj/Contests/Path))
					del C

	//End the contest

	var/list/NUM[10] //Only suppose to have 8.. but just in case.
	var/Counter = 0
	var/leader = 1
	var/highest = 0
	for(var/obj/Contests/Round/R in CurrentContest.Rounds)
		Counter += 1
		//Do some Scoring
		var/list/NewScore = list()
		NewScore["Targets"] = R.Score["Targets"]
		NewScore["Paths"] = R.Score["Paths"]
		NewScore["Judge Appeal"] = R.Score["Judge Appeal"]
		NewScore["Total"] = NewScore["Targets"] + NewScore["Paths"] + NewScore["Judge Appeal"]
		if(NewScore["Total"] > highest)
			leader = Counter
			highest = NewScore["Total"]
		NewScore["Owner"] = R.Owner
		if(R.Pokemon) NewScore["Poke"] = R.Pokemon.Number
		NUM[Counter] = NewScore.Copy()

	var/Done = 0

	if(length(NUM) > 1)
		while(!Done)
			Done = 1
			for(var/i, i <= length(NUM), i++)
				if(i+1 > length(NUM)) break
				var/list/NUM1 = NUM[i]
				var/list/NUM2 = NUM[i+1]
				if(!NUM1 || !NUM2) break
				if(NUM1["Total"] > NUM2["Total"])
					NUM[i] = NUM2
					NUM[i+1] = NUM1
					Done = 0

	var/list/Winner = NUM[leader]
	var/HighestScore = Winner["Total"]
	var/HighestKey = Winner["Owner"]

	PreviousContest[NextLocation] = NUM
	NextLocation = null
	for(var/i in CurrentContest.Judges) del i
	ContestAnnounce("[PlayerNames[HighestKey]] has won the Contest with a score of [HighestScore]")
	spawn(40)
		for(var/mob/Player/P in CurrentContest.Arena)
			ShowWinners(NUM, P)
	del CurrentContest

	//if(Reboot) world.Reboot()


/*	  repeat
    swapped = false
    for i = 1 to length(A) - 1 inclusive do:
      if A[i-1] > A[i] then
        swap( A[i-1], A[i] )
        swapped = true
      end if
    end for
  until not swapped
		for(var/i = 1, i <= Count, i++)
			for(var/j = 1 , j<= Count, j++)
				var/obj/Contests/Round/R1 = Order[j]
				var/obj/Contests/Round/R2 = Order[j+1]

				if(R1.Score < R2.Score) //Switch them/.
					Order[j] = R2
					Order[j+1] = R1*/












obj/HUD/Ditto_Numbers
	icon = 'DittoNumbers.dmi'
	icon_state = "3"
	screen_loc = "8,8"


//Seals//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Balls/var/obj/Seals/Seal


obj/Seals/Seal
	icon = 'Poke Seals.dmi'
	Pink_Heart_Seal
		icon_state = "Pink Heart"

mob/Player/var/list/Seals = list("Pink Heart Seal" = 1,"Blue Heart Seal" = 1,"Black Heart Seal" = 1,"Green Heart Seal" = 1)

obj/Important_Items
	Seal_Case
		icon = 'Important Items.dmi'
		icon_state = "Seal Case"
		Description = "A case for storing seals. Seals can be attached to Pokeballs for an extra flare when they are released from their Pokeballs. Click to use, then select which Seal to use, and which Pokeball to attach it to."
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			var/list/options = list("Cancel")
			if(length(P.Seals))
				options += "Give Pokemon Seal"
			for(var/mob/Pokemon/p in P.Party) if(p.Ball.Seal)
				options += "Take Pokemon Seal"
				break

			switch(input(P,"What would you like to do?") in options)
				if("Cancel") return
				if("Give Pokemon Seal") //Give a Pokemon a seal
					var/list/Q = list()
					Q += "Cancel"
					for(var/i in P.Seals)
						Q["[i] x[P.Seals[i]]"] = i
					var/input = input(P, "Use which seal?") in Q
					if(input == "Cancel") return
					input = Q[input]
					var/mob/Pokemon/p = input(P, "Use on which Pokemon?","Seals","Cancel") in P.Party
					if(p.Ball.Seal)
						P<<System("[p]'s Pokeball is already equiped with seal.")
						return
					if(P.Seals[input] && isPokemon(p)) //Make sure they still have the seal
						P.Seals[input] = max(P.Seals[input] - 1, 0)
						if(P.Seals[input] == 0) P.Seals -= input
						p.Ball.Seal = input
						p.Ball.overlays += image('Poke Seals.dmi', "[input] Ball")
						P<<System("Seal added to [p].")
				if("Take Pokemon Seal")
					var/mob/Pokemon/p = input(P, "Use on which Pokemon?","Seals","Cancel") in P.Party
					if(p.Ball.Seal)
						p.Ball.overlays -= image('Poke Seals.dmi', "[p.Ball.Seal] Ball")
						P.Seals[p.Ball.Seal] += 1
						p.Ball.Seal = null
						P<<System("Seal removed from [p].")
					else
						P<<System("[p] does not have a Seal.")
						return





mob/GM
	verb
		Start_Contest_Verb()
			set category = "Staff"
			set name = "Start Contest"
			var/NextName
			if(CurrentContest) return //We can't start two contests at once
			Find_Next_Location() //Find Location
			Find_Next_Judges() //Find Judges
			if(NextLocation == /obj/Contests/Locations/Net_City_Contest_Hall) NextName = "Net City"
			if(NextLocation == /obj/Contests/Locations/Ridgeport_Contest_Hall) NextName = "Ridgeport"

			var/time = input("Start Contest in how many Minutes?") as num
			world << System("[usr] is starting a Pokemon Contest in [time] minutes at the [NextName] Contest Hall")
			NextTime = world.realtime + (time*600)
			sleep(time*600)
			Start_Contest()












