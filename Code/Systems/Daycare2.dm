mob/Player

	var
		DaycarePokemon = list()
		DaycareOwing = list()
	proc
		DaycareLogin()
			for(var/mob/Pokemon/P in DaycarePokemon)
				if(!P.DaycareLady) world <<"[P] does not have a DaycareLady.."
				else
					for(var/mob/NPC/DaycareLady/DL in world)
						DL.AddPokemontoPen(P)
		DaycareLogout()
			for(var/mob/NPC/DaycareLady/DL in world)
				for(var/mob/Pokemon/P in DaycarePokemon)
					DL.RemovePokemonfromPen(P)

//GM Verbs pretaining to Daycare//-------------------------------------------------------------------------------------
mob/MGM/verb/Create_Eggssss() //There is a proc with this name, so I just made a weird verb and....
	set name = "Create Egg" //Renamed the verb here.
	set category = "Staff"
	if(istype(usr,/mob/Player))
		var/mob/Player/M = usr
		var/list/PokemonTypes = typesof(/mob/Pokemon)
		var/list/PokemonList = list()
		var/mob/Pokemon/Mother
		var/mob/Pokemon/Father
		var/Poke
		for(var/i in PokemonTypes)
			Poke = copytext("[i]",14)
			PokemonList[Poke] = i
		var/input = input("Mother?") in PokemonList
		Poke = PokemonList[input]
		Mother = new Poke
		Mother.Create(50)
		input = input("Father?") in PokemonList
		Poke = PokemonList[input]
		Father = new Poke
		Father.Create(50)
		var/mob/Pokemon/P = Create_Egg(Mother, Father)
		if(istext(P)) world <<P
		else
			M.Party[M.AddPKMNParty()] = P
			P.Owner = usr.ckey
		del Mother
		del Father
		M.UpdateParty()
//Daycare Ladys//--------------------------------------------------------------------------------------------------
mob/NPC/DaycareLady

	icon = 'MaleWhiteBase.dmi'
	ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Blue Civilian Clothes", "Hair" = "LongHairBlack")
	Pointer = 1
	var/
		MaxLevel
		MinLevel = 0
		list/DaycarePen = list()
		list/Eggs = list()

	Daycare_Lady_Andrea
		MaxLevel = 25

	Daycare_Lady_Jessica
		MinLevel = 25
		MaxLevel = 45

	Daycare_Lady_Zana
		MinLevel = 45
		MaxLevel = 65

	Del() //You should not be able to delete the DaycareLadies, as they will store all People's Pokemon
		world <<System("Daycare Ladys cannot be eradicated. They contain needed information for functionality of Daycares")


//Talking to Daycare Ladies//-----------------------------------------------------------------------------------------------------------------
	Click() //Talk to Daycare Lady
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		if(M.TalkingTo["DayCare"]) return
		M.TalkingTo["DayCare"] = 1
		M.ScrollText("[name]", "Welcome to the Pokemon Daycare. There are currently [length(DaycarePen)] Pokemon residing at this daycare.")


		MainMenu //Label so that the procedure can loop
		var/list/TalkOptions = list("Leave Pokemon", "Get Pokemon", "Where am I?")
		if(length(Eggs)) TalkOptions += "I'd like to adopt an egg"
		if(M.DaycareOwing[name]) TalkOptions += "Pay Tab"
		TalkOptions += "Nothing.."


		var/input = input(M, "How can I help you today?","Daycare Lady") in TalkOptions
		switch(input)
			if("Where am I?")
				M.ScrollText("[name]", "You are at a Pokemon Daycare. Here, have this Pokedex Help File.")
				M.PokedexUnlock("Breeding")
				M.PokedexUnlock("Daycares")
				M.PokedexUnlock("Daycare Ladys")
			if("Nothing..")
				M.ScrollText("[name]", "Have a nice day.")
			if("Pay Tab")
				M.ScrollText("[name]", "You currently still owe [M.DaycareOwing[name]]. How much would you like to pay today?")

				var/Paying = round(input("How much are you paying off your tab?") as num)
				Paying = min(Paying, M.DaycareOwing[name])

				if(Paying <= 0 || Paying > M.Money)
					M.ScrollText("[name]", "We do expect your tab to be paid. Please return when you have the funds.")
					goto MainMenu

				M.Money -= Paying
				M.DaycareOwing[name] = max(0, M.DaycareOwing[name] - Paying)

				if(!M.DaycareOwing[name])
					M.ScrollText("[name]", "You have paid off all your debts at this daycare. You may now use the services here.")
				else
					M.ScrollText("[name]", "You still owe [M.DaycareOwing[name]] at this daycare. Our services will become available once you pay this fee.")
				goto MainMenu

			if("Get Pokemon")
				var/mob/Pokemon/P = M.Party_Choose("Get which Pokemon?", M.DaycarePokemon)
				if(P)
					M.ScrollText("[name]", "[P]? Yes, [P.ReturnGender()] has been doing really well here at the Daycare. [P] has gained [P.Level - P.EnterDaycareLevel] levels.")
					if(!M) return

					//Do they have an egg?//------------------------------------------------------------------------------------------------------
					var/OpenSlot = M.AddPKMNParty()
					if(P.HoldingPokemonEgg && isPokemon(P.HoldingPokemonEgg)) //Is their an egg, is it a Pokemon?
						var/Type = copytext(P.HoldingPokemonEgg.Ball.icon_state,5)
						M.ScrollText("[name]", "Also, it seems that [P] layed an egg whilst staying here at the Daycare. We encourage trainers to keep their Pokemons eggs and hatch them, but if you want we will keep it until we find a trainer interested in taking it. From my experience, if I had to guess, its probably [copytext(Type,1,2)=="E"?  "an":"a"] [Type] type.")
						if(M) M.ScrollText("[name]", "Would you like to take the egg?")
						if(!M) return
						if(alert("Add egg to Party?","Daycare","No","Yes") == "Yes")
							if(OpenSlot)
								M.Party[OpenSlot] = P.HoldingPokemonEgg
								P.HoldingPokemonEgg.Owner = M.ckey
								M<<System("You revieved the egg!")
								if(!istype(P,/mob/Pokemon/Ditto)) P.HoldingPokemonEgg = 1
								M.UpdateParty()
								M.Title_Check()
							else
								M<<System("You currently don't have any room for this egg. Come back when you do.")
								M.TalkingTo -= "DayCare"
								return
						else
							M.ScrollText("[name]", "Alright, we'll keep the egg then.")

							Eggs += P.HoldingPokemonEgg
							P.HoldingPokemonEgg.OriginalTrainer = M.ckey //This is so they can't adopt eggs they have given up.
							if(!istype(P,/mob/Pokemon/Ditto)) P.HoldingPokemonEgg = 1 //They can only have one egg, unless it's a ditto.

					//Daycare Withdrawl//----------------------------------------------------------------------------------------------------------------------------
					OpenSlot = M.AddPKMNParty() //Have to recheck if there is room in the party (If they took an egg)
					if(!OpenSlot)
						M.ScrollText("[name]", "You currently cannot have anymore Pokemon in your Party, come back when you have 5 or less.")
						goto MainMenu
					else
						var/Cost = ((P.Level - P.EnterDaycareLevel) * 100) + 100

						M.ScrollText("[name]", "Would you like [P] to join your party? It will cost you [Cost] to have [P] returned.")
						if(!M) return
						if(alert("Add [P] to Party?","Daycare","No","Yes") == "Yes")
							//Work out how the service will be paid//
							if(M.Money <= Cost)
								M.ScrollText("[name]", "You currently do not have the appropraite funds to collect [P]. Would you like to add [Cost] to your tab, here at this daycare? You will not be able to use this Daycare until your tab has been payed off.")
								if(alert("Add [Cost] to your tab?","Daycare","No","Yes") == "Yes") M.DaycareOwing[name] += Cost
								else goto MainMenu
							else
								M.Money -= Cost

							if(OpenSlot)
								M.Party[OpenSlot] = P
								M.DaycarePokemon -= P
								P.DaycareLady = null
								P.EnterDaycareLevel = null
								M<<System("[P] has joined your party!")
								P.Exp = round(P.Exp)
								M.UpdateParty()
								M.Title_Check()

							RemovePokemonfromPen(P)
							M.ScrollText("[name]", "Thank you, please come again soon!.")


			if("Leave Pokemon") //Deposit into Daycare//------------------------------------------------------------------------------------------
	 		//They have space to put a Pokemon in.
				var/OpenSlot = M.AddPKMNParty()
				var/mob/Pokemon/P = M.Party_Choose("Leave which Pokemon?", M.Party)
				if(!P) return

				if(OpenSlot == 2)
					M.ScrollText("[name]", "Sorry, you must have one Pokemon on you at all times..")
					goto MainMenu
				else if(length(M.DaycarePokemon) >= 3)
					M.ScrollText("[name]", "Sorry, you already have two Pokemon in a Daycare.")
					goto MainMenu
				else if(P.Level > MaxLevel)
					M.ScrollText("[name]", "Sorry, we do not accept Pokemon over level [MaxLevel].")
					goto MainMenu
				else if(P.Level < MinLevel)
					M.ScrollText("[name]", "Sorry, we do not accept Pokemon under level [MinLevel].")
					goto MainMenu
				else if(istype(P.Ball,/obj/Balls/Egg))
					M.ScrollText("[name]", "Sorry, we currently do not accept Pokemon eggs into the Daycare.")
					goto MainMenu
				else if(M.DaycareOwing[name])
					M.ScrollText("[name]", "Sorry, the Daycare Policy states that you cannot continue to use the services provided unless you have paid off your tab. You currently owe [M.DaycareOwing[name]]")
					goto MainMenu
				else
					M.DaycarePokemon += P //Adds the Pokemon to the Players Daycare Pokemon


					AddPokemontoPen(P)    //Physically adds the Pokemon to the Pen
					P.EnterDaycareLevel = P.Level
					P.DaycareLady = name //This marks which Daycare they are at.

					M.RemoveFromParty(P)

					M.ScrollText("[name]", "Alright, I will take [P] for a bit. Come back soon!")



		M.TalkingTo -= "DayCare"
//AddPokemontoPen//Physically adds the Pokemon to the Pen outside//------------------------------------------------------------------------------------------------------------------------
	proc/AddPokemontoPen(var/mob/Pokemon/P)
		DaycarePen += P //Adds the Pokemon to the Lady's  Daycare Pokemon

		var/mob/DaycarePokemon/DP = new

		for(var/obj/Daycare/PenSpawn/PS)
			if(PS.name == name)
				DP.loc = PS.loc

		DP.Pokemon = P
		DP.name = P.name
		DP.icon = P.icon
		DP.DaycareLady = src //Can save the source, because this object is temporary
		P.DaycareLady = name //Cannot save the source, will change at login

		DP.Wander()
//RemovePokemonfromPen//Removes the Daycare Mob from the Daycare
	proc/RemovePokemonfromPen(var/mob/Pokemon/Poke)
		DaycarePen -= Poke
		flick("Send",Poke)
		for(var/mob/DaycarePokemon/P in world)
			if(P.Pokemon == Poke)
				del P
obj/Daycare/PenSpawn
	Daycare_Lady_Andrea

	Daycare_Lady_Jessica

	Daycare_Lady_Zana



mob/DaycarePokemon
	icon_state = "Blank"
	var/mob/Pokemon/Pokemon = null
	var/mob/NPC/DaycareLady/DaycareLady = null // This is set at creation

	proc/Wander()
		set background = 1
		spawn()
			 //Without a Pokemon, this is pointless
			var/mob/Player/O = GetOwner(Pokemon.Owner) //The Owner.
			flick("Send",src)
			while(src && Pokemon)
				icon_state = null
				if(Pokemon.Level >= DaycareLady.MaxLevel)
					O.QuestCheck("DaycareReachLevel", Pokemon)
					flick("Send",src)
					del src


				sleep(pick(10,10,15,20))
				Pokemon.Exp += (O.Badges() + 1) * 0.20
				Pokemon.Level_Check()

				if(!frozen) dir = pick(dir,1,2,4,8)
				step(src,src.dir)
	Click()
		var/mob/Pokemon/P = Pokemon
		if(!P) return
		usr<<System("[P] seems to be level [P.Level]")
	Bump(D)
		if(istype(D,/mob/DaycarePokemon))
			if(prob(65))
				var/mob/DaycarePokemon/b = src
				var/mob/DaycarePokemon/a = D
				var/mob/Pokemon/P = a.Pokemon
				var/mob/Pokemon/PP = b.Pokemon


				var/mob/Pokemon/Female
				var/mob/Pokemon/Male
				var/mob/Pokemon/Ditto


				//Check the Genders
				if(P.Gender == "Unbreedable" || PP.Gender == "Unbreedable") return ..() //If either is incompatiable, there is no baby..
				if(P.Gender == "Male") Male = P
				if(PP.Gender == "Male") Male = PP //If P was a male, it will replace it, but this will leave no Female in the equation
				if(P.Gender == "Female") Female = P
				if(PP.Gender == "Female") Female = PP//If P was a female, it will replace it, but this will leave no Male in the equation
				if(istype(P,/mob/Pokemon/Ditto)) Ditto = P
				if(istype(PP,/mob/Pokemon/Ditto)) Ditto = PP

				if(!Female && Male && Ditto) Female = Ditto
				if(!Male && Female && Ditto) Male = Ditto


				if(Female && Male)
					if(!Female.HoldingPokemonEgg)
						Female.HoldingPokemonEgg = Create_Egg(Female, Male, Ditto)
						if(isPokemon(Female.HoldingPokemonEgg))
							a.dir = get_dir(a, b)
							b.dir = get_dir(b, a)
							a.frozen = 1
							b.frozen = 1
							for(var/i = 1, i <= 5, i++)
								a.flick_overlay('Moves.dmi', "Heart")
								b.flick_overlay('Moves.dmi', "Heart")
								sleep(20)
							a.frozen = 0
							b.frozen = 0
						else Female.HoldingPokemonEgg = null



proc
	FindDaycareLady(var/Name)
		for(var/mob/NPC/DaycareLady/DL in world)
			if(DL.name == Name) return DL
		return 0


mob/Pokemon
	var/
		EggSteps //The amount of steps each Pokemon takes to hatch
		mob/Pokemon/HoldingPokemonEgg //If a female Pokemon has an egg, this is where it is stored till it is picked up.
		DaycareLady //The Daycare Lady the Pokemon is staying with. Pokemon
		EnterDaycareLevel //The level the Pokemon entered the Daycare. Used to measure how many levels the Pokemon raised.
	proc
		Hatch() //When an egg needs to hatch, it runs this
			if(Owner)

				var/mob/Player/O = GetOwner(Owner)
				if(O.frozen) return
				if(O.ControlingPokemon) O.ControlingPokemon.ReturntoBall(0)

				O.frozen = 1
				O.overlays += /obj/HUD/OMG
				spawn(20) O.overlays -= /obj/HUD/OMG

				O<<System("Your egg is hatching!")
				O.dir = 2
				Ball.loc = locate(O.x,O.y-1,O.z)
				sleep(40)
				flick("[Ball.icon_state] Hatch",Ball)
				sleep(7)
				src.loc = Ball.loc
				del Ball
				Ball = new/obj/Balls/Poke_Ball
				Ball.Pokemon = src
				Ball.name = src.name
				sleep(20)
				O<<System("[src] hatched from the egg!")
				O.Title_Check("Egg Hatch")
				O.frozen = 0
				O.Speeding = 0 //This is some weird bug that effects the movement delay.
				ReturntoBall(0)




obj/Balls/Egg
	icon = 'Eggs.dmi'
	icon_state = "Egg Normal/Fly"
	Click()
		var/mob/Pokemon/P = Pokemon

		if(P.EggSteps <= 1080) usr<<System("It's making sounds inside! It's going to hatch soon!")
		else if(P.EggSteps <= 2160) usr<<System("It moves around inside sometimes. It must be close to hatching.")
		else if(P.EggSteps > 2160) usr<<System("Wonder what's inside? It needs more time, though.")

proc/Create_Egg(var/mob/Pokemon/Mother, var/mob/Pokemon/Father,var/mob/Pokemon/Ditto)
	//This proc assumes we have already established a mother and father.
	//Therefore, we should have one but check to make sure they are both there and are both Pokemon.


	if(!Mother || !Father) return "No Mother or Father" //There is no result
	if(!isPokemon(Mother) || !isPokemon(Father)) return "Mother or Father is not a Pokemon" //There is no result

	//Now we must find out if both Pokemon are compatiable with eachother.//-----------------------------------------------------------------------------------------------
	//To do this, we check their egg groups.

	var/Match = 0
	for(var/i in Mother.EggGroups)
		for(var/j in Father.EggGroups)
			if(j == i) Match = 1

	if(!Match) return "Egg Groups do not match" //They are incompatable..

	//Now we have to find out which Offspring will result in them breeding.//---------------------------------------------------------------------------------------------
	var/mob/Pokemon/Offspring

	var/GotIt = 0
	Offspring = new Mother.type
	if(Ditto && Ditto == Mother)
		del Offspring
		Offspring = new Father.type
	while(!GotIt)
		sleep(1)
		if(!Offspring.Unevolve)
			break
		else
			var/mob/UE = new Offspring.Unevolve
			del Offspring
			Offspring = UE

	Offspring.Create(5) //Set up the Pokemon to be level 5

	//Give Egg Moves from the Mother and Father.
	for(var/obj/Moves/M in Father.Moves)
		if(Offspring.EggMoves.Find(M.type))
			if(Offspring.Moves.len >= 6) //It checks to make sure there is room to add another move, if not we have to delete one.
				del pick(Offspring.Moves)
				var/obj/Moves/MMM = new M.type
				Offspring.Moves += MMM
				MMM.Owner = Offspring.
			else
				var/obj/Moves/MMM = new M.type
				Offspring.Moves += MMM
				MMM.Owner = Offspring
	for(var/obj/Moves/M in Mother.Moves)
		if(Offspring.EggMoves.Find(M.type))
			if(Offspring.Moves.len >= 6) //It checks to make sure there is room to add another move, if not we have to delete one.
				del pick(Offspring.Moves)
				var/obj/Moves/MMM = new M.type
				Offspring.Moves += MMM
				MMM.Owner = Offspring.
			else
				var/obj/Moves/MMM = new M.type
				Offspring.Moves += MMM
				MMM.Owner = Offspring

	//Give it an Egg/Pokeball---------------------------------------------

	Offspring.Ball = new/obj/Balls/Egg

	var/obj/Balls/B = Offspring.Ball
	B.name = "Egg"
	B.Pokemon = Offspring

	switch(Offspring.Type1)

		if("Dark") B.icon_state = "Egg Dark"
		if("Fire") B.icon_state = "Egg Fire"
		if("Water")  B.icon_state = "Egg Water/Ice"
		if("Ice")  B.icon_state = "Egg Water/Ice"
		if("Bug")  B.icon_state = "Egg Grass/Bug"
		if("Grass")  B.icon_state = "Egg Grass/Bug"
		if("Ground")  B.icon_state = "Egg Ground/Rock"
		if("Rock")  B.icon_state = "Egg Ground/Rock"
		if("Electric")  B.icon_state = "Egg Electric"
		if("Psychic")  B.icon_state = "Egg Psychic/Ghost"
		if("Ghost")  B.icon_state = "Egg Psychic/Ghost"
		if("Steel")  B.icon_state = "Egg Steel"
		if("Poison")  B.icon_state = "Egg Poison"
		if("Fighting")  B.icon_state = "Egg Fighting"
		if("Dragon")  B.icon_state = "Egg Dragon"


				//Its pokeball must be an obj/Egg
				//It gets any moves its father knows and that are in its eggmoves list
				//The Female gets the egg...
				//EggLayed..You can only have one Egg to prevent multiple starters being breeded.

	return Offspring

//Data - Pokemon Egg Steps//--------------------------------------------------------------------------------------------------------------------------------------
mob/Pokemon
	Bulbasaur
		EggSteps = 5355
	Charmander
		EggSteps = 5355
	Squirtle
		EggSteps = 5355
	Caterpie
		EggSteps = 2805
	Weedle
		EggSteps = 2805
	Pidgey
		EggSteps = 4080
	Rattata
		EggSteps = 4080
	Spearow
		EggSteps = 4080
	Ekans
		EggSteps = 4080
	Pikachu
		EggSteps = 5355
	Sandshrew
		EggSteps = 5355
	NidoranF
		EggSteps = 5355
	NidoranM
		EggSteps = 5355
	Clefairy
		EggSteps = 5355
	Vulpix
		EggSteps = 5355
	Ninetales
		EggSteps = 5355
	Jigglepuff
		EggSteps = 5355
	Zubat
		EggSteps = 4080
	Oddish
		EggSteps = 5355
	Paras
		EggSteps = 5355
	Venonat
		EggSteps = 5355
	Diglett
		EggSteps = 5355
	Meowth
		EggSteps = 5355
	Psyduck
		EggSteps = 5355
	Mankey
		EggSteps = 5355
	Growlithe
		EggSteps = 5355
	Poliwag
		EggSteps = 5355
	Abra
		EggSteps = 5355
	Machop
		EggSteps = 5355
	Bellsprout
		EggSteps = 5355
	Tentacool
		EggSteps = 5355
	Geodude
		EggSteps = 4080
	Ponyta
		EggSteps = 5355
	Slowpoke
		EggSteps = 5355
	Magnetmite
		EggSteps = 5355
	Farfetchd
		EggSteps = 5355
	Doduo
		EggSteps = 5355
	Seel
		EggSteps = 5355
	Grimer
		EggSteps = 5355
	Shellder
		EggSteps = 5355
	Cloyster
		EggSteps = 5355
	Gastly
		EggSteps = 5355
	Onix
		EggSteps = 6630
	Drowzee
		EggSteps = 5355
	Krabby
		EggSteps = 5355
	Voltorb
		EggSteps = 5355
	Exeggcute
		EggSteps = 5355
	Cubone
		EggSteps = 5355
	Lickitung
		EggSteps = 5355
	Koffing
		EggSteps = 5355
	Rhyhorn
		EggSteps = 5355
	Happiny
		EggSteps = 10455 //Not in order here...
	Chansey
		EggSteps = 10455
	Tangela
		EggSteps = 5355
	Kangaskhan
		EggSteps = 5355
	Horsea
		EggSteps = 5355
	Goldeen
		EggSteps = 5355
	Staryu
		EggSteps = 5355
	MrMime
		EggSteps = 6630
	Scyther
		EggSteps = 6630
	Jynx
		EggSteps = 6630
	Electabuzz
		EggSteps = 6630
	Magmar
		EggSteps = 6630
	Pinsir
		EggSteps = 6630
	Tauros
		EggSteps = 5355
	Magikarp
		EggSteps = 1530
	Lapras
		EggSteps = 10455
	Ditto
		EggSteps = 5355
	Eevee
		EggSteps = 9180
	Porygon
		EggSteps = 5355
	Omanyte
		EggSteps = 7905
	Kabuto
		EggSteps = 7905
	Aerodactyl
		EggSteps = 7905
	Snorlax
		EggSteps = 10455
	Articuno
		EggSteps = 20655
	Zapdos
		EggSteps = 20655
	Moltres
		EggSteps = 20655
	Dratini
		EggSteps = 10455
	Mewtwo
		EggSteps = 30855
	Mew
		EggSteps = 30855
	Chikorita
		EggSteps = 5355
	Cyndaquil
		EggSteps = 5355
	Totodile
		EggSteps = 5355
	Sentret
		EggSteps = 4080
	Hoothoot
		EggSteps = 4080
	Ledyba

		EggSteps = 4080
	Spinarak
		EggSteps = 4080
	Chinchou
		EggSteps = 5355
	Pichu
		EggSteps = 5355
	Cleffa
		EggSteps = 5355
	Igglybugg
		EggSteps = 5355
	Togepi
		EggSteps = 2805
	Togetic
		EggSteps = 2805
	Natu
		EggSteps = 5355
	Mareep
		EggSteps = 5355
	Marill
		EggSteps = 2805
	Sudowoodo
		EggSteps = 5355
	Hoppip
		EggSteps = 5355
	Aipom
		EggSteps = 5355
	Sunkern
		EggSteps = 5355
	Yanma
		EggSteps = 5355
	Wooper
		EggSteps = 5355
	Murkrow
		EggSteps = 5355
	Misdreavus
		EggSteps = 6630
	Unown
		EggSteps = 10455
	Wobbuffet
		EggSteps = 5355
	Girafarig
		EggSteps = 5355
	Pineco
		EggSteps = 5355
	Dunsparce
		EggSteps = 5355
	Gligar
		EggSteps = 5355
	Snubbull
		EggSteps = 5355
	Qwilfish
		EggSteps =5355
	Shuckle
		EggSteps = 5355
	Heracross
		EggSteps = 5355
	Sneasel
		EggSteps = 5355
	Teddiursa
		EggSteps = 5355
	Slugma
		EggSteps = 5355
	Swinub
		EggSteps = 5355
	Corsola
		EggSteps = 5355
	Remoraid
		EggSteps = 5355
	Delibird
		EggSteps = 5355
	Mantine
		EggSteps = 6630
	Skarmory
		EggSteps = 6630
	Houndour
		EggSteps = 5355
	Phanpy
		EggSteps = 5355
	Stantler
		EggSteps = 5355
	Smeargle
		EggSteps = 5355
	Tyrogue
		EggSteps = 6630
	Smoochum
		EggSteps = 6680
	Elekid
		EggSteps = 6680
	Magby
		EggSteps = 6680
	Miltank
		EggSteps = 6680
	Raikou
		EggSteps = 20655
	Entei
		EggSteps = 20655
	Suicune
		EggSteps = 20655
	Larvitar
		EggSteps = 10455
	Lugia
		EggSteps = 30855
	HoOh
		EggSteps = 30855
	Celebi
		EggSteps = 30855
	Treecko
		EggSteps = 5355
	Torchic
		EggSteps = 5355
	Mudkip
		EggSteps = 5355
	Poochyena
		EggSteps = 4080
	Zigzagoon
		EggSteps = 4080
	Wurmple
		EggSteps = 4080
	Lotad
		EggSteps = 4080
	Seedot
		EggSteps = 4080
	Tailow
		EggSteps = 4080
	Wingull
		EggSteps = 5355
	Ralts
		EggSteps = 5355
	Surskit
		EggSteps = 4080
	Shroomish
		EggSteps = 4080
	Slakoth
		EggSteps = 4080
	Nincada
		EggSteps = 4080
	Whismur
		EggSteps = 5355
	Makurita
		EggSteps = 5355
	Nosepass
		EggSteps = 5355
	Skitty
		EggSteps = 4080
	Sableye
		EggSteps = 6630
	Mawile
		EggSteps = 5355
	Aron
		EggSteps = 9180
	Meditite
		EggSteps = 5355
	Electrike
		EggSteps = 5355
	Plusle
		EggSteps = 5355
	Minum
		EggSteps = 5355
	Volbeat
		EggSteps = 4080
	Illumise
		EggSteps = 4080
	Budew
		EggSteps = 5355
	Gulpin
		EggSteps = 5355
	Carvanha
		EggSteps = 5355
	Wailmer
		EggSteps = 10455
	Numel
		EggSteps = 5355
	Torkoal
		EggSteps = 5355
	Spoink
		EggSteps = 5355
	Spinda
		EggSteps = 5355
	Trapinch
		EggSteps = 5355
	Cacnea
		EggSteps = 5355
	Swablu
		EggSteps = 5355
	Zangoose
		EggSteps = 5355
	Seviper
		EggSteps = 5355
	Lunatone
		EggSteps = 6630
	Solrock
		EggSteps = 6630
	Barboach
		EggSteps = 5355
	Corphish
		EggSteps = 5355
	Baltoy
		EggSteps = 5355
	Lileep
		EggSteps = 7905
	Anorith
		EggSteps = 7905
	Feebas
		EggSteps = 5355
	Castform
		EggSteps = 6630
	Kecleon
		EggSteps = 5355
	Shuppet
		EggSteps = 6630
	Duskull
		EggSteps = 6630
	Tropius
		EggSteps = 6630
	Chingling
		EggSteps = 6630
	Absol
		EggSteps = 6630
	Snorunt
		EggSteps = 5355
	Spheal
		EggSteps = 5355
	Clamperl
		EggSteps = 5355
	Luvdisc
		EggSteps = 5355
	Bagon
		EggSteps = 10455
	Beldum
		EggSteps = 10455
	Regirock
		EggSteps = 20655
	Regice
		EggSteps = 20655
	Registeel
		EggSteps = 20655
	Latias
		EggSteps = 30855
	Latios
		EggSteps = 30855
	Kyogre
		EggSteps = 30855
	Groudon
		EggSteps = 30855
	Rayquaza
		EggSteps = 30855
	Jirachi
		EggSteps = 30855