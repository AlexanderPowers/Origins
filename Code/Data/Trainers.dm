mob
	var/tmp/list/TalkingTo = list() //To stop bugs, they have to be added when they start talking to an NPC..

var/TrainerClasses = list("Hiker", "Scientist")
var/TrainerClassClothing = list(\
	"Hiker" = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat"),
	"Scientist" = list("Shoes"= "Black shoes", "Robe"= "Lab Coat", "Hair"="ComboverHairBrown","Accesories"= "Glasses"),

	"")
var/TrainerClassPortraits = list(\
	"Hiker" = 'Hiker2.png',
	"Scientist" = 'Scientist.png',
	"")
var/TrainerNamesMale = list("James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas", "Christopher", "Daniel", "Paul", "Mark", "Donald", "George","Kenneth", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin", "Jason", "Matthew", "Gary", "Timothy", "Larry", "Hose", "Jeffery", "Frank", "Scott", "Eric", "Stephen", "Andrew", "Raymon", "Gregory", "Joshua", "Jerry", "Dennis", "Walter", "Patrick", "Peter", "Harold", "Douglas", "Henry", "Carl", "Arthur", "Ryan", "Roger", "Joe", "Juan", "Jack", "Albert", "Jonathan","Justin", "Terry", "Gerald", "Keith", "Samuel", "Willie", "Ralph", "Lawrence", "Nicholas", "Roy", "Benjamin", "Bruce", "Brandon", "Adam", "Harry", "Fred", "Wayne", "Billy", "Steve", "Louis", "Jeremy", "Aaron","Randy", "Howard", "Eugene", "Carlos", "Russell", "Bobby", "Victor", "Martin", "Ernest", "Phillip", "Todd", "Jesse", "Craig", "Alan", "Shawn", "Clarence", "Sean", "Philip", "Chris", "Johnny", "Earl")
var/TrainerNamesFemale = list("Mary", "Patricia", "Linda", "Barbara", "Elizabeth", "Jennifer", "Maria", "Susan", "Margaret", "Dorothy", "Lisa", "Nancy", "Karen", "Betty", "Helen", "Sandra", "Donna", "Carol", "Ruth", "Sharon", "Michelle", "Laura", "Sarah", "Kim", "Deborah", "Jessica", "Shirley", "Cynthia", "Angela", "Mellisa", "Brenda", "Amy")
var/TrainerClassGender = list(\
	"Hiker" = "Male",
	"Scientist" = "Male",
	"Fisherman" = "Male",
	"Super Nerd" = "Male",
	"Camper" = "Male",
	"Bug Catcher" = "Male",
	"")

var/TrainerClassPokemon = list(\
	"Hiker" = list(/mob/Pokemon/Machop, /mob/Pokemon/Machoke, /mob/Pokemon/Machamp, /mob/Pokemon/Geodude, /mob/Pokemon/Graveler, /mob/Pokemon/Golem, /mob/Pokemon/Diglett, /mob/Pokemon/Dugtrio,/mob/Pokemon/Onix, /mob/Pokemon/Steelix, /mob/Pokemon/Sandshrew, /mob/Pokemon/Sandslash, /mob/Pokemon/Swinub),
	"Scientist" = list(/mob/Pokemon/Magnemite, /mob/Pokemon/Magneton, /mob/Pokemon/Voltorb, /mob/Pokemon/Electrode, /mob/Pokemon/Koffing, /mob/Pokemon/Weezing, /mob/Pokemon/Grimer, /mob/Pokemon/Muk, /mob/Pokemon/Ditto, /mob/Pokemon/Porygon, /mob/Pokemon/Porygon2, /mob/Pokemon/Kadabra, /mob/Pokemon/Alakazam, /mob/Pokemon/Kirlia, /mob/Pokemon/Drowzee, /mob/Pokemon/Hypno, /mob/Pokemon/Ampharos, /mob/Pokemon/Electrike, /mob/Pokemon/Delibird, /mob/Pokemon/Paras, /mob/Pokemon/Parasect),
	"Fisherman" = list(/mob/Pokemon/Goldeen, /mob/Pokemon/Seaking, /mob/Pokemon/Tentacool, /mob/Pokemon/Tentacruel, /mob/Pokemon/Staryu, /mob/Pokemon/Starmie, /mob/Pokemon/Poliwag, /mob/Pokemon/Poliwhirl, /mob/Pokemon/Poliwrath, /mob/Pokemon/Politoed, /mob/Pokemon/Shellder, /mob/Pokemon/Cloyster, /mob/Pokemon/Horsea, /mob/Pokemon/Seadra, /mob/Pokemon/Kingdra, /mob/Pokemon/Gyarados, /mob/Pokemon/Qwilfish, /mob/Pokemon/Remoraid, /mob/Pokemon/Octillery, /mob/Pokemon/Wailmer, /mob/Pokemon/Carvanha, /mob/Pokemon/Barboach),
	"Super Nerd" = list(/mob/Pokemon/Voltorb, /mob/Pokemon/Electrode, /mob/Pokemon/Charmander, /mob/Pokemon/Charmeleon, /mob/Pokemon/Charizard, /mob/Pokemon/Ponyta, /mob/Pokemon/Rapidash, /mob/Pokemon/Vulpix, /mob/Pokemon/Ninetales, /mob/Pokemon/Grimer, /mob/Pokemon/Muk, /mob/Pokemon/Koffing, /mob/Pokemon/Weezing, /mob/Pokemon/Magnemite, /mob/Pokemon/Magneton, /mob/Pokemon/Growlithe, /mob/Pokemon/Arcanine, /mob/Pokemon/Slowpoke, /mob/Pokemon/Slowbro, /mob/Pokemon/Slowking, /mob/Pokemon/Numel, /mob/Pokemon/Torkoal, /mob/Pokemon/Slugma, /mob/Pokemon/Magcargo, /mob/Pokemon/Cubone, , /mob/Pokemon/Marowak, /mob/Pokemon/Meowth, /mob/Pokemon/Persian),
	"Camper" = list(/mob/Pokemon/Diglett, /mob/Pokemon/Dugtrio, /mob/Pokemon/Sandshrew, /mob/Pokemon/Sandslash, /mob/Pokemon/Mankey, /mob/Pokemon/Primeape, /mob/Pokemon/Rattata, /mob/Pokemon/Raticate, /mob/Pokemon/Ekans, /mob/Pokemon/Arbok, /mob/Pokemon/Squirtle, /mob/Pokemon/Charmander, /mob/Pokemon/Bulbasaur, /mob/Pokemon/Spearow, /mob/Pokemon/Fearow, /mob/Pokemon/Growlithe, /mob/Pokemon/NidoranM, /mob/Pokemon/NidoranF, /mob/Pokemon/Nidorino, /mob/Pokemon/Nidorina, /mob/Pokemon/Nidoqueen, /mob/Pokemon/Nidoking, /mob/Pokemon/Zubat, /mob/Pokemon/Golbat, /mob/Pokemon/Crobat, /mob/Pokemon/Psyduck, /mob/Pokemon/Golduck, /mob/Pokemon/Poliwag, /mob/Pokemon/Poliwhirl, /mob/Pokemon/Poliwrath, /mob/Pokemon/Politoed, /mob/Pokemon/Geodude, /mob/Pokemon/Graveler, /mob/Pokemon/Golem, /mob/Pokemon/Tailow, /mob/Pokemon/Swellow, /mob/Pokemon/Zigzagoon, /mob/Pokemon/Linoone, /mob/Pokemon/Nuzleaf, /mob/Pokemon/Shiftry, /mob/Pokemon/Tauros),
	"Bug Catcher" = list(/mob/Pokemon/Butterfree, /mob/Pokemon/Bedrill, /mob/Pokemon/Scizor, /mob/Pokemon/Scyther, /mob/Pokemon/Venonat, /mob/Pokemon/Venomoth, /mob/Pokemon/Ariados, /mob/Pokemon/Paras, /mob/Pokemon/Parasect, /mob/Pokemon/Pinsir, /mob/Pokemon/Ledyba, /mob/Pokemon/Ledian, /mob/Pokemon/Volbeat, /mob/Pokemon/Illumise, /mob/Pokemon/Dustox, /mob/Pokemon/Surskit, /mob/Pokemon/Ninjask, /mob/Pokemon/Nincada, /mob/Pokemon/Yanma, /mob/Pokemon/Heracross, /mob/Pokemon/Beautifly))

proc/GenerateTrainerbyType(var/Type, var/InputLevel)
	if(!Type) Type = pick(TrainerClasses)

	var/mob/NPCTrainer/N = new


	//Clothing
	var/list/L = TrainerClassClothing[Type]
	var/list/TrainerClothes = L.Copy()
//	for(var/i in TrainerClothes)
//		world <<"[i] - [TrainerClothes[i]]"
	N.ClothingOverlays = TrainerClothes
	N.ReAddClothing()
	//Name
	if(TrainerClassGender[Type] == "Male") N.name = "[Type] [pick(TrainerNamesMale)]"
	if(TrainerClassGender[Type] == "Female") N.name = "[Type] [pick(TrainerNamesMale)]"
	N.ckey = "<[rand(1,9999)]>[N.name]"
	//Portrait
	N.Portrait = TrainerClassPortraits[Type]
	//Pokemon
	var/PartySize = pick(4,5,6)
	var/list/PokemonTypes = TrainerClassPokemon[Type]
	for(var/i = 1, i <= PartySize, i++)
		var/PType = pick(PokemonTypes)
		var/mob/Pokemon/P = new PType
		N.Party[i] = P
		P.Create(InputLevel + rand(2,-2))
		P.Owner = N.ckey //This goes after, otherwise AddMove() thinks there is an owner. Waits for a prompt
		P.Ball = new/obj/Balls/Poke_Ball
		var/obj/Balls/B = P.Ball
		B.name = html_encode(P.name)
		B.Pokemon = P
	//Money
	var/EXP
	for(var/mob/Pokemon/p in N.Party)
		for(var/i in p.Stats)
			if(i == "EXP") continue
			EXP += p.Stats[i]

	N.MoneyGiven = (EXP / 1.5)
	return N





mob/NPCTrainer
	icon = 'MaleWhiteBase.dmi'
	//Default clothing is Brandons.
	ClothingOverlays = list("Shoes"= "Red Shoes", "Robe"= "Red Jumpsuit", "Hair"="BrandonHairWhite","Accesories"= "Red Headband")
	var/Tradable = 1 //This value determines if a trainer can trade. AN exampe of trainers that can't Trade are Gymleaders, and Quest NPCTrainers.
	Quest
		Tradable = 0
	Gymleader
		Tradable = 0
	TeamRocket
		Tradable = 0

	var/list/PassedBy = list()
	var/list/ToldofTrades = list()
	var/LookDistance = 1
	var/Rotate
	var/GymleaderTrainer = 0 //This is if they are a Gymleader Trainer. It will be set to the badge of the the gym. If they win, then they are added to the win list.
	var/list/Battlers = list()
	Click() //Speak to the trainer if you are 1 tile away
		var/mob/Player/P = usr
		if(P.TalkingTo[type]) return
		if(get_dist(src, usr) > 1 || !isPlayer(P)) return

		//Get them to battle first before any other options become available

		P.TalkingTo[type] = 1
		if(!P.NPCWins.Find(type))
			Battlers += P
			spawn() Challenge(P,P.Partner)
			P.TalkingTo -= type
			P.frozen = 0
			return //Don't speak to them after the battle (SHAME OF LOSER)
		//Tell them about trading if they don't already know
		if(TradingTrainers.Find(type) && !ToldofTrades.Find(P))
			TellTrade(P)
		InputLabel
		var/INPUT = input(P, "Speak to [src.name]") in list("Challenge", "Talk", "Trade", "See ya!")
		switch(INPUT)
			if("See ya!")
				P.TalkingTo -= type
				return
			if("Challenge")
				if(world.realtime - P.NPCTimes[type] < 36000*2)// && !P.MasterGMCheck()) //2 Hours.
					var/list/T = list("Didn't we battle quite recently?","Go away..I'm busy training.","Great battle last time, but why don't you come back later. I'm done battling for a bit.","My Pokemon have all fainted from training so hard.","Why don't you give your Pokemon a break.", "You should go train your pokemon a bit!")
					P<<Dialog(src,pick(T))
					P<<System("This trainer can be battled again [Date(P.NPCTimes[type] + 72000,1,1,1,1,1)]")
					goto InputLabel
				if(P.Court || P.Watcher) return
				if(TextBeforeAccepted) P<<Dialog("[name]", "[TextBeforeAccepted]")
				Challenge(P)
				P.TalkingTo -= type
				return
			if("Talk")
				P<<"Hey this is me talking... but not really.. its a filler till Alexander finishes this part of the game..."
				goto InputLabel
			if("Trade")
				if(TradingTrainers.Find(type))
					var/list/Co = TradingTrainers[type]
					var/L = Co.Copy()
					P.ScrollText(src, "You want to trade for my [L["PokemonName"]]? Well what do you have to offer?")

					var/mob/Pokemon/TP = usr.Party_Choose("What will you trade for [L["PokemonName"]]?")
					var/PScore = 256 - TP.CaptureRate
					for(var/i in TP.BaseStats) PScore += TP.BaseStats[i]
					PScore += length(TP.LearnMoves) + length(TP.NoMoves)

					if(PScore < L["Score"] - 200) //Not accepted, but majorly a bad trade
						P.ScrollText(src, "Are you kidding me! Thats a completely unfair trade. No deal!")
						goto InputLabel
					else if(PScore < L["Score"] - 50) //Accepted, but just barely
						P.ScrollText(src, "Hmmm, I suppose I could try your [TP.name]. Sure, lets trade.")
					else if(PScore > L["Score"] + 200) //Really good deal for the NPC.
						P.ScrollText(src, "Wow! Really?! Sure, lets trade right away!")
					else if(PScore > L["Score"])
						P.ScrollText(src, "That seems like a fair trade. Alright, lets trade.")


					if(alert("Trade [L["PokemonName"]] for your [TP.name]?","Trade : [src.name]","No","Yes") == "Yes")
						if(TradingTrainers.Find(type))
							TradePokemon(P, TP, L["Pokemon"])
							P.TalkingTo -= type
						else
							P.ScrollText(src, "Actually... I think I am having a change in heart. Deals off, no trade.")
							goto InputLabel
					else
						P.ScrollText(src, "Alright. Let me know if you change your mind.")
						goto InputLabel


				else
					P.ScrollText(src, "Sorry, I am not looking to trade. My teams perfect just the way it is!")
					spawn(1) goto InputLabel




	proc/Rotate(var/D)
		switch(D)
			if(1)
				while(src)
					sleep(10)
					if(dir == 1) dir = 4
					else if(dir == 4) dir = 2
					else if(dir == 2) dir = 8
					else if(dir == 8) dir = 1
			if(2)
				while(src)
					sleep(pick(5,20))
					dir = pick(1,2,4,8)
	proc/TradePokemon(var/mob/Player/P, var/mob/Pokemon/TP, var/NPCPoke)
		//Insert Cutscene Later.

		for(var/j=1, j<7, j++) //Removes the Pokemon from the Party
			if(P.Party[j] == TP)

				var/mob/Pokemon/NP = new NPCPoke
				P.Party[j] = NP
				NP.Owner = P.ckey
				NP.Create(TP.Level)
				NP.OriginalTrainer = name

				NP.Ball = new/obj/Balls/Poke_Ball
				var/obj/Balls/B = NP.Ball
				B.name = html_encode(NP.name)
				B.Pokemon = NP
				P.CaughtPokemon += initial(NP.name)
				P.GiveDexInfo(NP.Number)

				del TP //Get rid of the old Pokemon.
				break

		P<<System("You have succesfully traded with [src]")


		TradingTrainers -= type
		ToldofTrades = list()




	proc/TellTrade(var/mob/Player/P)
		if(MeetSound) P.BackgroundMusic(MeetSound,0)
		overlays += /obj/HUD/OMG
		spawn(20) overlays -= /obj/HUD/OMG
		P.frozen = 1
		P.dir = get_dir(P,src)

		var/list/Co = TradingTrainers[type]
		if(Co)
			var/L = Co.Copy()
			P.ScrollText(src, "Hey! We battled a while ago, right?")
			P.ScrollText(src, "Ya, I remember you! You had some pretty amazing Pokemon.")
			P.ScrollText(src, "You know, I am looking to trade someone for my [L["PokemonName"]]. If you or anyone else you know is up for a trade, just come by and talk to me.")
			if(!P) return 0//in case they logged out during the ScrollText
			ToldofTrades += P
			P.frozen = 0
	proc/HealAll() //This is needed because NPCs needed to be healed after a Tournament Round.
		for(var/i=1, i<7, i++)
			var/mob/Pokemon/P = Party[i]
			if(P)

				P.HP = P.MHP
				P.icon_state= null
				P.icon = P.RICON
				P.Status = null
				P.SecondaryStatus["Confused"] = 0
				P.TemporaryMoves = new/list
				P.TempStats = new/list
				for(var/obj/Moves/M in P.Moves)
					M.PP = M.MPP
					M.WaitTime = 0

	proc/FindTrainers()
		set background = 1
		spawn()
			while(src)
				var/Counter = 1
				if(length(ToldofTrades) && !TradingTrainers.Find(type)) ToldofTrades = list() //Resets who has been told of the trades if they are no longer a trading trainer.
				for(var/mob/Player/P in view(src,LookDistance))
					if(P.invisibility || !P.density) continue
					var/Dist = get_dist(P,src)

					if(Dist <= LookDistance)
						if(P.x == x ||P.y == y)
							if(get_dist(get_step(src,dir),P) < Dist)
								if(P.NPCWins.Find(type))
									if(TradingTrainers.Find(type) && !ToldofTrades.Find(P) && !Tests["No Trade NPC"])
										TellTrade(P)
									if(TextPassByAfterWin && !PassedBy.Find(P))
										P<<Dialog("[name]", "[TextPassByAfterWin]")
										PassedBy += P


									continue
								else
									if(!P.Court && !Battlers.Find(P))
										if(GymleaderTrainer && P.Badges[GymleaderTrainer]) continue
										Battlers += P
										if(TestBattling) world << "Challenge proc used through FindTrainer()"
										spawn() Challenge(P,P.Partner)
				if(Rotate && Counter >= 3)
					if(prob(25)) dir = pick(1,2,4,8)
					Counter = 0
				sleep(1)


	New()
		..()
		if(Pointer) overlays += image('HUD.dmi',"Pointer")
		mouse_over_pointer = image('Pointer.dmi',"Speak")
		spawn() if(Rotate) Rotate(Rotate)
		if(LookDistance) FindTrainers()

/*
	"level"
	"icon"
	"moves" = list(/obj/Moves)
	"set type" //This is if the Pokemon is not meant to evolve, or if you want multiple pokemon of the same type in a battle.
	"type"

	Gymleaders levels are between 15 and 19
	Trainers levels are between
*/
//Gymleaders//---------------------------------------------------------------------------------------------------------------------------------------------
	Gymleader

		Chall()

			Click()

//------//Wayne//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Gymleader_Wayne
			name = "Gymleader Wayne"
			Pokes = list(\
				list("type" = /mob/Pokemon/Goldeen,  "level" = 15, "moves" = list(/obj/Moves/Hydro_Pump,/obj/Moves/Bubble,/obj/Moves/Peck,/obj/Moves/Psybeam ,/obj/Moves/Supersonic,/obj/Moves/Agility)),
				list("type" = /mob/Pokemon/Horsea,   "level" = 15, "moves" = list(/obj/Moves/Water_Gun,/obj/Moves/Rain_Dance,/obj/Moves/Hydro_Pump,/obj/Moves/Bubble,/obj/Moves/Growl)),
				list("type" = /mob/Pokemon/Chinchou, "level" = 17, "moves" = list(/obj/Moves/Hydro_Pump,/obj/Moves/Bubble,/obj/Moves/Thunder,/obj/Moves/Rain_Dance ,/obj/Moves/Supersonic,/obj/Moves/Hydro_Pump)),
				list("type" = /mob/Pokemon/Vaporeon, "level" = 15, "icon" = 'S134Vaporeon.dmi', "moves" = list(/obj/Moves/Hydro_Pump,/obj/Moves/Water_Gun,/obj/Moves/Quick_Attack,/obj/Moves/Bite,/obj/Moves/Acid_Armor,/obj/Moves/Agility)),
				list("type" = /mob/Pokemon/Quagsire, "level" = 19, "moves" = list(/obj/Moves/Water_Gun,/obj/Moves/Rain_Dance,/obj/Moves/Hydro_Pump,/obj/Moves/Bubble,/obj/Moves/Growl,/obj/Moves/Ancient_Power)),
				list("type" = /mob/Pokemon/Gyarados, "level" = 20, "moves" = list(/obj/Moves/Water_Gun,/obj/Moves/Rain_Dance,/obj/Moves/Hydro_Pump,/obj/Moves/Bubble,/obj/Moves/Growl,/obj/Moves/Aerial_Ace)))

			ClothingOverlays = list()
			LookDistance = 0
			icon_state = "Fishing Guru"
			icon = 'NPC.dmi'
			MoneyGiven = 212
			Portrait = 'Fisherman2.png'
			Click()
				if(get_dist(usr,src) >= 2) return
				var/mob/Player/P = usr
				if(!isPlayer(P)) return
				if(PassedBy.Find(usr)) return
				PassedBy += usr
				if(P.Badges["Whirlpool"]) return//They've already battled

				else //They haven't battled, check for Rods.
					var/Rod = "None"
					for(var/obj/Important_Items/Rods/R in usr.contents)
						if(istype(R,/obj/Important_Items/Rods/Old_Rod) && Rod == "None") Rod = "Old Rod"
						if(istype(R,/obj/Important_Items/Rods/Good_Rod) || istype(R,/obj/Important_Items/Rods/Super_Rod)) Rod = "Good Rod"
					switch(Rod)
						if("None")
							if(usr) usr.ScrollText(src, "Whats this? A Pokemon trainer without a Fishing Rod?! This is impossible, leave my sights at once. If you dare wish to challenge me, the great fishing legend Wayne, go talk to my friend the fishing Guru to recieve a rod.")
							if(usr) usr.ScrollText(src, "I do not battle anyone who is not an acceptable fisherman by his standards!")
							P.QuestAdd(/obj/Quest/Fishermans)
							P.QuestCheck("Talk to Wayne")

						if("Old Rod")
							if(usr) usr.ScrollText(src, "Eh...")
							if(usr) usr.ScrollText(src, "Only am Old Rod? I mean, thats a good fishing rod to start off with but it's basically for begginers. The only thing I have ever caught with one of those was a Magikarp. Come back when you get a Good Rod.")

						if("Good Rod")
							if(usr) usr.ScrollText(src, "Wow...")
							if(usr) usr.ScrollText(src, "That fishing rod you have there is quite impressive, do you go out fishing much?")
							if(usr) usr.ScrollText(src, "My name is Wayne and I am the gymleader of the Bloomsberry Lake Gym. I moved here to be able to fish whenever I wanted, and naturally I became quite good at battling with Water-Type Pokemon aswell.")
							if(usr) usr.ScrollText(src, "Do you think you can beat my fished up Pokemon Party?")
							if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Battle.mid')
							if(P.Partner)
								if(!ispath(P.Partner)) P.Partner.Partner = null
								P.Partner = null
							var/list/Q = Challenge(P)
							if(Q.Find(P)) //They won.
								P.Titles += "Whirlpool Badge"
								usr<<System("You beat Wayne. You have been awarded the Whirlpool Badge Title.")
								if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
								if(usr) usr.ScrollText(src, "Wow. My fishing skills are superb, but it looks like I still need a bit of practice when it comes to battling.")
								if(usr) usr.ScrollText(src, "Here, take this, the Whirlpool Badge. It signifys in the Joleon Pokemon League that you are one step closer to becoming a Pokemon Master.")
								if(usr)
									P.Badges["Whirlpool"] += 1
									//Badge Accuiring Sound?
								if(usr) usr.ScrollText(src, "Also, take this.")
								if(usr)
									usr.contents += new /obj/Machine/TM/TM_Water_Pulse
									usr<<System("You recieved TM Water Pulse!")
								if(usr) usr.ScrollText(src, "That there is Water Pulse, a devestating Water-Type attack! It works well in a tight situation.")

							usr.BackgroundMusic()
							P.QuestCheck("Win Badge")
				PassedBy -= usr




		Gymleader_Julie
			icon = 'NPC.dmi'
			icon_state = "Julie"
			ClothingOverlays = null
			Pokes = list(\
			list("set type" = /mob/Pokemon/Pichu, "level" = 16, "moves" = list(/obj/Moves/Thundershock,/obj/Moves/Growl,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Wave,/obj/Moves/Agility,/obj/Moves/Tail_Whip)),
			list("set type" = /mob/Pokemon/Pikachu, "level" = 17, "moves" = list(/obj/Moves/Thundershock,/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Wave,/obj/Moves/Growl,/obj/Moves/Quick_Attack)),
			list("set type" = /mob/Pokemon/Elekid, "level" = 15, "moves" = list(/obj/Moves/Thundershock,/obj/Moves/Low_Kick,/obj/Moves/Thunder,/obj/Moves/Thunder_Wave,/obj/Moves/Water_Gun,/obj/Moves/Growl)),
			list("set type" = /mob/Pokemon/Mareep, "level" = 16, "moves" = list(/obj/Moves/Thundershock,/obj/Moves/Spore,/obj/Moves/Thunder,/obj/Moves/Thunder_Wave,/obj/Moves/Water_Gun,/obj/Moves/Tackle))
			)

//------//Omar//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Gymleader_Omar
			name = "Gymleader Omar"
			icon = 'NPC.dmi'
			icon_state = "Omar"
			ClothingOverlays = null
			Pokes = list(\
				list("type" = /mob/Pokemon/Electabuzz, "level" = 17, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Jolteon, "level" = 17, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Rest,/obj/Moves/Pin_Missle ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Magneton, "level" = 18, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Sonicboom,/obj/Moves/Thunder_Wave ,/obj/Moves/Supersonic,/obj/Moves/Thundershock)),
				list("type" = /mob/Pokemon/Electrode, "level" = 16, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Sonicboom,/obj/Moves/Thunder_Wave ,/obj/Moves/Supersonic,/obj/Moves/Thundershock,/obj/Moves/Rollout)),
				list("type" = /mob/Pokemon/Raichu, "level" = 16, "moves" = list(/obj/Moves/Return,/obj/Moves/Thunderbolt,/obj/Moves/Thunder,/obj/Moves/Thunder_Wave ,/obj/Moves/Thunder_Punch,/obj/Moves/Thundershock)),
				list("type" = /mob/Pokemon/Ampharos, "level" = 20, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)))

		Gymleader_Corey
			name = "Gymleader Corey"
			icon = 'MaleWhiteBase.dmi'
			ClothingOverlays = null
			Pokes = list(\
				list("type" = /mob/Pokemon/Kabutops, "level" = 17, "moves" = list(/obj/Moves/Slash,/obj/Moves/Absorb,/obj/Moves/Leer ,/obj/Moves/Ancient_Power,/obj/Moves/Water_Pulse,/obj/Moves/Bubblebeam)),
				list("type" = /mob/Pokemon/Omastar, "level" = 17, "moves" = list(/obj/Moves/Bite,/obj/Moves/Water_Gun,/obj/Moves/Leer,/obj/Moves/Protect ,/obj/Moves/Ancient_Power,/obj/Moves/Water_Pulse)),
				list("type" = /mob/Pokemon/Dugtrio, "level" = 18, "moves" = list(/obj/Moves/Tri_Attack,/obj/Moves/Scratch,/obj/Moves/Fury_Swipes ,/obj/Moves/Growl,/obj/Moves/Earthquake,/obj/Moves/Slash)),
				list("type" = /mob/Pokemon/Tyranitar, "level" = 18, "moves" = list(/obj/Moves/Bite,/obj/Moves/Earthquake,/obj/Moves/Crunch ,/obj/Moves/Thunder,/obj/Moves/Dragon_Dance,/obj/Moves/Thrash)),
				list("type" = /mob/Pokemon/Flygon, "level" = 19, "moves" = list(/obj/Moves/Bite,/obj/Moves/Quick_Attack,/obj/Moves/Crunch,/obj/Moves/Dragon_Claw ,/obj/Moves/Fire_Blast,/obj/Moves/Gust)),
				list("type" = /mob/Pokemon/Claydol, "level" = 20, "moves" = list(/obj/Moves/Confusion,/obj/Moves/Harden,/obj/Moves/Psybeam,/obj/Moves/Ancient_Power ,/obj/Moves/Ice_Beam,/obj/Moves/Shadow_Ball)))

		Gymleader_Felix
//------//Mary-Anna//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Gymleader_Mary_Anna
			name = "Gymleader Mary-Anna"
			Pokes = list(\
			list("type" = /mob/Pokemon/Paras, "level" = 16, "moves" = list(/obj/Moves/Spore,/obj/Moves/Slash,/obj/Moves/Leech_Life,/obj/Moves/Growth,/obj/Moves/PoisonPowder,/obj/Moves/Giga_Drain)),
			list("set type" = /mob/Pokemon/Exeggutor, "level" = 19, "moves" = list(/obj/Moves/Confusion,/obj/Moves/Hypnosis,/obj/Moves/Egg_Bomb,/obj/Moves/Razor_Leaf,/obj/Moves/Leech_Seed,/obj/Moves/SleepPowder)),
			list("type" = /mob/Pokemon/Chikorita, "level" = 15, "moves" = list(/obj/Moves/SolarBeam,/obj/Moves/Razor_Leaf,/obj/Moves/Vine_Whip,/obj/Moves/Synthesis,/obj/Moves/PoisonPowder,/obj/Moves/Growl)),
			list("type" = /mob/Pokemon/Victreebel, "level" = 17, "moves" = list(/obj/Moves/Vine_Whip,/obj/Moves/Growth,/obj/Moves/PoisonPowder,/obj/Moves/Acid,/obj/Moves/Razor_Leaf,/obj/Moves/Wrap)),
			list("type" = /mob/Pokemon/Vileplume, "level" = 17, "moves" = list(/obj/Moves/SolarBeam,/obj/Moves/Giga_Drain,/obj/Moves/PoisonPowder,/obj/Moves/Synthesis,/obj/Moves/Petal_Dance,/obj/Moves/SleepPowder)),
			list("type" = /mob/Pokemon/Sunkern, "level" = 16, "moves" = list(/obj/Moves/SolarBeam,/obj/Moves/Absorb,/obj/Moves/Growth,/obj/Moves/Mega_Drain,/obj/Moves/Pound,/obj/Moves/Razor_Leaf)))
			ClothingOverlays = list("Robe"= "Picnic Outfit", "Hair"="PonytailHairBrown")

			LookDistance = 0
			MoneyGiven = 212
			var/list/TalkedTo = list()
			Portrait = 'Lass2.png'
			New()
				..()
				FindTrainers()
			Click()
				var/mob/Player/P = usr
				if(get_dist(usr,src) >= 2) return
				if(!isPlayer(usr)) return
				if(P.Badges["Herb"]) return//They've already battled
				if(PassedBy.Find(usr)) return
				PassedBy += usr
				if(usr) usr.ScrollText(src, "Well hello there, nice to see you again.")
				if(usr) usr.ScrollText(src, "My name is Mary-Anna and I pride myself in what I can grow in my gardens, so naturally I took upon Grass-Type Pokemon.")
				if(usr) usr.ScrollText(src, "Grass type Pokemon are just so happy and relaxed all the time, and thats how I love to feel. So I surround myself with them")
				if(usr) usr.ScrollText(src, "But enough about Grass Pokemon, lets battle!")
				if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Battle.mid')
				if(P.Partner)
					if(!ispath(P.Partner)) P.Partner.Partner = null
					P.Partner = null
				var/list/Q = Challenge(P)
				if(Q.Find(P)) //They won.
					P.Titles += "Herb Badge"
					usr<<System("You beat Mary-Anna. You have been awarded the Herb Badge Title.")
					if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
					if(usr) usr.ScrollText(src, "What a delightful battle! It was such a thrill to be able to be able to coordinate my Pokemon in such a way, thank you for the opportunity.")
					if(usr) usr.ScrollText(src, "As a gift for such an amazing battle, and as a symbol of your victory today, take this, the Herb Badge.")
					if(usr)
						P.Badges["Herb"] += 1
						//Badge Accuiring Sound?
					if(usr) usr.ScrollText(src, "Also, take this.")
					if(usr)
						usr.contents += new /obj/Machine/TM/TM_Petal_Dance
						usr<<System("You recieved TM Petal Dance!")
					if(usr) usr.ScrollText(src, "Petal Dance is normally a move I use to relax. The pedals revolving and moving is very soothing. However, it can be used in battle and can do some serious damage..")

				usr.BackgroundMusic()
				P.QuestCheck("Win Badge")
				PassedBy -= usr

			FindTrainers()
				set background = 1
				spawn()
					while(src)
						sleep(3)
						for(var/mob/Player/P in view(src,6))
							if(P.invisibility || !P.density) continue
							if(P.y == y & P.x > x) //The Trainer has to be to MaryAnnas right exactly.
								if(get_dist(src,P) < 3)
									if(!TalkedTo.Find(P) && !P.Badges["Herb"])
										dir = 4
										if(P) P.ScrollText(src, "Hello down there! What are you doing in my gym?")
										if(P) P.ScrollText(src, "Oh you want to battle me? Ha, silly me, I should have guessed!")
										if(P) P.ScrollText(src, "Well come on around, I would love to have a battle today.")
										if(P) TalkedTo += P

		Gymleader_Jackie
			icon = 'MaleWhiteBase.dmi'
			ClothingOverlays = list("Robe" = null, "Hair" = null,"Accesories" = null,"Shoes" = null)
			Pokes = list(\
				list("type" = /mob/Pokemon/Hitmonchan, "level" = 19, "moves" = list(/obj/Moves/Fire_Punch,/obj/Moves/Thunder_Punch,/obj/Moves/Ice_Punch ,/obj/Moves/Agility,/obj/Moves/Mach_Punch,/obj/Moves/Sky_Uppercut)),
				list("type" = /mob/Pokemon/Hitmonlee, "level" = 19, "moves" = list(/obj/Moves/Rolling_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Tackle ,/obj/Moves/Agility,/obj/Moves/Double_Kick,/obj/Moves/Swift)),
				list("type" = /mob/Pokemon/Hitmontop, "level" = 19, "moves" = list(/obj/Moves/Rolling_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Quick_Attack ,/obj/Moves/Agility,/obj/Moves/Tackle,/obj/Moves/Rapid_Spin)),
				list("type" = /mob/Pokemon/Medicham, "level" = 16, "moves" = list(/obj/Moves/Fire_Punch,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch ,/obj/Moves/Confusion,/obj/Moves/Meditate,/obj/Moves/Calm_Mind)),
				list("type" = /mob/Pokemon/Breloom, "level" = 18, "moves" = list(/obj/Moves/Absorb,/obj/Moves/Leech_Seed,/obj/Moves/Spore ,/obj/Moves/Headbutt,/obj/Moves/Mach_Punch,/obj/Moves/SolarBeam)),
				list("type" = /mob/Pokemon/Machamp, "level" = 20, "moves" = list(/obj/Moves/Low_Kick,/obj/Moves/Leer,/obj/Moves/Cross_Chop,/obj/Moves/Scary_Face ,/obj/Moves/Rolling_Kick,/obj/Moves/Fire_Blast)))

			LookDistance = 0
			MoneyGiven = 212
			var/list/TalkedTo = list()
			Portrait = 'BlackBelt.png'
			New()
				..()
				FindTrainers()
			Click()
				var/mob/Player/P = usr
				if(get_dist(usr,src) >= 2) return
				if(!isPlayer(usr)) return
				if(P.Badges["Combat"]) return//They've already battled
				if(PassedBy.Find(usr)) return
				PassedBy += usr
				if(usr) usr.ScrollText(src, "Hello there. Im surprised you found this village.")
				if(usr) usr.ScrollText(src, "My name is Jackie, and I am the master of The Valley of the Hidden Ninja.")
				if(usr) usr.ScrollText(src, "Nothing can compete physically with the power of fighting type Pokemon.")
				if(usr) usr.ScrollText(src, "Lets see if you can defeat me!!")
				if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Battle.mid')
				if(P.Partner)
					if(!ispath(P.Partner)) P.Partner.Partner = null
					P.Partner = null
				var/list/Q = Challenge(P)
				if(Q.Find(P)) //They won.
					P.Titles += "Combat Badge"
					usr<<System("You beat Jackie. You have been awarded the Combat Badge Title.")
					if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
					if(usr) usr.ScrollText(src, "What a delightful battle! It was such a thrill to be able to be able to coordinate my Pokemon in such a way, thank you for the opportunity.")
					if(usr) usr.ScrollText(src, "As a gift for such an amazing battle, and as a symbol of your victory today, take this, the Herb Badge.")
					if(usr)
						P.Badges["Combat"] += 1
						//Badge Accuiring Sound?
					/*if(usr) usr.ScrollText(src, "Also, take this.")
					if(usr)
						usr.contents += new /obj/Machine/TM/Petal_Dance
						usr<<System("You recieved TM Petal Dance!")
					if(usr) usr.ScrollText(src, "Petal Dance is normally a move I use to relax. The pedals revolving and moving is very soothing. However, it can be used in battle and can do some serious damage..")
*/
				usr.BackgroundMusic()
				P.QuestCheck("Win Badge")
				PassedBy -= usr
		Gymleader_Arial
			Pokes = list(\
				list("type" = /mob/Pokemon/Dodrio, "level" = 17, "moves" = list(/obj/Moves/Aerial_Ace,/obj/Moves/Peck,/obj/Moves/Quick_Attack ,/obj/Moves/Agility,/obj/Moves/Supersonic,/obj/Moves/Swift)),
				list("type" = /mob/Pokemon/Pidgeotto, "level" = 21, "moves" = list(/obj/Moves/Aerial_Ace,/obj/Moves/Peck,/obj/Moves/Quick_Attack ,/obj/Moves/Agility,/obj/Moves/Wing_Attack,/obj/Moves/Swift)),
				list("type" = /mob/Pokemon/Fearow, "level" = 17, "moves" = list(/obj/Moves/Aerial_Ace,/obj/Moves/Peck,/obj/Moves/Quick_Attack ,/obj/Moves/Agility,/obj/Moves/Mirror_Move,/obj/Moves/Drill_Peck)),
				list("type" = /mob/Pokemon/Gligar, "level" = 16, "moves" = list(/obj/Moves/Poison_Sting,/obj/Moves/Harden,/obj/Moves/Quick_Attack ,/obj/Moves/Guillotine,/obj/Moves/Slash,/obj/Moves/Wing_Attack)),
				list("type" = /mob/Pokemon/Murkrow, "level" = 18, "moves" = list(/obj/Moves/Wing_Attack,/obj/Moves/Peck,/obj/Moves/Quick_Attack ,/obj/Moves/Night_Shade,/obj/Moves/Mean_Look,/obj/Moves/Faint_Attack)),
				list("type" = /mob/Pokemon/Aerodactyl, "level" = 19, "moves" = list(/obj/Moves/Wing_Attack,/obj/Moves/Agility,/obj/Moves/Bite,/obj/Moves/Ancient_Power ,/obj/Moves/Supersonic,/obj/Moves/Flamethrower)))


//Gymleader Trainers//-------------------------------------------------------------------------------------------------------------------------------
	Gymleader_Trainer
		Skysight
			Birdkeeper_Benny
				Pokes = list(/mob/Pokemon/Pidgey = 16,/mob/Pokemon/Pidgeotto = 16,/mob/Pokemon/Pidgeot = 16)
				ClothingOverlays = list("Robe" = "CommonOutfit1Blue", "Hair"="OakHairBrown", "Accesories" = "Black Headband")
				TextBeforeBattle = "Up, Up, and away!"
				TextAfterLoose = "You flew way to high.. I cannot keep up!"
				TextAfterWin = "Guess you couldn't keep up."
				LookDistance = 1
				Portrait = 'Birdkeeper1.png'
			Birdkeeper_Beck
				Pokes = list(/mob/Pokemon/Doduo = 14,/mob/Pokemon/Doduo = 15,/mob/Pokemon/Doduo = 16,/mob/Pokemon/Dodrio = 16)
				ClothingOverlays = list("Robe" = "CommonOutfit1Red", "Hair"="BirchHairBlack")
				TextBeforeBattle = "You dont need Pokemon that can fly to be a Bird Pokemon Expert!"
				TextAfterLoose = "Flying would give us the advantage.."
				TextAfterWin = "Speed is how we won."
				LookDistance = 1
				Portrait = 'Birdkeeper1.png'
			Birdkeeper_Bryon
				Pokes = list(/mob/Pokemon/Skarmory = 18, /mob/Pokemon/Skarmory = 17)
				ClothingOverlays = list("Robe" = "CommonOutfit1Blue", "Hair"="MayHairBlonde", "Accesories" = "Blue Headband")
				TextBeforeBattle = "I'm into heavy metal, or should I say... Steel."
				TextAfterLoose = "To heavy to fly?.."
				TextAfterWin = "Solid Defense, all the way."
				LookDistance = 1
				Tradable = 0
				Portrait = 'Birdkeeper1.png'
			Birdkeeper_Chester
				Pokes = list(/mob/Pokemon/Skarmory = 15, /mob/Pokemon/Murkrow = 17, /mob/Pokemon/Scyther = 17)
				ClothingOverlays = list("Robe" = "CommonOutfit1Red", "Hair"="FlatHairBrown")
				TextBeforeBattle = "My Pokemon are much different than your average birdkeeper..."
				TextAfterLoose = "Variety has nothing to do with winning."
				TextAfterWin = "Spice up your party, and maybe you'll win sometime."
				LookDistance = 1
				Tradable = 0
				Portrait = 'Birdkeeper1.png'
			Birdkeeper_Colin
				Pokes = list(/mob/Pokemon/Pidgey = 16,/mob/Pokemon/Pidgeotto = 16,/mob/Pokemon/Pidgeot = 16)
				ClothingOverlays = list("Robe" = "CommonOutfit1Blue", "Hair"="OakHairBrown", "Accesories" = "Black Headband")
				TextBeforeAccepted = "Up, Up, and away!"
				TextBeforeBattle = "Lets do this."
				TextAfterLoose = "You flew way to high.. I cannot keep up!"
				TextAfterWin = "Guess you couldn't keep up."
				LookDistance = 4
				Portrait = 'Birdkeeper1.png'


		Net_City
			Rocker_Prince
				Pokes = list(/mob/Pokemon/Magnemite = 16)
				ClothingOverlays = list( "Shoes" = "Black Shoes", "Robe" = "Jeans", "Hair"="ElectricHairBlack","Accesories"= "guitar")
				TextBeforeAccepted = "Julie keeps this place going like its a party!"
				TextBeforeBattle = "Lets rock out! I will show you why your not good enough for Julie"
				TextAfterLoose = "I guess I didnt rock hard enough."
				TextAfterWin = "Wow you wont even meet Omar."
				LookDistance = 4
				Portrait = 'Guitarist.png'
			Rocker_Derek
				Pokes = list(/mob/Pokemon/Voltorb = 15, /mob/Pokemon/Pikachu = 15)
				ClothingOverlays = list( "Shoes" = "Black Shoes", "Robe" = "Jeans", "Hair"="ElectricHairBlonde","Accesories"= "guitar")
				TextBeforeAccepted = "Yea I love music!"
				TextBeforeBattle = "Omar lets Julie do whatever shes wants in this gym!"
				TextAfterLoose = "Man I need to string my guitar."
				TextAfterWin = "Maybe I could have Julies spot one day."
				LookDistance = 4
				Portrait = 'Guitarist.png'
			Rocker_Bradley
				Pokes = list(/mob/Pokemon/Mareep = 13, /mob/Pokemon/Flaaffy = 15)
				ClothingOverlays = list( "Shoes" = "Black Shoes", "Robe" = "Jeans", "Hair"="ElectricHairGrey","Accesories"= "guitar")
				TextBeforeAccepted = "Rock n Roll!"
				TextBeforeBattle = "I know something you do not know! Oh, excuse my singing"
				TextAfterLoose = "I guess I didnt rock hard enough."
				TextAfterWin = "Maybe next time."
				LookDistance = 4
				Portrait = 'Guitarist.png'
			Gentleman_McDonald
				Pokes = list(/mob/Pokemon/Elekid = 14, /mob/Pokemon/Jolteon = 16)
				ClothingOverlays = list( "Shoes" = "Gentleman Stash", "Robe" = "Gentleman Suit", "Hair"="ComboverHairBlack","Accesories"= "Gentleman Hat")
				TextBeforeAccepted = "The Gentlemans way is the best way!"
				TextBeforeBattle = "I cant believe that, he allows that little girl to be the... nevermind lets battle!"
				TextAfterLoose = "Maybe next time I will put forth effort."
				TextAfterWin = "I congratulate you for trying."
				LookDistance = 4
				Tradable = 0
				Portrait = 'Gentleman2.png'
		Elkvale
			GymleaderTrainer = "Herb"
			Camper_Elton
				Pokes = list(/mob/Pokemon/Bellsprout = 12,/mob/Pokemon/Oddish = 12,/mob/Pokemon/Gloom = 12,/mob/Pokemon/Weepinbell = 12)
				ClothingOverlays = list("Robe"= "Camper", "Hair"="FlatHairBlack","Accesories"= "Camper Hat")
				TextBeforeAccepted = "You think you can beat Mary-Anna?"
				TextBeforeBattle = "Lets see if you can beat me!"
				TextAfterLoose = "One thing is for sure, I am in no league to be a Gymleader"
				TextAfterWin = "Wow! Perhaps I could be a Gymleader!"
				MoneyGiven = 200
				LookDistance = 3
				Portrait = 'MaleCamper1.png'
			Camper_Windelle
				Pokes = list(/mob/Pokemon/Tangela = 19)
				ClothingOverlays = list("Robe"= "Camper", "Hair"="FlatHairBrown","Accesories"= "Camper Hat")
				TextBeforeAccepted = "Mary-Anna is so awesome, she makes me feel so relaxed when I am around her."
				TextBeforeBattle = "You are not good enough for Mary-Anna!"
				TextAfterLoose = "Wow, I guess I am a little obsessed. Perhaps you are good enough for her."
				TextAfterWin = "SEE! SEE! YOU WILL NEVER BE GOOD ENOUGH FOR MARY-ANNA"
				MoneyGiven = 200
				LookDistance = 1
				dir = 8
				Portrait = 'MaleCamper1.png'
			Picnicker_Abbigale
				Pokes = list(list("set type" = /mob/Pokemon/Bellossom, "level" = 15),list("set type" = /mob/Pokemon/Bellossom, "level" = 16),list("set type" = /mob/Pokemon/Bellossom, "level" = 17),list("set type" = /mob/Pokemon/Vileplume, "level" = 17))
				MeetSound = 'Female Trainer Encounter.mid'
				ClothingOverlays = list("Robe"= "Picnic Outfit", "Hair"="LongHairBrown","Accesories"= "Picnicker Hat")
				TextBeforeAccepted = "I'm sort of jealous about Mary-Anna.."
				TextBeforeBattle = "Mary-Anna has all the boys obbsessed with her here. Are you in love with her too?"
				TextAfterLoose = "I guess your more focused on battling than you are on girls."
				TextAfterWin = "Ha, was it Mary-Anna distracting you or was it me?"
				MoneyGiven = 200
				LookDistance = 1
				dir = 4
				Portrait = 'Picnicker1.png'

//Route 202//-------------------------------------------------------------------------------------------------------------------------------------
	Route_202
		New_Trainer_Ricky
			Pokes = list(/mob/Pokemon/Bulbasaur = 16)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Green Jumpsuit", "Hair"="BirchHairBrown","Accesories"= "Green Headband")
			TextBeforeAccepted = "I can't catch any Pokemon!"
			TextBeforeBattle = "Why are these stupid Pokéballs not working! Gah! Lets battle.."
			TextAfterLoose = "Maybe I should have listened to those assistants?.."
			TextAfterWin = "Yes! At least I am good at battling."
			TextPassByAfterWin = "*mumbles* ..I didn't know you had to click where you wanted to throw your Pokéball..*mumbles*."
			MoneyGiven = 212
			LookDistance = 4
			Tradable = 0
			Portrait = 'Brendan1.png'
		New_Trainer_Elizabeth
			ClothingOverlays = list("Shoes"= "Blue Shoes", "Robe"= "Female Blue Jumpsuit", "Hair"="MayHairBlonde","Accesories"= "Blue Bandana")
			Pokes = list(/mob/Pokemon/Squirtle = 8,/mob/Pokemon/Pidgey = 4,/mob/Pokemon/Rattata = 5)
			TextBeforeAccepted = "Oh I just love my Squirtle!"
			TextBeforeBattle = "Oh, you want to battle me? Okay, sure."
			TextAfterLoose = "Great Battle!"
			TextAfterWin = "Great Battle! Come see me again."
			TextPassByAfterWin = "There's so many different kinds of Pokemon to catch! Good thing there is so much space in the PC."
			MoneyGiven = 245
			LookDistance = 3
			Tradable = 0
			Portrait = 'May1.png'
		New_Trainer_Ian
			ClothingOverlays = list("Shoes"= "Red Shoes", "Robe"= "Red Jumpsuit", "Hair"="LongHairBlack","Accesories"= "Glasses")
			Pokes = list(/mob/Pokemon/Charmander = 10,/mob/Pokemon/Spearow = 8,/mob/Pokemon/Paras = 9)
			TextBeforeAccepted = "Interesting.. Did you know if Charmanders flame goes out, it dies? It says so right here in my Pokedex.!"
			TextBeforeBattle = "A battle would be a great way for me to analyze your Pokemons movesets."
			TextAfterLoose = "Hm, I guess I was not paying close enough attention."
			TextAfterWin = "I think you're the one who needs to look at your Pokemon's moveset. Back to the Books!"
			MoneyGiven = 289
			LookDistance = 5
			Tradable = 0
			Portrait = 'Brendan1.png'
		Bugcatcher_Egor
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Blue", "Hair"="ComboverHairBlack","Accesories"= "Straw Hat Blue")
			Pokes = list(/mob/Pokemon/Weedle = 8,/mob/Pokemon/Weedle = 8,/mob/Pokemon/Caterpie = 9,/mob/Pokemon/Kakuna = 9,/mob/Pokemon/Bedrill = 8)
			TextBeforeAccepted = "Bugs are so interesting."
			TextBeforeBattle = "Would you like to see my collection?."
			TextAfterLoose = "Squashed."
			TextAfterWin = "My Bugs are superior!"
			MoneyGiven = 289
			LookDistance = 5
			Portrait = 'Bugcatcher1.png'
		Hiker_Jimmy
			ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
			Pokes = list(/mob/Pokemon/Onix = 14)
			TextBeforeAccepted = "Yea, nothing better than a good ole hike up the mountains."
			TextBeforeBattle = "Hiking is great excersise."
			TextAfterLoose = "Rock n Roll."
			TextAfterWin = "You should hike then maybe you would be able to beat me!"
			LookDistance = 5
			Tradable = 0
			Portrait = 'Hiker1.png'
//Route 203//-------------------------------------------------------------------------------------------------------------------------------------
	Bloomsberry_Lake_Route_203
		Fisherman_Harry
			Pokes = list(/mob/Pokemon/Magikarp = 10, /mob/Pokemon/Poliwag = 12,/mob/Pokemon/Poliwhirl = 12,)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Fisherman Outfit", "Hair"="BirchHairBlack","Accesories"= "Fisherman Cap")
			TextBeforeAccepted = "Oh wow! I think I have a big one!"
			TextBeforeBattle = "How is it possible that I am catching so many Magikarp.."
			TextAfterLoose = "Maybe I should upgrade to a Good Rod."
			TextAfterWin = "Yes! My haul of fish can beat ANYONE!"
			TextPassByAfterWin = "Hmmm, so the better the rod you have, ranging from Old Rod, to Good Rod, to Super Rod, the better the Pokemon you can find. Interesting."
			MoneyGiven = 253
			LookDistance = 4
			Portrait = 'Fisherman2.png'
		Bugcatcher_Ronald
			Pokes = list(/mob/Pokemon/Butterfree = 13,/mob/Pokemon/Venonat =13,/mob/Pokemon/Venomoth = 13, /mob/Pokemon/Bedrill = 13)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Red", ,"Accesories"= "Straw Hat Red")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are not that many BUG Pokemon near the lake."
			TextAfterLoose = "I'll stick to collecting."
			TextAfterWin = "My mighty bugs have WON!"
			MoneyGiven = 300
			LookDistance = 4
			Portrait = 'Bugcatcher1.png'

//Route 303//------------------------------------------------------------------------------------------------------------
	Route_303
		Cooltrainer_Micheal
			Pokes = list(/mob/Pokemon/Charmeleon = 14, /mob/Pokemon/Growlithe = 14, /mob/Pokemon/Flareon =14)
			ClothingOverlays = list("Shoes"= "Red Shoes", "Robe"= "Red Jumpsuit", "Hair"="BirchHairBlonde","Accesories"= "Red Headband")
			TextBeforeAccepted = "Me and my Pokemon are so hot, we are Burning!"
			TextBeforeBattle = "I will show you how hot we are."
			TextAfterLoose = "Eh, loosing is not hot!"
			TextAfterWin = "See?! Winning is Hot."
			LookDistance = 6
			Tradable = 0
			Portrait = 'CooltrainerMale1.png'
		PKMNBreeder_Jamela
			Pokes = list(/mob/Pokemon/Butterfree = 8, /mob/Pokemon/Jigglypuff = 8, /mob/Pokemon/Pidgey = 8, /mob/Pokemon/Spearow = 8, /mob/Pokemon/Sentret = 8, /mob/Pokemon/Hoothoot = 8)
			ClothingOverlays = list("Shoes"= "Green Shoes", "Robe"= "Green Civilian Clothes", "Hair"="BigHairBrown","Hood" = "Apron","Accesories"= "Green headscarf")
			TextBeforeAccepted = "I caught all these pokemon by myself!"
			TextBeforeBattle = "A Battle? Ok, I will show you my raising skills."
			TextAfterLoose = "Aww... I guess I haven't raised them well enough."
			TextAfterWin = "Do you wanna know my secret to breeding pokemon?"
			LookDistance = 4
			Portrait = 'PKMNBreederFemale2.png'
		PKMNBreeder_Eldridge
			Pokes = list(/mob/Pokemon/Bedrill = 9, /mob/Pokemon/Clefairy = 9, /mob/Pokemon/Murkrow = 9, /mob/Pokemon/Heracross = 9, /mob/Pokemon/Ledyba = 9, /mob/Pokemon/Rattata = 9)
			ClothingOverlays = list("Shoes"= "Red Shoes", "Robe"= "Red Civilian Clothes", "Hood"="Apron","Accesories"= "Red headscarf")
			TextBeforeAccepted = "I am going to be the number 1 Pokemon Breeder One day!"
			TextBeforeBattle = "Battling is part of the raising Pokemon."
			TextAfterLoose = "I still have a long road ahead."
			TextAfterWin = "Don't worry I'll teach you my breeding techniques."
			LookDistance = 4
			Portrait = 'PKMNBreederMale1.png'
		PKMNManiac_Joshua
			Pokes = list(/mob/Pokemon/Pikachu = 12, /mob/Pokemon/Pichu = 10, /mob/Pokemon/Raichu = 14)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Maniac", "Hair"="ComboverHairBlack","Accesories"= "Glasses")
			TextBeforeAccepted = "I LOVE POKEMON!"
			TextBeforeBattle = "BATTLE ME, BATTLE ME, BATTLE MEEEE!"
			TextAfterLoose = " I need more pokemon."
			TextAfterWin = "You need more pokemon like mine."
			LookDistance = 3
			Portrait = 'PKMNManiac.png'
		Rocker_Johnathan
			Pokes = list(/mob/Pokemon/Graveler = 14, /mob/Pokemon/Electabuzz = 15, /mob/Pokemon/Nidorino = 14)
			ClothingOverlays = list( "Shoes" = "Black Shoes", "Robe" = "Jeans", "Hair"="ElectricHairBlonde","Accesories"= "guitar")
			TextBeforeAccepted = "I'm a Rockstar!"
			TextBeforeBattle = "Let us battle like some rockstars!"
			TextAfterLoose = "I guess I didn't rock hard enough."
			TextAfterWin = " Rock harder next time."
			LookDistance = 4
			Portrait = 'Guitarist.png'
//Route 103//------------------------------------------------------------------------------------------------------------
	Route_103
		Picnicker_Shanai
			Pokes = list(/mob/Pokemon/Cubone = 6, /mob/Pokemon/Sandshrew = 6, /mob/Pokemon/Nidorina = 9)
			ClothingOverlays = list( "Shoes" = "", "Robe"= "Picnic Outfit", "Hair"="LongHairBlue","Accesories"= "Picnic Hat")
			TextBeforeAccepted = "Do you like to go on picnics?"
			TextBeforeBattle = "I think you should go on picnics with your pokemon."
			TextAfterLoose = "Maybe next time we can go on a picnic together."
			TextAfterWin = "Maybe next time we can go on a picnic together."
			LookDistance = 4
			Portrait = 'Picnicker1.png'
		Picnicker_Iesha
			Pokes = list(/mob/Pokemon/Diglett = 8, /mob/Pokemon/Zubat = 8, /mob/Pokemon/Nidorino = 13)
			ClothingOverlays = list( "Shoes" = "", "Robe"= "Picnic Outfit", "Hair"="LongHairBrown","Accesories"= "Picnic Hat")
			TextBeforeAccepted = "Picnics are great!"
			TextBeforeBattle = "Let me show you what I packed today!"
			TextAfterLoose = "Maybe next time we can go on a picnic together."
			TextAfterWin = "Maybe next time we can go on a picnic together."
			LookDistance = 4
			Portrait = 'Picnicker1.png'
		Camper_Andre
			Pokes = list(/mob/Pokemon/Sandslash = 20)
			ClothingOverlays = list( "Shoes" = "", "Robe" = "Camper", "Hair"="FlatHairBlack","Accesories"= "Camper Hat")
			TextBeforeAccepted = "Camping is an experience like no other."
			TextBeforeBattle = "I been out here camping by myself with my sandshrew only!"
			TextAfterLoose = "Next, time the outcome will not be the same."
			TextAfterWin = "If you camped more often then maybe you would be able to win."
			TextPassByAfterWin = "Ok sandshrew you dig a hole right there and I will put this pole in it."
			LookDistance = 4
			Portrait = 'MaleCamper1.png'
		Camper_Cedric
			Pokes = list(/mob/Pokemon/Dugtrio = 20)
			ClothingOverlays = list( "Shoes" = "", "Robe" = "Camper", "Hair"="FlatHairBlack","Accesories"= "Camper Hat")
			TextBeforeAccepted = "Camping is an experience like no other."
			TextBeforeBattle = "I been out here camping by myself with my diglett only!"
			TextAfterLoose = "Next, time the outcome will not be the same."
			TextAfterWin = "If you camped more often then maybe you would be able to win."
			TextPassByAfterWin = "Ok diglett you dig a hole right there and I will put this pole in it."
			LookDistance = 4
			Portrait = 'MaleCamper1.png'
		Fisherman_Brandon
			Pokes = list(/mob/Pokemon/Horsea = 13, /mob/Pokemon/Slowpoke = 14,/mob/Pokemon/Magikarp = 12,)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Fisherman Outfit", "Hair"="BirchHairBlack","Accesories"= "Fisherman Cap")
			TextBeforeAccepted = "Oh wow! I missed that small one!"
			TextBeforeBattle = "This area has different pokemon to offer."
			TextAfterLoose = "Maybe I should upgrade to a Good Rod."
			TextAfterWin = "Yes! I caught great pokemon!"
			TextPassByAfterWin = "Hmmm, so the better the rod you have, ranging from Old Rod, to Good Rod, to Super Rod, the better the Pokemon you can find. Interesting."
			LookDistance = 4
			Portrait = 'Fisherman1.png'
//Elkvale Forest//------------------------------------------------------------------------------------------------------------
	Elkvale_Forest
		Bugcatcher_Bob
			Pokes = list(/mob/Pokemon/Butterfree = 14,/mob/Pokemon/Bedrill = 14)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Green", ,"Accesories"= "Straw Hat Green")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are alot of bug pokemon in the forest."
			TextAfterLoose = "I'll stick to collecting."
			TextAfterWin = "Bugs defeat all!"
			LookDistance = 4
			Portrait = 'Bugcatcher3.png'
		Bugcatcher_Demond
			Pokes = list(/mob/Pokemon/Heracross = 20)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Blue", ,"Accesories"= "Straw Hat Blue")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are very rare pokemon in these parts."
			TextAfterLoose = " Have you seen a scyther."
			TextAfterWin = "Mine are stronger than yours!"
			TextPassByAfterWin = "Where could scyther be?"
			LookDistance = 4
			Portrait = 'Bugcatcher2.png'
		Bugcatcher_Richard
			Pokes = list(/mob/Pokemon/Scyther = 20)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Blue", ,"Accesories"= "Straw Hat Blue")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are very rare pokemon in these parts."
			TextAfterLoose = " Have you seen a Heracross."
			TextAfterWin = "Mine are stronger than yours!"
			TextPassByAfterWin = "Where could Heracross be?"
			LookDistance = 4
			Portrait = 'Bugcatcher2.png'
		Bugcatcher_Dexter
			Pokes = list(/mob/Pokemon/Spinarak = 14, /mob/Pokemon/Caterpie = 13, /mob/Pokemon/Weedle = 13)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Green", ,"Accesories"= "Straw Hat Green")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "Different types can be found in different places."
			TextAfterLoose = "Wow, i guess you spent more time here didnt you."
			TextAfterWin = "Ha, better luck next time!"
			TextPassByAfterWin = "I heard there was an electric type in these parts?"
			LookDistance = 4
			Portrait = 'Bugcatcher3.png'
		Bugcatcher_Anthony
			Pokes = list(/mob/Pokemon/Heracross = 18, /mob/Pokemon/Scyther = 18, /mob/Pokemon/Ariados = 20)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Red","Hair" = "Bugsunglasses" ,"Accesories"= "Straw Hat Red")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "I will be a Pokemon Bug Master one day."
			TextAfterLoose = "I will be victorious one day."
			TextAfterWin = "Ha! One more victory towards my goal."
			TextPassByAfterWin = "Tch.. Still not ready for Mary Ann."
			LookDistance = 4
			Portrait = 'Bugcatcher2.png'
		PKMNManiac_Robert
			Pokes = list(/mob/Pokemon/Gastly = 12, /mob/Pokemon/Haunter = 14)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Maniac", "Hair"="ComboverHairBlack","Accesories"= "Glasses")
			TextBeforeAccepted = "I LOVE POKEMON!"
			TextBeforeBattle = "Have you been in the forest at night!"
			TextAfterLoose = "Wow guess I could not spoke you enough."
			TextAfterWin = "Ha! Come here at night and see what I see!"
			LookDistance = 3
			Portrait = 'PKMNManiac.png'
		BirdKeeper_Carlos
			Pokes = list(/mob/Pokemon/Hoothoot = 13)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Breeder red", "Hair"="BrandonHairWhite","Accesories"= "Jeans")
			TextBeforeAccepted = "Birds are so cool!"
			TextBeforeBattle = "I wish I was able to take flight!"
			TextAfterLoose = "Wait one day I will sore."
			TextAfterWin = "I already in the sky, you need to keep up!"
			TextPassByAfterWin = "This is a perfect place to train bird pokemon."
			LookDistance = 3
			Portrait = 'Birdkeeper1.png'
//Route 304//------------------------------------------------------------------------------------------------------------
	Route_304
		AromaLady_Kim
			Pokes = list(/mob/Pokemon/Oddish = 13, /mob/Pokemon/Gloom = 15)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Aromaladysuit", "Hair"="BigHairBlonde","Accesories"= "")
			TextBeforeAccepted = "Looks great outside!"
			TextBeforeBattle = "The flowers smell great today!"
			TextAfterLoose = "Looks like the grass needs watering."
			TextAfterWin = "The flowers are a bloom!"
			TextPassByAfterWin = "The Trees are just glowing this afternoon."
			LookDistance = 5
			Portrait = 'Aromalady1.png'
		AromaLady_Susan
			Pokes = list(/mob/Pokemon/Bellsprout = 13, /mob/Pokemon/Weepinbell = 15)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Aromaladysuit", "Hair"="BigHairBrown","Accesories"= "")
			TextBeforeAccepted = "Looks great outside!"
			TextBeforeBattle = "What a beautiful day. Battle? Ok!"
			TextAfterLoose = "Aww.. Sun is going down."
			TextAfterWin = "Yep, Suns still shining!"
			TextPassByAfterWin = "The Grass smells so good today."
			LookDistance = 5
			Portrait = 'Aromalady2.png'
		Cooltrainer_Jordan
			Pokes = list(/mob/Pokemon/Wartortle = 15, /mob/Pokemon/Poliwhirl = 15, /mob/Pokemon/Vaporeon =15)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Green Jumpsuit", "Hair"="BirchHairBrown","Accesories"= "Green Headband")
			TextBeforeAccepted = "Me and my Pokemon are so cool, we are ICE COLD!"
			TextBeforeBattle = "I will show you how cool we are."
			TextAfterLoose = "Eh, loosing is not cool!"
			TextAfterWin = "See?! Winning is cool."
			MoneyGiven = 212
			LookDistance = 4
			Portrait = 'CooltrainerMale1.png'
//Route 202 Cave//------------------------------------------------------------------------------------------------------------
	Route_202_Cave
		Hiker_Kevin
			ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
			Pokes = list(/mob/Pokemon/Onix = 10, /mob/Pokemon/Geodude = 10)
			TextBeforeAccepted = "Yea, nothing better than a good ole hike up the mountains."
			TextBeforeBattle = "Hmmm.. I never thought this cave was this big."
			TextAfterLoose = "Ugh I think I am lost."
			TextAfterWin = "If you had a map you would be just like me!"
			TextPassByAfterWin = "I think it gets darker up ahead."
			LookDistance = 10
			Portrait = 'Hiker2.png'
		Hiker_Matthew
			ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
			Pokes = list(/mob/Pokemon/Teddiursa = 10, /mob/Pokemon/Aron = 10)
			TextBeforeAccepted = "Yea, nothing better than a good ole hike up the mountains."
			TextBeforeBattle = "Hmmm.. I never thought this cave was this big."
			TextAfterLoose = "Ugh I think I am lost."
			TextAfterWin = "If you had a map you would be just like me!"
			TextPassByAfterWin = "I think it gets darker up ahead."
			LookDistance = 10
			Portrait = 'Hiker2.png'

//PowerPlant//------------------------------------------------------------------------------------------------------------------
	PowerPlant
		Engineer_Bill
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="","Accesories"= "Hardhat")
			Pokes = list(/mob/Pokemon/Magnemite = 5, /mob/Pokemon/Voltorb = 5)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "I am new here why am I getting worked so hard."
			TextAfterLoose = "Hey, can you be my new boss."
			TextAfterWin = "Maybe you should apply for an intership with me."
			TextPassByAfterWin = "Have you heard the rumors."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Engineer_Dill
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="","Accesories"= "Hardhat")
			Pokes = list(/mob/Pokemon/Pikachu = 9)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "The boss has been working me hard lately."
			TextAfterLoose = "Hey, can you be my new boss."
			TextAfterWin = "Maybe you should apply for an intership with me."
			TextPassByAfterWin = "Pikachu run wild in hear, but I think you need to be really good to see something special."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Engineer_Hill
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="","Accesories"= "")
			Pokes = list(/mob/Pokemon/Voltorb = 5, /mob/Pokemon/Voltorb = 7)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "Man, anything to get me a break."
			TextAfterLoose = "Thanks that was needed."
			TextAfterWin = "Man you werent good enough."
			TextPassByAfterWin = "Voltorbs run wild in hear, but I think you need to be really good to see something special."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Engineer_Nill
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="SpikeHairBrown","Accesories"= "")
			Pokes = list(/mob/Pokemon/Magnemite = 5, /mob/Pokemon/Magnemite = 7)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "12 hour shifts sound like nothing to you right try 16 hour shifts."
			TextAfterLoose = "Only reason I lost is because I been working to hard."
			TextAfterWin = "I am already exhausted and you couldnt win."
			TextPassByAfterWin = "Magnemites run wild in hear, but I think you need to be really good to see something special."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Engineer_Will
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="","Accesories"= "Hardhat")
			Pokes = list(/mob/Pokemon/Pichu = 11)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "The boss has been working me hard lately."
			TextAfterLoose = "Wait till I fully evolve this pichu."
			TextAfterWin = "I used a baby maybe you should to."
			TextPassByAfterWin = "Pichus run wild in hear, but I think you need to be really good to see something special."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Head_Engineer_Darwin
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Coveralls", "Hair"="","Accesories"= "Hardhat")
			Pokes = list(/mob/Pokemon/Magnemite = 9, /mob/Pokemon/Voltorb = 9, /mob/Pokemon/Pikachu = 9, /mob/Pokemon/Electabuzz = 10)
			TextBeforeAccepted = "Feels good to work long days."
			TextBeforeBattle = "I am in charge here and who told you that your allowed up here we are in a crises right now."
			TextAfterLoose = "Maybe you could be of use to us."
			TextAfterWin = "Now leave and dont come back we are very busy"
			TextPassByAfterWin = "This powerplant is owned by the gymleaders family."
			LookDistance = 4
			Portrait = 'Engineer.png'
		Scientist_Mike
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Labcoat", "Hair"="ComboverHairBlonde","Accesories"= "")
			Pokes = list(/mob/Pokemon/Grimer = 8, /mob/Pokemon/Koffing = 8)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "Potions and Chemicals, I love my job."
			TextAfterLoose = "Man Ike was my down fall."
			TextAfterWin = "Ike is just too good for you I didnt have to use my Potions"
			TextPassByAfterWin = "I bet you cant beat us again."
			LookDistance = 4
			Portrait = 'Scientist.png'
		Scientist_Ike
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Lab Coat", "Hair"="ComboverHairBrown","Accesories"= "Glasses")
			Pokes = list(/mob/Pokemon/Koffing = 8, /mob/Pokemon/Grimer = 8)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "Chemicals and Potions, I love my job."
			TextAfterLoose = "Man Mike was my down fall."
			TextAfterWin = "Mike is just too good for you I didnt have to use my Chemicals."
			TextPassByAfterWin = "I bet you cant beat us again."
			LookDistance = 4
			Portrait = 'Scientist.png'

//Lunar Mountain//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Lunar_Mountain
		Team_Rocket
			Team_Rocket_Grunt_Leo
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Persian = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_George
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Weezing = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Elizabeth
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Arbok = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_Jessie
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Ekans = 10, /mob/Pokemon/Meowth = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I am an elite member of Team rocket."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "We are blasting off againnnnnnnnnn."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_James
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 10, /mob/Pokemon/Meowth = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I was forced into this group so I am sorry but I will be taking your pokemon now."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "We are blasting off againnnnnnnnnnn."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Satoshi
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 7, /mob/Pokemon/Zubat = 7, /mob/Pokemon/Ekans = 7, /mob/Pokemon/Meowth = 7)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_May
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 10, /mob/Pokemon/Zubat = 8)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_Austin
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Ekans = 10, /mob/Pokemon/Weedle = 7)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I can see you went to heal its ok I know we are tuff but healing wont save you."
				TextPassByAfterWin = "I can see you went to heal its ok I know we are tuff but healing wont save you."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_MacDonald
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Larvitar = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "No wonder we control this cave look what I found."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Tradable = 0
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Derek
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Houndour = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Ha Ha look what I caught."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Casey
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlonde", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 10, /mob/Pokemon/Ekans = 8, /mob/Pokemon/Drowzee = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Your getting tired arent you I will end this here."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_Jack
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Phanpy = 8, /mob/Pokemon/Drowzee = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I am pretty diffirent."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Roger
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Nidoking = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Fall before us now."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Ashley
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongBlackHair", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Nidoqueen = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Fall before us now."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Captain_Boric
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="ComboverHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Weezing = 10, /mob/Pokemon/Arbok = 10, /mob/Pokemon/Persian = 10, /mob/Pokemon/Golbat = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "So you made it to me, ha where this is where it ends."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "Lance should handle you."
				LookDistance = 4
				Portrait = 'TeamRocketCaptain.png'
			Team_Rocket_General_Lance
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="ComboverHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Weezing = 10, /mob/Pokemon/Arbok = 10, /mob/Pokemon/Persian = 10, /mob/Pokemon/Golbat = 10, /mob/Pokemon/Dratini = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Hmmm, So a trainer like you actually exisists in thsi region, I am partly surpised well let me test your strength."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will battle in the future and I will be the victor."
				LookDistance = 4
				Tradable = 0
				Portrait = 'TeamRocketGeneral.png'
	Lunar_Mountain
		Normal_Trainers
			Hiker_Richard
				ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
				Pokes = list(/mob/Pokemon/Larvitar = 8, /mob/Pokemon/Geodude = 7)
				TextBeforeAccepted = "Yea, nothing better than a good ole cave journey."
				TextBeforeBattle = "Hmmm.. I never thought this cave was this big."
				TextAfterLoose = "Ugh I think I am lost."
				TextAfterWin = "If you had a map you would be just like me!"
				TextPassByAfterWin = ""
				LookDistance = 10
				Tradable = 0
				Portrait = 'Hiker2.png'
			Hiker_Charlie
				ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
				Pokes = list(/mob/Pokemon/Golbat = 11)
				TextBeforeAccepted = "Yea, nothing better than a good ole cave journey."
				TextBeforeBattle = "Hmmm.. I never thought this cave was this big."
				TextAfterLoose = "Ugh I think I am lost."
				TextAfterWin = "If you had a map you would be just like me!"
				TextPassByAfterWin = ""
				LookDistance = 10
				Portrait = 'Hiker1.png'
			Cooltrainer_Paul
				Pokes = list(/mob/Pokemon/Jolteon = 14, /mob/Pokemon/Vaporeon = 14, /mob/Pokemon/Flareon =14)
				ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Black Jumpsuit", "Hair"="BirchHairBlack","Accesories"= "Black Headband")
				TextBeforeAccepted = "Fire, Water, and Lighting I got them all!"
				TextBeforeBattle = "Fire, Water, and Lighting I got them all!"
				TextAfterLoose = "Eh, loosing is not hot!"
				TextAfterWin = "See?! Winning is Hot."
				TextPassByAfterWin = "I guess I need more type coverage"
				LookDistance = 6
				Tradable = 0
				Portrait = 'CooltrainerMale2.png'
			Cooltrainer_Don
				ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Female Black Jumpsuit", "Hair"="MayHairBlonde","Accesories"= "Black Bandana")
				Pokes = list(/mob/Pokemon/Wartortle = 14,/mob/Pokemon/Charmeleon = 14,/mob/Pokemon/Ivysaur = 14)
				TextBeforeAccepted = "Oh I just love my Squirtle!"
				TextBeforeBattle = "These are the best of the bunch so I had to catch them all."
				TextAfterLoose = "Great Battle!"
				TextAfterWin = "Great Battle! Come see me again."
				TextPassByAfterWin = "Maybe the other 3 would of served me better"
				LookDistance = 3
				Tradable = 0
				Portrait = 'May1.png'
			BirdKeeper_Juan
				Pokes = list(/mob/Pokemon/Hoothoot = 12, /mob/Pokemon/Spearow = 11)
				ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Breeder red", "Hair"="BrandonHairWhite","Accesories"= "Jeans")
				TextBeforeAccepted = "Birds are so fun!"
				TextBeforeBattle = "Come lets take flight!"
				TextAfterLoose = "Wait one day I will sore."
				TextAfterWin = "I already in the sky, you need to keep up!"
				TextPassByAfterWin = "I am looking for this bat pokemon have you seen it?"
				LookDistance = 3
				Portrait = 'Birdkeeper1.png'
			PKMNManiac_Bush
				Pokes = list(/mob/Pokemon/Phanpy = 12, /mob/Pokemon/Donphan = 14)
				ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Maniac", "Hair"="ComboverHairBlack","Accesories"= "Glasses")
				TextBeforeAccepted = "I LOVE POKEMON!"
				TextBeforeBattle = "Have you been in the forest at night!"
				TextAfterLoose = "Wow guess I could not spoke you enough."
				TextAfterWin = "Ha! Come here at night and see what I see!"
				LookDistance = 3
				Tradable = 0
				Portrait = 'PKMNManiac.png'
//Ice Path//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Ice Cave//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Ice_Cave
		Team_Rocket
			Team_Rocket_Grunt_CodeName:_Blade
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Persian = 14)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You may remeber me, my name was Leo. I have been promoted now, witness my Blade"
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Smoke
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Weezing = 13)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Toxic
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Arbok = 14)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what your messing with."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_Jessie
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Arbok = 15, /mob/Pokemon/Seviper = 13, /mob/Pokemon/Meowth = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I am an elite member of Team rocket version 2."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "We are blasting off againnnnnnnnnn."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_James
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Weezing = 15, /mob/Pokemon/Growlithe = 13, /mob/Pokemon/Meowth = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Guess who I picked up from my house?"
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "We are blasting off againnnnnnnnnnn."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Wings
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 7, /mob/Pokemon/Zubat = 7, /mob/Pokemon/Ekans = 7, /mob/Pokemon/Meowth = 7)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "They call me wings yet I am stuck underground."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Sky
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 10, /mob/Pokemon/Zubat = 8, /mob/Pokemon/Dustox = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, I was watching you from the sky."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_CodeName:_Beast
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Ekans = 10, /mob/Pokemon/Weedle = 7, /mob/Pokemon/Numel = 9)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "You think you can pass, man you dont know what a Beast is."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I can see you went to heal its ok I know we are tuff but healing wont save you."
				TextPassByAfterWin = "I can see you went to heal its ok I know we are tuff but healing wont save you."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Controller
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Larvitar = 18)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "We control this cave and I will control you."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Tradable = 0
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Darkness
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Houndour = 13, /mob/Pokemon/Murkrow = 13, /mob/Pokemon/Gastly = 12)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I shall shroud you in Darkness."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will get what we want in the end."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_Casey
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongHairBlonde", "Accesories"= "TeamRocket hat")
				Pokes = list(/mob/Pokemon/Koffing = 10, /mob/Pokemon/Ekans = 8, /mob/Pokemon/Drowzee = 9, /mob/Pokemon/Electabuzz = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Your getting tired arent you I will end this here, again."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Grunt_Jack
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Phanpy = 8, /mob/Pokemon/Drowzee = 9, /mob/Pokemon/Zangoose = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "I am pretty diffirent."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Wall_1
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Nidoking = 13, /mob/Pokemon/Ralts = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Fall before us now."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntMale.png'
			Team_Rocket_Grunt_CodeName:_Wall_2
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="LongBlackHair", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Nidoqueen = 13, /mob/Pokemon/Ralts = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Fall before us now."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "This still isnt over."
				LookDistance = 4
				Portrait = 'TeamRocketGruntFemale.png'
			Team_Rocket_Captain_Boric
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="ComboverHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Zangoose = 10, /mob/Pokemon/Seviper = 10, /mob/Pokemon/Persian = 10, /mob/Pokemon/Mightyena = 10)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Ha, I am stronger now things wont end like last time."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "Lance should handle you."
				LookDistance = 4
				Portrait = 'TeamRocketCaptain.png'
			Team_Rocket_General_Lance
				ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "TeamRocket overall", "Hair"="ComboverHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Weezing = 11, /mob/Pokemon/Arbok = 11, /mob/Pokemon/Persian = 11, /mob/Pokemon/Golbat = 11, /mob/Pokemon/Dragonair = 11, /mob/Pokemon/Pupitar = 11)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Your interfereing with our plans again, Well I am stronger now its time to end this."
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We will battle in the future and I will be the victor."
				LookDistance = 4
				Tradable = 0
				Portrait = 'TeamRocketGeneral.png'
			Team_Rocket_Leader_Maxamillion
				ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="ComboverHairBlack", "Accesories"= "TeamRocket hat")
				Pokes = list( /mob/Pokemon/Gardevoir = 14, /mob/Pokemon/Salamence = 14, /mob/Pokemon/Metagross = 14, /mob/Pokemon/Flygon = 14, /mob/Pokemon/Regice = 14, /mob/Pokemon/Claydol = 14)
				TextBeforeAccepted = "Man where is my lunch break."
				TextBeforeBattle = "Hello, I am Team Rocket Leader Alexander, I have heard much about you. Why, dont you join us?"
				TextAfterLoose = "Stupid Pokemon."
				TextAfterWin = "I will be taking your pokemon now do not run."
				TextPassByAfterWin = "We shall meet again young trainer."
				LookDistance = 4
				Tradable = 0
				//Portrait = 'TeamRocketLeader.png'

//Snorlax Valley//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Snorlax_Valley
		Hiker_Demond
			ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Hiker Outfit", "Hair"="","Accesories"= "Hiker Hat")
			Pokes = list(/mob/Pokemon/Steelix = 12)
			TextBeforeAccepted = "Yea, nothing better than a good ole cave journey."
			TextBeforeBattle = "Hmmm.. I never thought this cave was this big."
			TextAfterLoose = "Ugh I think I am lost."
			TextAfterWin = "If you had a map you would be just like me!"
			TextPassByAfterWin = ""
			LookDistance = 10
			Portrait = 'Hiker1.png'
		Cooltrainer_Aubrini
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Female Black Jumpsuit", "Hair"="MayHairBlonde","Accesories"= "Black Bandana")
			Pokes = list(/mob/Pokemon/Wartortle = 14,/mob/Pokemon/Vaporeon = 14,/mob/Pokemon/Corphish = 14)
			TextBeforeAccepted = "Oh I just love my Squirtle!"
			TextBeforeBattle = "Don't worry my Pokemon will cool you down."
			TextAfterLoose = "Great Battle!"
			TextAfterWin = "Great Battle! Come see me again."
			TextPassByAfterWin = "Maybe the other 3 would of served me better"
			LookDistance = 3
			Tradable = 0
			Portrait = 'May1.png'
		PKMNManiac_Snoopy
			Pokes = list(/mob/Pokemon/Snorlax = 19)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Maniac", "Hair"="ComboverHairBlack","Accesories"= "Glasses")
			TextBeforeAccepted = "I LOVE POKEMON!"
			TextBeforeBattle = "Bet you can't guess what I collected."
			TextAfterLoose = "Wow guess I could not spook you enough."
			TextAfterWin = "Ha! Come here at night and see what I see!"
			LookDistance = 3
			Tradable = 0
			Portrait = 'PKMNManiac.png'
		Scientist_Cory
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Engineer Suit", "Hair"="ComboverHairBrown","Accesories"= "Engineer Hat")
			Pokes = list(/mob/Pokemon/Sableye = 9, /mob/Pokemon/Torkoal = 9)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "Just doing some research in this valley, Oh you didnt ask?"
			TextAfterLoose = "Man Ike was my down fall."
			TextAfterWin = "Ike is just too good for you I didnt have to use my Potions"
			TextPassByAfterWin = "I bet you cant beat us again."
			LookDistance = 4
			Portrait = 'Scientist.png'
		Bugcatcher_Richard
			Pokes = list(/mob/Pokemon/Ninjask = 20)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Blue", ,"Accesories"= "Straw Hat Blue")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are very rare pokemon in these parts."
			TextAfterLoose = " Have you seen a Heracross."
			TextAfterWin = "Mine are stronger than yours!"
			TextPassByAfterWin = "Where could Heracross be?"
			LookDistance = 4
			Portrait = 'Bugcatcher2.png'
//\//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Acconna_Desert
		Collector_Desmond
			ClothingOverlays = list("Shoes"= "Hikershoe", "Robe"= "Black Desert Wear", "Hood"="Turban","Accesories"= "Sunglasses")
			Pokes = list(/mob/Pokemon/Beldum = 9,/mob/Pokemon/Beldum = 9,/mob/Pokemon/Beldum = 9,/mob/Pokemon/Metang = 14,)
			TextBeforeAccepted = "I am still looking to complete my collection."
			TextBeforeBattle = "Lets see what you have collected?!."
			TextAfterLoose = "Not enough...."
			TextAfterWin = "You should look into getting more Pokemon!"
			TextPassByAfterWin = ""
			LookDistance = 6
			Portrait = 'Collector2.png'
		Cooltrainer_Aubrini
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Female Black Jumpsuit", "Hair"="MayHairBlonde","Accesories"= "Black Bandana")
			Pokes = list(/mob/Pokemon/Wartortle = 14,/mob/Pokemon/Vaporeon = 14,/mob/Pokemon/Corphish = 14)
			TextBeforeAccepted = "Oh I just love my Squirtle!"
			TextBeforeBattle = "Don't worry my Pokemon will cool you down."
			TextAfterLoose = "Great Battle!"
			TextAfterWin = "Great Battle! Come see me again."
			TextPassByAfterWin = "Maybe the other 3 would of served me better"
			LookDistance = 3
			Tradable = 0
			Portrait = 'May1.png'
		PKMNManiac_Snoopy
			Pokes = list(/mob/Pokemon/Snorlax = 19)
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Maniac", "Hair"="ComboverHairBlack","Accesories"= "Glasses")
			TextBeforeAccepted = "I LOVE POKEMON!"
			TextBeforeBattle = "Bet you can't guess what I collected."
			TextAfterLoose = "Wow guess I could not spook you enough."
			TextAfterWin = "Ha! Come here at night and see what I see!"
			LookDistance = 3
			Tradable = 0
			Portrait = 'PKMNManiac.png'
		Scientist_Cory
			ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "Engineer Suit", "Hair"="ComboverHairBrown","Accesories"= "Engineer Hat")
			Pokes = list(/mob/Pokemon/Sableye = 9, /mob/Pokemon/Torkoal = 9)
			TextBeforeAccepted = "Man where is my lunch break."
			TextBeforeBattle = "Just doing some research in this valley, Oh you didnt ask?"
			TextAfterLoose = "Man Ike was my down fall."
			TextAfterWin = "Ike is just too good for you I didnt have to use my Potions"
			TextPassByAfterWin = "I bet you cant beat us again."
			LookDistance = 4
			Portrait = 'Scientist.png'
		Bugcatcher_Richard
			Pokes = list(/mob/Pokemon/Ninjask = 20)
			ClothingOverlays = list("Shoes"= "Sandals", "Robe"= "Bugcatcher Blue", ,"Accesories"= "Straw Hat Blue")
			TextBeforeAccepted = "I'll take a break from Bugcatching, let's battle!"
			TextBeforeBattle = "There are very rare pokemon in these parts."
			TextAfterLoose = " Have you seen a Heracross."
			TextAfterWin = "Mine are stronger than yours!"
			TextPassByAfterWin = "Where could Heracross be?"
			LookDistance = 4
			Portrait = 'Bugcatcher2.png'