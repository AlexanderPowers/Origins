obj/NoVerb/verb/Take()
	set src in oview(1)
	view()<<System("[usr] picks up [src].")
	mouse_over_pointer = null
	take(usr)
obj/NoVerb/verb/Drop()
	view()<<System("[usr] drops [src].")
	mouse_over_pointer = image('Pointer.dmi',"Take")
	src.drop(usr)
obj/NoVerb/verb/Discard()
	if(alert(usr,"Would you like to discard [src]?",,"Yes","No") == "Yes")
		del src
		var/mob/Player/P = usr
		if(isPlayer(P)) P.UpdateItems()
obj/NoVerb/verb/Examine()
	if(Description)
		if(isPlayer(usr))
			var/mob/Player/P = usr
			P.QuestCheck("Examine Item", src)
		winset(usr, "ItemInformation", "is-visible=true")
		winset(usr, "ItemName", "text='[src.name]'")
		var/icon/I = new(src.icon, src.icon_state)
		var/iconfile = fcopy_rsc(I)
		winset(usr, "ItemImage", "image=\ref[iconfile]")
		usr<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[Description]","ItemDescription")
	//	winset(usr, "ItemDescription", "text ='[Description]")
mob/verb/CloseItemInfo()
	set hidden = 1
	winset(usr, "ItemInformation", "is-visible=false")


obj/
	var
		TakeDrop
		Discard
		Amount = 1
		Stackable
		Price
		Description
		Owned
	New()
		if(TakeDrop)
			src.verbs += /obj/NoVerb/verb/Drop
			src.verbs += /obj/NoVerb/verb/Take
			if(!ismob(loc)) mouse_over_pointer = image('Pointer.dmi',"Take") //If its not in someones pocket..
		if(Discard)
			src.verbs += /obj/NoVerb/verb/Discard
		if(Description)
			src.verbs += /obj/NoVerb/verb/Examine

obj/proc/take(mob/Player/M)
	if(Owned)
		if(Owned != M.ckey)
			M<<System("This [src] does not belong to you")
	if(Stackable)
		var/obj/O
		for(var/obj/o in M.contents)
			if(o.type == src.type)
				O = o
		if(O)
			O.Amount += src.Amount
			loc = null
			M.UpdateItems()
			spawn(30)
				del src
		else

			Move(M)
			M.UpdateItems()


	else Move(M)
	M.UpdateItems()


obj/proc/drop(mob/Player/M)
	if(Stackable)
		var/input = round(input("Drop how many?") as num)
		if(input <= 0 || input > Amount) return
		var/obj/O = new src.type(M.loc)
		O.Amount = input
		Amount -= input


		if(src.Amount <= 0)
			loc = null
			M.UpdateItems()
			del src
	else loc = M.loc
	if(M.ItemUsing == src)
		M.ItemUsing = null
		if(M.client) M.client.mouse_pointer_icon = null
	M.UpdateItems()

obj/proc/Subtract(mob/Player/M, var/num) //Subtracts from the total amount, if there is none left, deletes the item
	spawn()
		src.Amount -= num
		if(Amount <= 0)
			loc = null
			M.UpdateItems()
			spawn(150)
				del src
		M.UpdateItems()



obj/proc/ItemUse(var/User)

mob/var/obj/tmp/ItemUsing = null //VERY IMPORTANT VARIABLE.
//KeyItems
obj/Important_Items
	Inventory_Checker
		New()
			del src
	Running_Shoes
		icon = 'Important Items.dmi'
		icon_state = "Running Shoes"
		Description = "Slip on these running shoes and run with the speed of the wind! Press Z to activate, release Z to go back to normal walking speed"
	Rods
		TakeDrop = 0
		icon = 'Important Items.dmi'
		var/
			LevelMax //This is the highest level the rod can find.
			Prob = 15
		Click()
			var/mob/Player/M
			if(istype(usr,/mob/Player)) M = usr
			else return

			if(M.Fishing) return //They cannot fish twice
			if(M.FightingPokemon && !M.FightingPokemon.loc && M.FightingPokemon.HP > 0) return
			var/turf/W = get_step(M,M.dir)
			var/area/A = M.loc.loc
			if(!istype(W,/turf/Routes/Water) || !A.ReleaseCheck())
				M<<System("This item can not be used in this location")
				return 0

			M.Fishing = 1
			M.overlays += image('Clothing.dmi',"FishingOverlay")
			M.underlays += image('Clothing.dmi',"FishingUnderlay")
			sleep(30)
			if(!M) return
			M.overlays -= image('Clothing.dmi',"FishingOverlay")
			M.underlays -= image('Clothing.dmi',"FishingUnderlay")
			M.Fishing = 0

			if(prob(Prob))
				var/atom/T = get_step(M,M.dir)
				var/mob/Pokemon/P = Generate_Pokemon(T.loc,M,"Fishing")
				M.overlays += /obj/HUD/OMG
				sleep(10)
				if(!M) return
				M.overlays -= /obj/HUD/OMG
				P.Create(P.Level)

				P.loc = src.loc
				if(M.ControlingPokemon) P.Target = M.ControlingPokemon
				else P.Target = M
				P.Wander(M)
				P.Finder = M
				if(M.FightingPokemon)
					var/mob/Pokemon/PPP = M.FightingPokemon
					spawn(30) //For wild Pokemon. If they aren't caught within 3 seconds, they will vanish.
						if(!PPP.Owner)
							del PPP

				M.FightingPokemon = P
				M.QuestCheck("Fish Pokemon", P)

				step(P,pick(1,2,4,8))
			else
				M<<System(pick("Not even a Nibble", "The fish just aren't biting", "Looks like they got your bait!"))
		New()
			Description += "<BR><BR>To use a Rod, face the water and click it in your inventory."
			..()
		Old_Rod
			icon_state = "Old Rod"
			Description = "Used to catch weak Water-type Pokémon."
			LevelMax = 15
			Prob = 15
		Good_Rod
			icon_state = "Good Rod"
			Description = "Used to catch Water-type Pokémon."
			LevelMax = 30
			Prob = 30
		Super_Rod
			icon_state = "Super Rod"
			Description = "Used to catch strong Water-type Pokémon."
			LevelMax = 999
			Prob = 60
	Fossils
		icon = 'Important Items.dmi'
		Helix_Fossil
			icon_state = "Helix Fossil"
		Dome_Fossil
			icon_state = "Dome Fossil"
		Root_Fossil
			icon_state = "Root Fossil"
		Claw_Fossil
			icon_state = "Claw Fossil"
		Old_Amber
			icon_state = "Old Amber"
	Coreys_Notebook
		name = "Corey's Notebook"
		icon = 'Important Items.dmi'
		icon_state = "Coreys Notebook"

	Bow_Letter
		name = "Bow's Letter"
		icon = 'Important Items.dmi'
		icon_state = "Letter"
	Nexus_Goods
		icon = 'Important Items.dmi'
		icon_state = "Oak's Parcel"

//Evolutions Stones//
obj/Stones
	icon = 'Evolution Items.dmi'
	TakeDrop = 1
	Discard = 1
	var/tmp/Inuse
	Click()
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		if(Inuse) return
		Inuse = 1
		var/mob/Pokemon/P = usr.Party_Choose("Which Pokemon do you want to evolve?", M.Party)
		if(P)
			if(P.Evolve[name]) //It can evolve using this stone.
				P.Evolve(name, src)
				M.UpdateItems()
		Inuse = 0

	Waterstone
		icon_state = "Water Stone"

	Leafstone
		icon_state = "Leaf Stone"
		Description = "A special stone harnesting the power of the forest."
	Thunderstone
		icon_state = "Thunder Stone"
		Description = "A special stone with lighting evoltionary properties"
	Firestone
		icon_state = "Fire Stone"
		Description = "A special stone with flame evolutionary properties"
	Moonstone
		icon_state = "Moon Stone"
		Description = "A special stone that is a fragment of a larger asteroid that came from space."
	Sunstone
		icon_state = "Sun Stone"
//Evolution List

//Hold Items//
obj/HeldItems
	icon = 'Held Items.dmi'
	TakeDrop = 1
	New()
		icon_state = name
		..()

	proc/Held_Effect(var/mob/Pokemon/H, var/Usage)

	Type_Enhance
		var/TypeEnhance
		Held_Effect(var/mob/Pokemon/H, var/Usage, var/Data)
			if(Usage == "BattleDamage")
				if(Data == TypeEnhance)
					return 1

		Black_Belt
			TypeEnhance = "Fighting"
		BlackGlasses
			TypeEnhance = "Dark"
		Charcoal
			TypeEnhance = "Fire"
		Dragon_Fang
			TypeEnhance = "Dragon"
		Hard_Stone
			TypeEnhance = "Rock"
		Magnet
			TypeEnhance = "Electric"
		Metal_Coat
			TypeEnhance = "Steel"
		Miracle_Seed
			TypeEnhance = "Grass"
		Mystic_Water
			TypeEnhance = "Water"
		NeverMeltIce
			TypeEnhance = "Ice"
		Pink_Bow
			TypeEnhance = "Normal"
		Poison_Barb
			TypeEnhance = "Poison"
		Sharp_Beak
			TypeEnhance = "Flying"
		Silk_Scarf
			TypeEnhance = "Normal"
		Silver_Powder
		Soft_Sand
			TypeEnhance = "Ground"
		Spell_Tag
			TypeEnhance = "Ghost"
		Twisted_Spoon
			TypeEnhance = "Psychic"
	Stat_Enhance
		DeepSeaScale
		DeepSeaTooth
		Eviolite
		Light_Ball
		Lucky_Punch
		Metal_Powder
		Quick_Powder
		Soul_Dew
		Stick
		Thick_Club
	Evolution
		//DeepSeaScale//
		//DeepSeaTooth//
		Dragon_Scale
		Dubious_Disc
		Electirizer
		Everstone
		Kings_Rock
		Magmarizer
		Metal_Coat
		Prism_Scale
		Protector
		Reaper_Cloth
		Up_Grade
			name = "Up-Grade"
		Oval_Stone
		Razor_Claw
		Razor_Fang

/*
	icon = 'Evolution Items.dmi'
	Stackable = 1
	TakeDrop = 1
	Discard = 1
	var/tmp/Inuse
	Click()
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		if(Inuse) return
		Inuse = 1
		var/mob/Pokemon/P = usr.Party_Choose("Give this item to who?", M.Party)
		if(P)
			if(P.HoldItem == null)
				P.HoldItem = src
				M.contents -= src
				M.UpdateItems()
			else
				M << "[P] is already holding an item"
		Inuse = 0
	Kings_Rock
		name = "King's Rock"
		icon_state = "King's Rock"
	Metal_Coat
		icon_state = "Metal Coat"
	Dragon_Scale
		icon_state = "Dragon Scale"
	Upgrade
	Everstone
	Prism_Scale
	DeepSeaScale
		icon_state = "DeapSea Scale"
	DeepSeaTooth
		icon_state = "DeepSea Tooth"
*/
//ShopItems//
obj/ShopItems
	Click()
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		if(M.ItemUsing != src)
			var/icon/I = new(icon, icon_state)
			if(M.client) M.client.mouse_pointer_icon = I
			M.ItemUsing = src

		else
			if(M.client) M.client.mouse_pointer_icon = null
			M.ItemUsing = null
		M.UpdateItems()
		return

	Stackable
		icon = 'Items.dmi'
		TakeDrop = 1
		Stackable = 1
//    /obj/ShopItems/Stackable/Potions/
		Potions
			var/HealAmount = 20
			ItemUse(var/mob/Pokemon/P)
				var/mob/Player/M = usr
				var/mob/Player/O = GetOwner(P.Owner)
				if(P.HP == P.MHP || P.HP <= 0  || O.Court)
					M<<System("It will have no effect.")
					return
				if(isPokemon(P) && isPlayer(M))
					P.HP = min(P.HP + HealAmount, P.MHP)
					if(M.ckey == P.Owner) O<<System("[P] has gained health!")
					else O<<System("[P] was given a [src] by [M]!")
					M.UpdateParty()
					if(M.client)
						M.client.mouse_pointer_icon = null
						M.ItemUsing = null
					src.Subtract(M,1)

			Potion
				icon_state = "Potion"
			Super_Potion
				HealAmount = 50
				icon_state = "Super Potion"
			Hyper_Potion
				HealAmount = 200
				icon_state = "Hyper Potion"
			Max_Potion
				HealAmount = 2000
				icon_state = "Max Potion"
//         /obj/ShopItems/Stackable/Status_Cleanse/
		Status_Cleanse
			var/HealAmount = "Sleep"
			ItemUse(var/mob/Pokemon/P)
				var/mob/Player/M = usr
				var/mob/Player/O = GetOwner(P.Owner)
				if(HealAmount != "all status ailments" && (P.Status != HealAmount || O.Court))
					M<<System("It will have no effect.")
					return
				if(isPokemon(P) && isPlayer(M))
					P.Status = null
					P.StatusKiller = null
					if(M.ckey == P.Owner) M<<System("[P] has been curred of [HealAmount]!")
					else O<<System("[P] has been curred of [HealAmount] by [M]!")
					M.UpdateParty()
					if(M.client)
						M.client.mouse_pointer_icon = null
						M.ItemUsing = null
					src.Subtract(M,1)
			Antidote
				icon_state = "Antidote"
				HealAmount = "Poison"
			Awakening
				icon_state = "Awakening"
				HealAmount = "Sleep"
			Parlyz_Heal
				icon_state = "Parlyz Heal"
				HealAmount = "Paralysis"
			Burn_Heal
				icon_state = "Burn Heal"
				HealAmount = "Burn"
			Ice_Heal
				icon_state = "Ice Heal"
				HealAmount = "Frozen"
			Full_Heal
				icon_state = "Full Heal"
				HealAmount = "all status ailments"
		Repel
		Super_Repel
		Max_Repel
//Pokeballs//-----------------------------

obj/Balls
	Stackable = 1
	TakeDrop = 1

	var/mob/Pokemon/Pokemon
//	var/tmp/mob/Player/Owner //This is for when the ball is thrown. It shows who through it, and who gets the pokemon once it has been thrown.
	var/ricon_state
	var/CR = 1 //Capture Rate, for different pokeballs(IE Ultra Ball is better than Great Ball)
	icon = 'Pokeballs.dmi'
	New()
		Description += "<BR><BR>(To use a Pokeball, click the ball to use it. Then click the Pokemon you wish to capture.)"
		..()
	proc/CalculateCR(var/mob/Pokemon/P)
		return CR


	Poke_Ball
		icon_state = "Pokeball"
		ricon_state = "Pokeball"
		CR = 1
		Description = "A tool for catching wild Pokémon."
	Great_Ball
		icon_state = "Great Ball"
		ricon_state = "Great Ball"
		CR = 1.5
		Description = "A good ball with a higher catch rate than a Poké Ball."
	Ultra_Ball
		icon_state = "Ultra Ball"
		ricon_state = "Ultra Ball"
		CR = 2
		Description = "A better ball with a higher catch rate than a Great Ball."
	Clone_Ball
		icon_state = "Clone Ball"
		ricon_state = "Clone Ball"
		CR = 0
	Net_Ball
		icon_state = "Net Ball"
		ricon_state = "Net Ball"
		CR = 1
		Description = "A somewhat different Ball that works especially well on Water- and Bug-type Pokémon."
		CalculateCR(var/mob/Pokemon/P)
			if(P.Type1 == "Water" || P.Type1 == "Bug" || P.Type2 == "Water" || P.Type2 == "Bug")
				return 3
			else return 1
	Luxury_Ball
		icon_state = "Luxury Ball"
		ricon_state = "Luxury Ball"
		CR = 1
		Description = "A ball used to spoil a Pokemon, raising the Pokemons happines overall.."
	Level_Ball

	Night_Ball

	Lure_Ball

	Friend_Ball

	Love_Ball

	Fast_Ball

	Heavy_Ball
		icon_state = "Heavy Ball"
		ricon_state = "Heavy Ball"
		CR = 1
		Description = "Made from an apricorn, this ball has a higher chance of catching heavier Pokemon.."
		CalculateCR(var/mob/Pokemon/P)
			if(P.Weight < 220.6) return -20
			else if(P.Weight > 220.6 && P.Weight <441) return 0
			else if(P.Weight > 441 && P.Weight < 677.3) return 20
			else if(P.Weight > 677.3 && P.Weight < 903) return 30
			else if(P.Weight > 1000) return 40



	Nest_Ball
		icon_state = "Nest Ball"
		ricon_state = "Nest Ball"
		CR = 1
		Description = "A somewhat different Ball that works especially well on weaker Pokémon."
		CalculateCR(var/mob/Pokemon/P)
			if((40 - P.Level) / 10 >= 1)
				return 2
			else return 1
	Master_Ball
		CR = 255
		Description = "The best ball that catches a Pokémon without fail."
		CalculateCR()
			return "Masterball"
	ItemUse(var/mob/Pokemon/P)
		var/mob/Player/M = usr
		if(isPokemon(P) && isPlayer(M))
			if(world.timeofday < M.PokeballThrow) M.PokeballThrow = 0
			if(world.timeofday - M.PokeballThrow < 80) return
			M.PokeballThrow = world.timeofday
			var/BOX/CB = M.Find_Box()
			var/PartyOpenSlot = M.AddPKMNParty()
			var/BOXOpenSlot = CB.IsRoom()

			if(!PartyOpenSlot && !BOXOpenSlot)
				usr<<System("Your current BOX in the Pokemon Storage System is full.")
				return
			if(M != P.Finder && P.OriginalTrainer != "Catchable")
				usr<<System("You did not find this Pokemon, you do not have the right to catch it.")
				return

			if(get_dist(M,P) > 9 && !M.Court) return //You must be within 9 tiles to use a pokeball on a Pokemon
			var/obj/Balls/B = M.ItemUsing //The pokeball you will be using should be your ItemUsing.

			if(B.Pokemon) return //Does this pokeball arleady have a Pokemon in it? No, you cannot use used pokeballs

			var/obj/Balls/NewB = new B.type //Creates the new Ball for The Pokemon to use if its captured.
			//B.loc = P.loc
			B.Subtract(M,1) //Has to go after the new ball has been declared.

			NewB.verbs -= /obj/NoVerb/verb/Drop //Takes away the verbs, you won't be able to drop them.
			NewB.verbs -= /obj/NoVerb/verb/Take

			var/obj/FakeBall = new

			FakeBall.icon = 'Pokeballs.dmi'
			FakeBall.icon_state = "throw [NewB.icon_state]"

			spawn() M.UpdateItems()
			if(M.Watcher)
				missile(FakeBall,M.Watcher,P)
				sleep(get_dist(M.Watcher,P))
			else
				missile(FakeBall,M,P)
				sleep(get_dist(M,P)) //Sleep the distance between the Pokemon and the Mob using the Pokeball


			if(P.Dummy || P.PokeballsThrown >= 6 || P.HP == P.MHP)
				return
			P.PokeballsThrown += 1
			flick("Send",P) //It goes into the pokeball.
			NewB.loc = P.loc

			var/TARGET = P.Target
			P.loc = null
			P.InBall = 1
			P.Target = null
			var/L = P.MHP
			var/H = P.HP
			var/C = P.CaptureRate
			var/BR = NewB.CalculateCR(P)
			var/S = P.ReturnStatus()
			if(P.HP <= 0) H = P.MHP/3

			var/X = (((3 * L - 2 * H) * (C * BR)) / (3 * L)) * S
			var/Captured = 1
			var/Y = 1048560 / sqrt((sqrt((16711680 / X))))
			for(var/i=1, i < 5,i++)
				var/r = rand(0,65535)
				NewB.icon_state = "shake [NewB.ricon_state]"
				flick("shake [NewB.ricon_state]",NewB)
				if(X >= 255)
					if(prob(25))
						i = 5

				if(r > Y && X < 255)
					Captured = 0
					i = 5
				sleep(20)

			if(BR == "Masterball") Captured = 1 //Masterball ALWAYS works.
			//Make sure the owner is still here, and then check if the Pokeball actually caught the Pokemon.
			if(Captured && M)

			//This is the part that regularly checked if the Pokebox had enough room and stuff!!!
				M<<sound('Caught Pokemon.mid',0,0,3)
				spawn(35) M<<sound(null,0,0,3)
				M.PortraitCheck()
				if(PartyOpenSlot)
					M.Party[PartyOpenSlot] = P
					M.UpdateParty()
				else
					CB.AddPokemon(P, M)
					M<<System("[M] is being sent to the Pokemon Storage System")
				P.Ball = NewB
				P.Target = null
				NewB.loc = null
				NewB.icon_state = NewB.ricon_state
				NewB.Pokemon = P
				P.loc = null
				P.Owner = M.ckey
				P.OriginalTrainer = M.ckey //This will never change..

				if(M.FightingPokemon == P) M.FightingPokemon = null
				if(!M) return
				P.name = html_encode(input(M,"Would you like to give [P] a nickname?","Nickname",P.name) as text)
				if(!M.CaughtPokemon.Find(initial(P.name))) M.GiveDexInfo(P.Number, 100)
				else
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
				if(!M) return
				if(!name) P.name = initial(P.name)
				NewB.name = html_encode(P.name)
				M.Title_Check()




				return
			else
				flick("Send",P)
				usr<<System("[pick("Darn! So close!","The Pokemon was not captured..","One more try!")]")
				P.InBall = 0
				P.loc = NewB.loc
				P.Target = TARGET
				if(!P.Target) P.Target = M
				del NewB //If the pokemon has been released
	Click()
		if(istype(usr,/mob/Player))
			var/mob/Player/M = usr
			var/mob/Pokemon/P = src.Pokemon
			M.QuestCheck("Check Choose Pokeball")
			if(!Pokemon)
				if(loc != M) return //Make sure the ball is in their inventory.
				if(M.ItemUsing != src)
					var/icon/I = new(icon, icon_state)
					if(M.client) M.client.mouse_pointer_icon = I
					M.ItemUsing = src

				else
					if(M.client) M.client.mouse_pointer_icon = null
					M.ItemUsing = null
				M.UpdateItems()
				return


			//IF this ball is not open, (which it shouldn't be if your switching TOO this pokemon).
			if(P)
				if(M.ItemUsing == src)
					if(M.client) M.client.mouse_pointer_icon = null
					M.ItemUsing = null
					M.UpdateParty()
				if(M.QuestCheck("Send Out Check", P)) return
				else if(!M.ControlingPokemon)
					if(M.Watcher && !M.Court) return
					if(P.HP<= 0)
						M<<System("[P] has no HP!")
						return
					if(P == M.Trading)
						return
					if(P.NoSend)
						var/effected
						var/fighting
						for(var/mob/Pokemon/PPP in M.Party)
							if(PPP.NoSend) effected += 1
							if(PPP.HP >= 1) fighting += 1
						if(fighting > effected) if(world.realtime <= P.NoSend) return
					var/icon/I = new(P.Ball.icon, P.Ball.icon_state)
					if(M.client) M.client.mouse_pointer_icon = I
					M.ItemUsing = src
					M.<<System("Now click where to send out [P]")
					M.UpdateParty()
					return
				else if(M.ControlingPokemon == P)
					if(M.Court)
						if(world.timeofday - M.Timers["SendOut"] < 160) return
					var/area/Routes/R = loc
					if(istype(R)) if(R.Team1 || R.Team2)
						M<<System("Pokemon cannot be returned during a Team Battle.")
						return //You can't return a Pokemon during a battle. You must battle until it dies, and at that time you send out another.
					P.ReturntoBall(0)
					return

area/proc
	ReleaseCheck()
		if(ReleaseCheck) return 1
		else return 0
turf/
	Click()
		..()
		if(istype(usr,/mob/Player))
			var/mob/Player/M = usr
			if(M.ControlingPokemon) return //If your already controling a Pokemon, and you try to send out out again, it will pop around the map.
			if(istype(M.ItemUsing,/obj/Balls)) //If its a Pokemon you're trying to send out, it will be its Pokeball.
				var/obj/Balls/B = M.ItemUsing
				if(!B.Pokemon) return //Does that Pokeball have a Pokemon in it?
				if(density) return
				for(var/atom/movable/T in src)
					if(T.density) return
				var/mob/Pokemon/P = B.Pokemon

				//Checks
				var/area/A = loc
				if(M.Court)
					if(M.Court.Battle_Sendout_Check(P,M)) return
					M.Court.Battle_Add_Pokemon(P,M)

				if(!A.ReleaseCheck(P))
					M<<System("This area prohibits you from sending out Pokemon.")
					return
				for(var/mob/Pokemon/Pp in view(src,2))
					if(Pp.Owner) return




				M<<"<font color = blue>[M]</font>: Go [P.name]!"

				var/obj/FAKE = new
				FAKE.icon = 'Pokeballs.dmi'
				FAKE.icon_state = "throw [B.icon_state]"
				var/mob/H = M
				if(M.Watcher) H = M.Watcher
				missile(FAKE, H, src)
				sleep(max(0,get_dist(H,src)-1))
				P.loc = src
				P.dir = 2
				flick("Send",P)
				P.flick_overlay('Poke Seals.dmi',"[P.Ball.Seal]")
				if(P.Ability == null) P.Ability = pick(P.Abilities)
				M.ControlingPokemon = P
				spawn() M.UpdateParty(1)
				for(var/mob/Watcher/W in view(src,20))
					var/mob/m = GetOwner(W.Owner)
					m<<P.Cry
				M.QuestCheck("Check Sendout Pokemon", P)
				AbilityCheck(P, "Enter Battle")
				if(M.Court)
					M.Timers["SendOut"] = world.timeofday
					flick("[B.icon_state] Timer",B)
				var/area/Routes/R = loc
				if(istype(R)) if(R.Team1 || R.Team2)
					M.client.eye = M.ControlingPokemon
					M.client.perspective = EYE_PERSPECTIVE

				if(M.client) M.client.mouse_pointer_icon = null
				M.ItemUsing = null // This goes before so the Blue goes away!


				//M.FollowControling()
				return


//ItemBall
/obj/OverworldItems/
	invisibility = 90
	icon = 'Items.dmi'
	icon_state = "ItemBall"
	var/obj/Given //This is the item given.
	var/GivenAmount = 1
	Click()
		if(get_dist(usr,src) > 1) return
		if(!isPlayer(usr) && usr.client) return
		if(!Given) return

		var/mob/Player/M = usr
		if(M.ItemsFound.Find(CoordsToNum(x,y,z))) return
		for(var/image/I in M.SavedImages) if(I.OBJ == src) del I
		M.ItemsFound += CoordsToNum(x,y,z)
		if(winget(M, "SOUNDS ON", "is-checked") == "true") M<<'GetItem.mid'
		var/obj/O = new Given
		O.Amount = GivenAmount
		M<<System("You found a [O]!..")
		O.take(M)