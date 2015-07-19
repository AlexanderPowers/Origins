var/list/TypesColours = list("Normal" = "#A8A878","Fire" ="#F08030","Electric"="#F8D030","Water"="#6890F0","Ice"="#98D8D8","Rock"="#B8A038","Ground"="#E0C068","Flying"="#A890F0","Bug"="#A8B820","Grass"="#78C850","Psychic"="#F85888","Fighting"="#C03028","Steel"="#B8B8D0","Poison"="#A040A0","Ghost"="#705898","Dark"="#705848","Dragon"="#7038F8")


mob/Pokemon
	New()
		RICON = icon
		if(!name) name = initial(name)
		..()
	var/
		RICON
		CaptureRate = 45
		list/Evolve = list()
		Unevolve = null
		Pixel_y

		Type1
		Type2

		Owner //ckey based.
		OriginalTrainer //ckey based
		ID
		obj/Balls/Ball
		Dummy // For the pokemon that just sit there, and are not able to be attacked or captured?
		tmp/PokeballsThrown //For the number of balls the pokemon can be hit by. It currently is 6. Once this happens, the pokemon is uncatchable.

		tmp/obj/HUD/Meter/Meter

		//Leveling Vars
		Level
		GrowthRate
		Exp
		MExp
		NonTradable

		//Pokedex Variables
		Number //NationalPoxedexNumber
		Height
		Weight //Weight(lbs // Imperial) - rand(Weigth - 10,Weight + 10)
		list/EggGroups = list()
		list/EggMoves = list()
		Species
		DexColor
		InBall = 0

		//Stats
		Ability
		list/Abilities = list()
		list/HiddenAbility = list()

		//Stats
		sound/Cry
		Happiness = 70
		tmp/Finder
		tmp/TEMPSpeed = 0
		tmp/list/TempStats = list("HP" = 0, "ATK" = 0, "DEF" = 0, "SPL ATK" = 0, "SPL DEF" = 0, "SPD" = 0)
		list/BaseStats = list("HP" = 45, "ATK" = 49, "DEF" = 49, "SPL ATK" = 69, "SPL DEF" = 69, "SPD" = 45)
		list/StatExp = list("HP" = 10, "ATK" = 10, "DEF" = 10, "SPL ATK" = 10, "SPL DEF" = 10, "SPD" = 10)
		list/Stats = list("HP" = 0, "ATK" = 0, "DEF" = 0, "SPL ATK" = 0, "SPL DEF" = 0, "SPD" = 0)
		list/IndividualValue = list("HP" = 0, "ATK" = 0, "DEF" = 0, "SPL ATK" = 0, "SPL DEF" = 0, "SPD" = 0)
		tmp/Status
		tmp/mob/StatusKiller
		Gender //Male Ratio

		tmp/list/SecondaryStatus = list()
		list/SecondaryEffect = list() //Same as Status, but these get reset at return to ball.
		obj/HeldItems/HeldItem = null
		POKEIMAGE

		//Attack Vars
		tmp
		list/LearnMoves = list()
		tmp/atom/StepAway
		tmp/mob/Pokemon/Lock_On
		list/Moves = list()
		tmp/list/Attackers = list()
		list/NoMoves = list()
		ExtraMemory = 0 //Pokemon will have the ability to learn more than 6 moves, this is for those extra attacks.
		tmp/mob/LockOn
		tmp/Surfing = 0
		tmp/NoSend = 0 //For attacks like Roar and Whirlwind
		tmp/NoReturn = 0 //For attacks like ScaryFace

		tmp/mob/Target = null // This is whatever the pokemon is attacking.
		tmp/obj/Moves/UsingAttack
		tmp/obj/Moves/LastAttack
		ob
		//OTHER?
		SurfPixelY



	ClothingOverlays = list("Status")


	Click()
		var/mob/Player/M = usr
		if(M.Timers["Freezing"])
			if(frozen)
				frozen = 0
				M<<System("[src] is no longer frozen")
			else
				frozen = 1
				M<<System("[src] is  frozen")
		if(istype(usr,/mob/Player))
			M = usr
		if(!M) return
		if(M.MasterGMCheck())
			if(M.Timers["Leveling"])
				Exp = MExp
				StaffLog += "<BR>[usr] levled [src] to level [src.Level + 1] belonging to [GetOwner(Owner)]"
				Level_Check()
				return
		if(Owner && !M.ItemUsing)
			PokemonInformation(usr)
		else
			if(M.ItemUsing)

				M.ItemUsing.ItemUse(src)








	Move()
		if(!istype(loc,/turf/Routes/Water)) if(icon_state == "Swim" || icon_state == "Fly") icon_state = null


		if(HP <= 0|| icon_state == "Faint" || icon_state == "Jolt" || icon_state == "Harden" || icon_state == "Withdraw" || icon_state == "Sleep" || icon_state == "Gust" || SecondaryStatus["ViceGrip"] || SecondaryStatus["Wrap"]) return 0
		if(Speeding == 0)
			Speeding = 1
			..()
			if(!NoRunDelay)
				sleep(GetSpeed())

			Speeding = 0
	Bump(D)
		if(istype(src.UsingAttack,/obj/Moves/Rollout)) //Rollout
			if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
				var/mob/m = D
				SecondaryEffect["Rollout"] += 1
				var/obj/Moves/Rollout/M = new
				if(SecondaryEffect["Rollout"]) M.Power *= SecondaryEffect["Rollout"]
				if(SecondaryEffect["Defense Curl"]) M.Power *= 2
				if(prob(90)) m.HP = max(0,m.HP - BattleDamage(m,M))
				Pushback(null, 4, src.dir)
				m.DeathCheck(src)
				del M

			else SecondaryEffect["Rollout"] = 0 //They hit something that was not a Pokemon or Player, set the Rolloutcounter to 0


			UsingAttack = null
			if(icon_state == "Rollout") icon_state = null


		if(istype(D,/atom/movable))
			var/obj/T = D
			T.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(istype(D,/mob/Pokemon))
				var/mob/Pokemon/PP = D //You must check both, because they technically both touched.
				AbilityCheck(src, "Contact", PP)
				AbilityCheck(PP, "Contact", src)

			var/mob/M = D
			if(istype(src.UsingAttack,/obj/Moves/Aerial_Ace)) //Aerial Ace
				loc = M.loc
			if(istype(src.UsingAttack,/obj/Moves/Flame_Wheel)) //Flame Wheel
				Rolling = 0
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Stomp))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				UsingAttack.Hit += M
				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(null,1,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Horn_Attack))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				UsingAttack.Hit += M
				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(null,1,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Headbutt))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack)) //Headbutt

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,3,src.dir)
				M.flick_overlay('Moves.dmi', "Headbutt")
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Take_Down))
				var/Damage = BattleDamage(M,src.UsingAttack)
				M.HP = max(0,M.HP - Damage) //Headbutt
				HP = max(0,HP - (Damage * 0.25))

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,3,src.dir)
				M.DeathCheck(src)
				DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Double_Edge))
				var/Damage = BattleDamage(M,src.UsingAttack)
				M.HP = max(0,M.HP - Damage) //Headbutt
				HP = max(0,HP - (Damage * 0.25))

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,3,src.dir)
				M.DeathCheck(src)
				DeathCheck(src)
				UsingAttack = null

			if(istype(src.UsingAttack,/obj/Moves/Tackle))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack)) //Tackle

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,0,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Slam))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack)) //Slam

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,5,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Body_Slam))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack)) //Tackle

				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,2,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Quick_Attack)) //Quick Attack
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,1,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Spark))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,1,src.dir)
				M.DeathCheck(src)
				UsingAttack = null
			if(istype(src.UsingAttack,/obj/Moves/Extremespeed))
				M.HP = max(0,M.HP - BattleDamage(M,src.UsingAttack))
				if(istype(D,/mob/Pokemon))
					var/mob/Pokemon/P = D
					P.Pushback(src,1,src.dir)
				M.DeathCheck(src)
				UsingAttack = null


	proc
		Create(var/LVL, var/Abil)
			ID = "[rand(1,5000)][rand(5000,10000)][rand(600,3000)][rand(1,5000)][rand(5000,10000)][rand(600,3000)]"

			RICON = icon
			if(isnum(Gender))
				if(prob(Gender))
					Gender = "Male"
				else
					Gender = "Female"
			//Level
			Level = LVL //What level are they?..
			FindExp(Level) //Find their Max EXP, depending on their level.
			//Exp += rand(MExp-Exp, MExp)


			//Stats
			for(var/i in IndividualValue)
				if(!IndividualValue[i]) IndividualValue[i] = rand(1,15)
				StatPoint(i)
			HP = MHP

			if(!Abil) Ability = pick(Abilities)
			else Ability = Abil

			Abilities = list() //To save...space and...stuff.

			//Meter Stuff
			AddMeter()

			//Moves
			AddMove()


		StatPoint(var/Stat) //This assign the Pokemons Stat for ONE Stat. Must be set at each level.
			var/B = BaseStats[Stat]// Pokemon's Base Stat
			var/D = IndividualValue[Stat]// Determined Value or Individual Value
			var/L = Level //Level
			var/S = round((sqrt((StatExp[Stat] - 1) - 1) + 1) / 4)
			var/X = 5
			var/tmpMHP =MHP
			if(Stat == "HP") X = L + 10
			Stats[Stat] = round((((2 * B) + (2 * D) + S) * L) / 100) + X
			MHP = Stats["HP"]
			if(HP > 0) HP += (MHP - tmpMHP)
			if(Stat == "SPD") Stats[Stat] = B

		AddMove(var/Move, var/Auto_Learn = 0)
			var/mob/Player/P = GetOwner(Owner) //Finds the owner of the Pokemon to ask the questions..No free will for the Pokemon.
			for(var/O in LearnMoves) //What can it learn?
				if(!ispath(O)) continue //Is it a path?
				var/In = 0
				if(findtext("[O]","HMs")) //HMS
					var/obj/HMs/H = new O(null)
					if(HM)
						if(NoMoves.Find(HM.type)) return
						NoMoves += O
						//If theres already an HM, do we want to replace it?
						if(!DaycareLady && alert(P,"[src] already knows [HM]. Forget it?",,"Yes","No") == "Yes")
							del HM
							HM = H
						else del H //IF there is a daycare lady, it will always take the new one.
					else
						HM = H
					LearnMoves -= O


				else //OTHER... so TMs
					var/obj/Moves/M = new O(null)
					if(LearnMoves[O] <= Level || LearnMoves[O] == 1)
						for(var/obj/Moves/H in Moves)

							if(H.type == M.type && O != /obj/Moves/Sketch )
								In = 1
							//What this just did is look for the move and see if you alread have it.
							//If you don't, then it sets In to 0, which allows you to continue. If not it stops the proc.
						if(NoMoves.Find(O) && O != /obj/Moves/Sketch) In = 1
							//Or if it can find it in the moves you've already had the oppurtunity to learn.
							//We have this for pokemon Like Sandslash.
							//Level 19 as Sandshrew it can learn Rollout. Lets say you don't learn it, and evolve it at
							//Level 22. It will then be able to learn Rollout again, which is glitchy..

						if(P) P.PokedexUnlock("Moves")
						if(!In)
							if(O != /obj/Moves/Sketch) NoMoves += O //We've had the chance to learn this move.. Unless its Sketch, as you can learn it multiple times.
							if(Moves.len >= 6 + ExtraMemory) //It checks to make sure there is room to add another move, if not we have to delete one.

								if(P && !DaycareLady) //If the Player can make the choice, and if its not int he Daycare.
									if(Auto_Learn)
										if(P && P.client) del input(P,"Forget which move?") in Moves
										if(O != /obj/Moves/Sketch) LearnMoves -= O
										else
											var/LL = LearnMoves[O]
											LearnMoves[O] = LL + 11
										Moves += M
										M.Owner = src

									if(alert(P,"[src] already knows [6 + ExtraMemory] moves, forget one to learn [M]",,"Yes","No") == "Yes")
										if(P && P.client) del input(P,"Forget which move?") in Moves
										if(O != /obj/Moves/Sketch) LearnMoves -= O
										else
											var/LL = LearnMoves[O]
											LearnMoves[O] = LL + 11
										Moves += M
										M.Owner = src

									else

										if(O != /obj/Moves/Sketch) LearnMoves -= O
										else
											var/LL = LearnMoves[O]
											LearnMoves[O] = LL + 11
										continue
								else
									del pick(Moves)
									Moves += M
									M.Owner = src
									if(O != /obj/Moves/Sketch) LearnMoves -= O
									else
										var/LL = LearnMoves[O]
										LearnMoves[O] = LL + 11
							else
								Moves += M
								M.Owner = src
								if(O != /obj/Moves/Sketch) LearnMoves -= O
								else
									var/LL = LearnMoves[O]
									LearnMoves[O] = LL + 11

						else del M

					else del M
				if(P)
					P.UpdateParty()



		FindTarget(var/distance = 10)
			var/
			mob/Pokemon/TGT
			var/list/K = oview(src,20)
			if(Target)
				if(Target.HP <= 0 || !Target.loc || Target == src || get_dist(Target, src) >= 8)
					Target = null
			else
				if(!src.loc) return
				var/area/A = loc.loc

				for(var/mob/Pokemon/P in A)
					var/mob/Player/O1 = GetOwner(Owner)
					var/mob/Player/O2 = GetOwner(P.Owner)
					if(!K.Find(P) || P == src || P.HP <= 0) continue
					if(O1.Court) if(O2.Find_Team() == O1.Find_Team()) continue
					if(!TGT) TGT = P
					else if(get_dist(src,TGT) > get_dist(src,P))

						TGT = P
				Target = TGT
		FindTarget2()
			var/
			mob/Pokemon/TGT
			//var/list/K = oview(src,20)
			var/area/A = loc.loc

			for(var/mob/Pokemon/P in A)
				TGT = P
			Target = TGT
		ReturntoBall(var/sp = 20, var/Invisible)
			if(NoReturn)
				if(HP >= 1) if(world.realtime <= NoReturn) return
			var/mob/Player/O = GetOwner(src.Owner)
			spawn(sp)
				if(!O && Ball) return
				if(!Invisible) O<<"<font color = blue>[O]</font>: [name], Return!"
				flick("Send",src)
				var/mob/H = O
				if(O.Watcher) H = O.Watcher
				if(!Invisible) missile(image('Pokeballs.dmi',"throw [src.Ball.ricon_state]"), src, H)
				pixel_x = initial(pixel_x)
				pixel_y = initial(pixel_y)
			//	sd_SetLuminosity(0)
				loc = null
			SecondaryEffect = list()
			SecondaryStatus = new/list()
			if(Surfing)
				if(O.client) O.client.eye = O
				if(O.invisibility) O.invisibility = 0
				Surfing = 0

			overlays -= overlays
			underlays -= underlays
			if(Status == "Poison") AddSection("Status","Poisoned")
			density = 1
			icon = RICON
			if(TemporaryMoves["RICON"]) icon = TemporaryMoves["RICON"]
			if(!istype(src.Ball,/obj/Balls/Egg)) src.Ball.icon = 'Pokeballs.dmi'
			src.Ball.icon_state = src.Ball.ricon_state
			if(icon_state == "Swim") icon_state = null
			frozen = 0

			if(isPlayer(O))
				if(O.client) if(O.client.eye == O.ControlingPokemon) //The Player is watching the Pokemon, and their view must return to the player.
					O.client.eye = O
					O.client.perspective = EYE_PERSPECTIVE
				O.ControlingPokemon = null
				O.UpdateParty(1)
				winset(O, "PokemonInformation", "is-visible=false")

			return
		GetSpeed()
			if(TEMPSpeed) return TEMPSpeed
			var/Speed = max(min(BaseStats["SPD"] * TempStatReturn(TempStats["SPD"]), 999),-999)
			if(Status == "Paralysis")
				Speed = round(Speed/4)
			if(SecondaryStatus["Confused"])
				if(prob(18)) return 5
			if(IsBetween(Speed, 171, 999)) return 0
			if(IsBetween(Speed, 101, 170)) return 1
			if(IsBetween(Speed, 66, 100)) return 2
			if(IsBetween(Speed, 45, 65)) return 3
			if(IsBetween(Speed, 0, 45)) return 4
			else return 2
		BattleDamage(var/mob/DEF, var/obj/Moves/Attack)
			var/area/Area = loc.loc
			//Decide if they even will do damage
			//Start by seeing which area they are in
			if(istype(Area, /area/Routes)) //They could be in a route, therefore a Team Battle might be happening
				var/area/Routes/R = Area
				if(!R.Team1 || !R.Team2) //There is no Team Battle.
					if(isPlayer(DEF)) return 0 //This is so no damage is done to players
					if(isPokemon(DEF))
						var/mob/Pokemon/Poke = DEF
						if(Poke.Owner && Owner) //Owned Pokemon cannot attack eachother in routes normally.
							return 0


			var/L = max(1, src.Level) // L = Level
			var/A = max(1, src.Stats["ATK"]) // A = Attackers Attack
			var/P = max(1, Attack.Power) //P = The power of the attack
			var/D
			var/X = ((217 + rand(0,38)) / 255) //X = Random
			var/DoubledHalved = 1
			var/mob/Player/O1 = GetOwner(Owner)
			var/mob/Player/O2
			//Readded STAB as a test//

			if(Type1 == Attack.Type)
				P *= 1.5
			if(Type2 == Attack.Type)
				P *= 1.5
			if(istype(DEF,/mob/Pokemon)) // Is the target a Pokemon?
				var/mob/Pokemon/Defender = DEF
				if(Defender.SecondaryStatus["Protect"]) P = 0
				if(src == DEF && Attack.type) return 0
				if(Defender.Dummy) return
				if(Defender.icon_state == "Fainted") return 0
				D = max(1, Defender.Stats["DEF"]) //D = Defenders Defense
				if(TempStats["ATK"])A =  max(min(Stats["ATK"] * TempStatReturn(TempStats["ATK"]), 999),-999)
				if(Defender.TempStats["DEF"]) D = max(min(Defender.Stats["DEF"] * TempStatReturn(Defender.TempStats["DEF"]), 999),-999)
				/*if(Attack.Type == "Water" || Attack.Type == "Grass" ||Attack.Type == "Fire" ||Attack.Type == "Ice" ||Attack.Type == "Electric" ||Attack.Type == "Psychic" ||Attack.Type == "Dragon" ||Attack.Type == "Dark"||Attack.Type == "Ghost")
					A = src.Stats["SPL ATK"]
					D = Defender.Stats["SPL DEF"]
					if(TempStats["SPL ATK"]) A = Stats["SPL ATK"] * TempStatReturn(TempStats["SPL ATK"])
					if(Defender.TempStats["SPL DEF"]) D = Stats["SPL DEF"] * TempStatReturn(TempStats["SPL DEF"])*/
				if(Attack.Range == "Special")
					A = src.Stats["SPL ATK"]
					D = Defender.Stats["SPL DEF"]
					if(TempStats["SPL ATK"]) A = Stats["SPL ATK"] * TempStatReturn(TempStats["SPL ATK"])
					if(Defender.TempStats["SPL DEF"]) D = Stats["SPL DEF"] * TempStatReturn(TempStats["SPL DEF"])
				if(prob(Attack.CriticalHit))
					if(Attack.Type)
						L *= 2 //If its a critical Hit, we are required to double level
						X = ((217 + rand(0,38)) / 255)
				DoubledHalved = TypeDifference(Attack.Type, Defender.Type1, Defender.Type2)
				if(TemporaryMoves["Type1"]) DoubledHalved = TypeDifference(Attack.Type, TemporaryMoves["Type1"], TemporaryMoves["Type2"])

				if(DoubledHalved == -2)DoubledHalved = 0.5
				if(DoubledHalved == -4)DoubledHalved = 0.25
			if(istype(DEF,/mob/Player))
				O2 = DEF
				if(!O1 || !O2) return 0
				if(O1.Court != O2.Court || !O1.Court  || !O2.Court)
					return 0 //When you find a solution to Stamina, put it in. This is a FIX

				D = 30
			if(!L || !A || !P || !D || !X)
				return 0
			//Abilities//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			var/AbilityPowerIncrease = AbilityCheck(Ability, "Attack Power Increase", src, Attack)
			if(AbilityPowerIncrease) P *= AbilityPowerIncrease


			//Hold Item
			if(HeldItem && istype(HeldItem, /obj/HeldItems))
				if(HeldItem.Held_Effect(src, "BattleDamage", Attack.Type))
					P += P * 0.2 //They are using a Type Enhance Held Item, Attack power plus 20%
			//Weather Effects
			if(Area)
				if(Area.WeatherID == "Rain Dance") //It is raining
					if(Attack.Type == "Fire") P /= 1.5 //Decreases Fire Types
					if(Attack.Type == "Water") P *= 1.5 //Increases Water Types
				if(Area.WeatherID == "Sunny Day") //It is raining
					if(Attack.Type == "Water") P /= 1.5 //Decreases Water Types
					if(Attack.Type == "Fire") P *= 1.5 //Increases Fire Types
				/*if(Area.sd_darkicon == 'Sandstorm.dmi')
					for(var/mob/Pokemon/Z in Area)
						if(Z.Type1 == "Ground" ||Z.Type1 == "Steel" ||Z.Type1 == "Rock" || Z.Type2 == "Ground" ||Z.Type2 == "Steel" ||Z.Type2 == "Rock")
							return
						else
							var/mob/Pokemon/owner
							var/Damage = Z.MHP / 8
							Z.HP = max(0, Z.HP - Damage)
							Z.DamageOverlay(Damage)
							Z.DeathCheck(owner)*/
			var/damage = round((min(round(round(((2 + round(0.4 * L)) * A * P) / D) / 50) , 997) + 2) * X)
			damage *= DoubledHalved

			//Increases Decreases
			//Rollout?
			if(DEF.icon_state == "Withdraw" || DEF.icon_state == "Harden") if(DoubledHalved == 1) damage /= 2
			//Protect

			DEF.DamageOverlay(damage)
			return damage
		TypeDifference(var/Attack, var/Defend1, var/Defend2)
			var/Jolt
			switch(Attack)
				if("Normal")
					if(Defend1  == "Rock" || Defend1  == "Steel"|| Defend2 == "Rock" || Defend2  == "Steel") Jolt -= 2
					if(Defend1  == "Ghost" || Defend2 == "Ghost") return 0
				if("Fire")
					if(Defend1 == "Fire" || Defend1 == "Water" ||Defend1 ==  "Rock" || Defend1 == "Dragon" || Defend2 == "Fire" || Defend2 == "Water" || Defend2 == "Rock" || Defend2 == "Dragon") Jolt -= 2
					if(Defend1 == "Grass" || Defend1 == "Ice" || Defend1 == "Bug" || Defend1 == "Steel"|| Defend2 == "Grass" || Defend2 == "Ice" || Defend2 == "Bug" ||Defend2 == "Steel") Jolt += 2
				if("Water")
					if(Defend1 == "Grass" || Defend1 =="Water" || Defend1 =="Dragon"|| Defend2 == "Grass" || Defend2 == "Water" ||  Defend2 == "Dragon") Jolt -= 2
					if(Defend1 == "Fire" || Defend1 =="Ground" || Defend1 =="Rock"|| Defend2 == "Fire" || Defend2 == "Ground" || Defend2 == "Rock") Jolt += 2
				if("Electric")
					if(Defend2 == "Electric" || Defend2 =="Grass" || Defend2 =="Dragon" ||Defend1 =="Electric" || Defend1 =="Grass" || Defend1 =="Dragon") Jolt -= 2
					if(Defend1  == "Ground"|| Defend2 == "Ground") return 0
					if(Defend2 == "Water" ||Defend2 == "Flying" ||Defend2 == "Rock" ||Defend1 ==  "Water" || Defend1 == "Flying" || Defend1 == "Rock") Jolt += 2
				if("Grass")
					if(Defend2 == "Fire" || Defend2 == "Grass" ||Defend2 ==  "Poison" || Defend2 == "Flying" ||Defend1 ==  "Fire" ||Defend1 ==  "Grass" || Defend1 == "Poison" ||Defend1 ==  "Flying") Jolt -= 2
					if(Defend2 == "Water" || Defend2 == "Ground" || Defend2 == "Rock" || Defend1 =="Water" || Defend1 =="Ground" || Defend1 =="Rock") Jolt += 2
				if("Ice")
					if(Defend2 == "Fire" || Defend2 == "Ice" || Defend2 == "Water" || Defend2 == "Steel" || Defend1 =="Fire" || Defend1 =="Ice" || Defend1 =="Water" || Defend1 =="Steel") Jolt -= 2
					if(Defend2 == "Grass" || Defend2 == "Ground" || Defend2 == "Flying" || Defend2 == "Dragon" || Defend1 == "Grass" || Defend1 == "Ground" || Defend1 == "Flying" || Defend1 == "Dragon") Jolt += 2
				if("Fighting")
					if(Defend2 == "Poison" || Defend2 == "Flying" || Defend2 == "Psychic" || Defend2 == "Bug" || Defend1 == "Poison" || Defend1 == "Flying" || Defend1 == "Psychic" || Defend1 == "Bug") Jolt -= 2
					if(Defend2 == "Normal" || Defend2 =="Ice" || Defend2 =="Rock" ||Defend2 == "Dark" || Defend2 =="Steel" || Defend1 == "Normal" || Defend1 == "Ice" || Defend1 == "Rock" || Defend1 == "Dark" || Defend1 == "Steel") Jolt += 2
					if(Defend1  == "Ghost"|| Defend2 == "Ghost") return 0
				if("Poison")
					if(Defend2 == "Poison" || Defend2 == "Ground" || Defend2 == "Rock" || Defend2 == "Ghost" || Defend1 =="Poison" || Defend1 =="Ground" || Defend1 =="Rock" || Defend1 =="Ghost") Jolt -= 2
					if(Defend2 == "Grass" || Defend2 =="Ice" || Defend2 =="Rock" || Defend2 =="Dark" || Defend2 =="Steel"|| Defend1 =="Grass" || Defend1 =="Ice" || Defend1 =="Rock" || Defend1 =="Dark" || Defend1 =="Steel") Jolt += 2
					if(Defend1  == "Steel"|| Defend2 == "Steel") return 0
				if("Ground")
					if(Defend2 == "Grass" ||Defend2 ==  "Bug" || Defend1 == "Grass" || Defend1 == "Bug") Jolt -= 2
					if(Defend2 == "Fire" ||Defend2 ==  "Electric" || Defend2 == "Poison" ||Defend2 ==  "Rock" || Defend2 == "Steel" || Defend1 == "Fire" || Defend1 ==  "Electric" || Defend1 ==  "Poison" || Defend1 ==  "Rock" || Defend1 ==  "Steel") Jolt += 2
					if(Defend1 == "Flying" || Defend2 == "Flying") return 0
				if("Flying")
					if(Defend2 == "Electric" || Defend2 == "Rock" || Defend2 == "Steel" ||Defend1 ==  "Electric" || Defend1 == "Rock" ||Defend1 ==  "Steel") Jolt -= 2
					if(Defend2 == "Grass" || Defend2 == "Fighting" ||Defend2 ==  "Bug" || Defend1 == "Grass" || Defend1 == "Fighting" || Defend1 == "Bug") Jolt += 2
				if("Psychic")
					if(Defend1 == "Psychic" || Defend1 == "Steel" || Defend2 == "Psychic" || Defend2 == "Steel") Jolt -= 2
					if(Defend1 == "Fighting" || Defend1 == "Poison" || Defend2 == "Fighting" || Defend2 == "Poison") Jolt += 2
					if(Defend1 == "Dark" || Defend2 == "Dark") return 0
				if("Bug")
					if(Defend2 == "Fire" || Defend2 =="Ground" || Defend2 =="Fighting" || Defend2 =="Ghost" || Defend2 =="Fighting" || Defend2 =="Flying" || Defend2 =="Steel" || Defend1 =="Fire" || Defend1 =="Ground" || Defend1 =="Fighting" || Defend1 =="Ghost" || Defend1 =="Fighting" || Defend1 =="Flying" || Defend1 =="Steel") Jolt -= 2
					if(Defend2 == "Grass" || Defend2 =="Psychic" ||Defend2 == "Dark" || Defend1 == "Grass" || Defend1 =="Psychic" || Defend1 =="Dark") Jolt += 2
				if("Rock")
					if(Defend2 == "Fighting" ||Defend2 ==  "Ground" || Defend2 == "Steel" || Defend1 == "Fighting" ||Defend1 == "Ground" || Defend1 =="Steel") Jolt -= 2
					if(Defend2 == "Fire" ||  Defend2 =="Ice" ||  Defend2 =="Flying" ||  Defend2 =="Bug" || Defend1 =="Fire" || Defend1 =="Ice" || Defend1 =="Flying" || Defend1 =="Bug") Jolt += 2
				if("Ghost")
					if(Defend2 == "Dark" || Defend2 == "Steel" || Defend1 == "Dark" || Defend1 =="Steel") Jolt -= 2
					if(Defend2 == "Psychic" ||Defend2 == "Ghost" || Defend1 =="Psychic" ||Defend1 == "Ghost") Jolt += 2
					if(Defend1  == "Normal"|| Defend2 == "Normal") return 0
				if("Dragon")
					if(Defend1 == "Steel" || Defend2 == "Steel") Jolt -= 2
					if(Defend1 == "Dragon" || Defend2 == "Dragon") Jolt += 2
				if("Dark")
					if(Defend1 || Defend2 == "Steel" || "Fighting" || "Dark") Jolt -= 2
					if(Defend1 || Defend2 == "Bug" || "Ghost") Jolt += 2
				if("Steel")
					if(Defend1 || Defend2 == "Steel" || "Water" || "Fire" || "Electric") Jolt -= 2
					if(Defend1 || Defend2 == "Ice" || "Rock") Jolt += 2

			if(!Jolt) Jolt = 1
			return Jolt
		Happiness_Check(var/Amount)
			var/mob/Player/O = GetOwner(Owner)
			if(Amount > 0)
				switch(Happiness)
					if(0 to 99)
						Amount = round(Amount * 2)
					if(200 to 256)
						Amount = max(1,round(Amount - 1))

			if(istype(Ball,/obj/Balls/Luxury_Ball)) Amount += 1
			Happiness = max(0, min(256, Happiness + Amount))
			if(Happiness >= 255) //Max Happiness
				if(Evolve["Happiness"])
					Evolve("Happiness",,"Yes")

				else if(Evolve["DayHappiness"] && O.ReturnDay())
					Evolve("DayHappiness",,"Yes")

				else if(Evolve["NightHappiness"] && !O.ReturnDay())
					Evolve("NightHappiness",,"Yes")
		Level_Check()
			while(Exp >= MExp)

				var/mob/Player/O = GetOwner(Owner)
				if(O.Party.Find(src)) //If they are in the Players Party, opposed to a Daycare.
					O<<System("[src.name] gained a level")
					O<<'Level Up.mid'
					O.GiveDexInfo(Number)
				if(O)
					O.UpdateParty()

				Level += 1
				O.QuestCheck("PokemonLevel", src)
				Happiness_Check(2)
				FindExp(Level)
				AddMove()
				for(var/i in Evolve)
					if(findtext(i,"Level "))
						var/EvolveLevel = text2num(copytext(i,7))
						if(Level >= EvolveLevel)
							var/atom/movable/PP //This could be an object or a mob..
							if(Evolve["LevelPokemon"])
								var/list/AvailablePokemon = list()
								AvailablePokemon["Cancel"] = "Cancel"
								for(var/mob/Pokemon/LP in O.Party)
									if(LP.type == Evolve["LevelPokemon"]) AvailablePokemon["[LP] - [LP.Level]"] = LP
								PP = input(O,"Use a Pokemon to evolve [src]?") in AvailablePokemon
								PP = AvailablePokemon[PP]
								if(!O) return
								if(PP != "Cancel") Evolve(i,PP)
							else if(!istype(HeldItem,/obj/HeldItems/Evolution/Everstone)) Evolve(i)
				for(var/i in Stats)
					StatPoint(i)

				sleep(10)
		Evolve(var/Evo, var/atom/ATOM,var/Force)
			var/mob/Player/O = GetOwner(Owner)
			if(O.QuestCheck("Evolve Check", src)) return //This is for quests.
			var/EvolveQ
			if(DaycareLady) EvolveQ = "No"
			if(!O) EvolveQ = "Yes"
			//Should it evolve?
			if(Force) EvolveQ = Force
			spawn(200) EvolveQ = "No"
			O.PokedexUnlock("Evolution")
			while(!EvolveQ)
				EvolveQ = alert(O,"Allow [src] to evolve?",,"Yes","No")
				sleep(10)
			if(EvolveQ == "No") return
			if(icon == null) return

			if(islist(Evolve[Evo])) Evolve[Evo] = pick(Evolve[Evo]) //For Wurmple
			if(!ispath(Evolve[Evo])) return // Is what its suppose to evolve into usable?

			var/Path = Evolve[Evo]

			var/mob/Pokemon/P = new Path(loc)

			O<<"[src] evolved into [P]!"
			O.CaughtPokemon += initial(P.name)
			O.GiveDexInfo(P.Number)
			icon = null
			loc = null
			P.frozen = 1
			P.icon_state = "Blank"
			flick("Evolve",P)
			P.icon_state = null
			var/atom/DD = new type
			if(name != DD.name) P.name = src.name //Does it have a nickname?
			del DD
			P.Level = src.Level
			P.Stats = src.Stats
			P.Owner = Owner
			P.HoldingPokemonEgg = HoldingPokemonEgg
			P.Gender = Gender
			P.HeldItem = HeldItem
			P.NoMoves = NoMoves
			P.MHP = src.MHP
			P.HP = P.MHP
			P.ID = src.ID
			P.Happiness = Happiness
			P.IndividualValue = IndividualValue
			P.Exp = src.Exp
			P.NonTradable = NonTradable
			P.MExp = Exp
			P.AddMeter()
			P.Moves = Moves
			P.Stats = Stats
			P.StatExp = StatExp
			if(istype(P,/mob/Pokemon/Metapod) || istype(P,/mob/Pokemon/Kakuna))
				src.Ability = "Shed Skin"
			if(istype(P,/mob/Pokemon/Butterfree))
				src.Ability = pick("Compoundeyes","Tinted Lens")
			if(istype(P,/mob/Pokemon/Bedrill))
				src.Ability = pick("Swarm","Sniper")
			if(istype(P,/mob/Pokemon/Nidoking) && src.Ability == "Hustle")
				src.Ability = "Sheer Force"
			if(istype(P,/mob/Pokemon/Nidoqueen) && src.Ability == "Hustle")
				src.Ability = "Sheer Force"
			if(istype(P,/mob/Pokemon/Clefable) && src.Ability == "Friend Guard")
				src.Ability = "Unaware"
			if(istype(P,/mob/Pokemon/Wigglytuff) && src.Ability == "Friend Guard")
				src.Ability = "Frisk"
			if(istype(P,/mob/Pokemon/Gloom) && src.Ability == "Run Away")
				src.Ability = "Stench"
			if(istype(P,/mob/Pokemon/Vileplume) && src.Ability == "Stench")
				src.Ability = "Effect Spore"
			if(istype(P,/mob/Pokemon/Bellossom) && src.Ability == "Stench")
				src.Ability = "Healer"
			if(istype(P,/mob/Pokemon/Venomoth) && src.Ability == "Compoundeyes")
				src.Ability = "Shield Dust"
			if(istype(P,/mob/Pokemon/Venomoth) && src.Ability == "Run Away")
				src.Ability = "Wonder Skin"
			if(istype(P,/mob/Pokemon/Persian) && src.Ability == "Pickup")
				src.Ability = "Limber"
			if(istype(P,/mob/Pokemon/Politoed) && src.Ability == "Swift Swim")
				src.Ability = "Drizzle"
			if(istype(P,/mob/Pokemon/Steelix) && src.Ability == "Weak Armor")
				src.Ability = "Sheer Force"
			if(istype(P,/mob/Pokemon/Hitmonlee))
				src.Ability = pick("Limber","Reckless","Unburden")
			if(istype(P,/mob/Pokemon/Hitmonchan))
				src.Ability = pick("Keen Eye","Iron Fist","Inner Focus")
			if(istype(P,/mob/Pokemon/Hitmontop))
				src.Ability = pick("Intimidate","Technician","Steadfast")
			if(istype(P,/mob/Pokemon/Scizor) && src.Ability == "Steadfast")
				src.Ability = "Light Metal"
			if(istype(P,/mob/Pokemon/Jynx) && src.Ability == "Hydration")
				src.Ability = "Dry Skin"
			if(istype(P,/mob/Pokemon/Gyarados))
				src.Ability = pick("Intimidate","Moxie")
			if(istype(P,/mob/Pokemon/Vaporeon))
				src.Ability = pick("Water Absorb","Hydration")
			if(istype(P,/mob/Pokemon/Jolteon))
				src.Ability = pick("Volt Absorb","Quick Feet")
			if(istype(P,/mob/Pokemon/Flareon))
				src.Ability = pick("Flash Fire","Guts")
			if(istype(P,/mob/Pokemon/Espeon))
				src.Ability = pick("Synchronize","Magic Bounce")
			if(istype(P,/mob/Pokemon/Umbreon))
				src.Ability = pick("Synchronize","Inner Focus")
			if(istype(P,/mob/Pokemon/Dragonite))
				src.Ability = pick("Inner Focus","Multiscale")
			if(istype(P,/mob/Pokemon/Ledian) && src.Ability == "Rattled")
				src.Ability = "Iron Fist"
			if(istype(P,/mob/Pokemon/Granbull) && src.Ability == "Run Away")
				src.Ability = "Quick Feet"
			if(istype(P,/mob/Pokemon/Ursaring) && src.Ability == "Pickup")
				src.Ability = "Guts"
			if(istype(P,/mob/Pokemon/Ursaring) && src.Ability == "Honey Gather")
				src.Ability = "Unnerve"
			if(istype(P,/mob/Pokemon/Octillery) && src.Ability == "Hustle")
				src.Ability = "Suction Cups"
			if(istype(P,/mob/Pokemon/Pupitar))
				src.Ability = "Shed Skin"
			if(istype(P,/mob/Pokemon/Tyranitar))
				src.Ability = pick("Sand Stream","Unnerve")
			if(istype(P,/mob/Pokemon/Mightyena) && src.Ability == "Run Away")
				src.Ability = "Intimidate"
			if(istype(P,/mob/Pokemon/Mightyena) && src.Ability == "Rattled")
				src.Ability = "Moxie"
			if(istype(P,/mob/Pokemon/Silcoon) || istype(P,/mob/Pokemon/Cascoon))
				src.Ability = "Shed Skin"
			if(istype(P,/mob/Pokemon/Beautifly))
				src.Ability = pick("Swarm","Rivalry")
			if(istype(P,/mob/Pokemon/Dustox))
				src.Ability = pick("Shield Dust","Compoundeyes")
			if(istype(P,/mob/Pokemon/Masquerain))
				src.Ability = pick("Intimidate","Unnerve")
			if(istype(P,/mob/Pokemon/Ninjask))
				src.Ability = pick("Speed Boost","Infiltrator")
			if(istype(P,/mob/Pokemon/Loudred) && src.Ability == "Rattled")
				src.Ability = "Scrappy"
			if(istype(P,/mob/Pokemon/Camerupt))
				src.Ability = pick("Magma Armor","Solid Rock","Anger Point")
			if(istype(P,/mob/Pokemon/Vibrava))
				src.Ability = "Levitate"
			if(istype(P,/mob/Pokemon/Milotic))
				src.Ability = pick("Marvel Scale","Cute Charm")
			if(istype(P,/mob/Pokemon/Salamence))
				src.Ability = pick("Intimidate","Moxie")
			P.Ability = src.Ability
			for(var/obj/Moves/M in P.Moves)
				M.Owner = P

			//Updating the Pokemons Pokeball.
			P.Ball = src.Ball
			var/obj/Balls/B = P.Ball
			B.name = P.name
			if(O.ControlingPokemon == src)
				O.ControlingPokemon = P
				B.icon = image(P.icon, P.icon_state)
			B.Pokemon = P
			P.FindExp(P.Level)
			var/replace = 0
			if(O)
				for(var/i=1, i<7, i++)
					var/mob/Pokemon/PP = O.Party[i]
					if(PP == src) replace = i
				if(replace)
					O.Party[replace] = P




			if(ATOM) del ATOM //This is the object that helped it evolve.
			P.AddMove()

			if(O)
				O<<System("[src] evolved into [P]!")
				O.UpdateParty()

			spawn(20)
				P.frozen = 0
				del src
		PokemonInformation(var/mob/Player/M)
			winset(M, "PokemonInformation", "is-visible=true") //Make it visible
			//Image
			winset(M, "PokemonInformation.PokemonImage", "image='[Number].png'")
			//Gender
			src<<'Male.png' //For some reason, unless the files were sent somewhere, they wouldn't show. So send them to the Pokemon, a mob without a client.
			src<<'Female.png'
			winset(M, "PokemonInformation.Gender", "image='[Gender].png'")
			//Name Level and Owner
			winset(M, "PokemonInformation.PokemonName", "text='[name]'")
			winset(M, "PokemonInformation.PokemonLevel", "text='[Level]'")
			var/mob/Player/P = GetOwner(Owner)
			winset(M, "PokemonInformation.PokemonOwner", "text='[P.name]([Owner])'")
			//Types
			winset(M, "PokemonInformation.Type1", "size =122x35")
			if(Type1 && Type2)
				winset(M, "PokemonInformation.Type1", "text='[Type1]'")
				winset(M, "PokemonInformation.Type1", "background-color=[TypesColours[Type1]]")
				winset(M, "PokemonInformation.Type2", "text='[Type2]'")
				winset(M, "PokemonInformation.Type2", "background-color=[TypesColours[Type2]]")
			else //Theres only 1 type
				winset(M, "PokemonInformation.Type1", "text='[Type1]'")
				winset(M, "PokemonInformation.Type1", "background-color=[TypesColours[Type1]]")
				winset(M, "PokemonInformation.Type1", "size =244x35")
			//Stats
			//270
			var/Highest = 0
			for(var/i in Stats)
				if(i == "HP") continue
				if(Stats[i] > Highest) Highest = Stats[i]
			if(MHP > Highest) Highest = MHP

			for(var/i in Stats)
				var/Value = Stats[i]
				if(i == "HP") Value = MHP
				var/A = round(Value/Highest * 100)
				var/B = round(A * 230 / 100)
				winset(M, "PokemonInformation.[i]BAR", "size =[B]x20")
				winset(M, "PokemonInformation.[i]BAR", "text = '[Value]'")

			//Happiness
			var/Value = Happiness
			var/B = round(Value/ 256 * 100) //Percentage
			winset(M, "PokemonInformation.HAPbar", "size =[Happiness]x20")
			winset(M, "PokemonInformation.HAPbar", "text = '[B]%'")

			//Ability
			winset(M, "PokemonInformation.AbilityBAR", "text = '[Ability]%'")

			//Held Item
			if(HeldItem)
				winset(M, "PokemonInformation.HeldItemText", "text='[HeldItem.name]'")

				var/icon/HoldImage = new (HeldItem.icon, HeldItem.icon_state)
				var/iconfile = fcopy_rsc(HoldImage)
				winset(M, "PokemonInformation.HeldItemImage", "image=\ref[iconfile]")
			else
				winset(M, "PokemonInformation.HeldItemText", "text='Nothing'")

			//HM
			winset(M, "PokemonInformation.HM", "is-visible=false")

			if(HM && M == P && P.ControlingPokemon == src)
				winset(M, "PokemonInformation.HM", "is-visible=true")
				winset(M, "PokemonInformation.HM", "text ='[HM.name]'")
			if(M == P && P.ControlingPokemon == src)
				winset(M, "PokemonInformation.HELDITEM", "is-visible=true")




		Wander(var/T)
			set background = 1
			if(T) Target = T
			dir = pick(1,2,4,8)
			var/counter = rand(1,5)
			spawn(5)
				var/Erase = 50
				while(src && src.loc)
					if(Target)
						Attack()
						continue
					step(src, src.dir)
					counter -= 1
					Erase -= 1
					if(!Erase)
						del src
					if(!counter)
						sleep(20)
						counter = rand(1,5)
						dir = pick(1,2,4,8)
					sleep(max(5,GetSpeed()*5))

		AbleAttack(var/Prob = 50) //This is to see if they have moves with no wait Time...If they do, they wait 2 seconds and let them attack?
			var/Attacks
			for(var/obj/Moves/M in Moves)
				if(istype(M))
					if(!M.WaitTime && M.Type != "Unprogramed")
						if(prob(min(Prob, 100))) return M
						else Attacks = 1
			if(Attacks) return AbleAttack(Prob + 10)
			else return 0

		AttacksLeft()
			for(var/obj/Moves/M in Moves)
				return 1
			return 0

		Run_Away(var/Speed = 5)
			while(src && Target)
				if(istype(HM,/obj/HMs/Teleport) && prob(35))
					icon_state = "Blank"
					flick("TeleportOut",src)
					sleep(12)
					if(loc) del src
				if(get_dist(src.Target, src) >= 9) del src
				if(src.Target.HP  <= 0 || src.HP <= 0) break //Are the foes up for the battle? Are you?
				if(!src.Target.loc || !src.loc || src.Target.z != src.z) break //Are we even seeing eye to eye?...
				step_away(src, Target)
				sleep(max(1,Speed))


		Attack()
			set background = 1
			while(src && src.Target)
				sleep(max(1,GetSpeed()))
				if(src.HP <= 0)
					break
				if(src.HP <= MHP/6) //I can see the light..
					Run_Away(GetSpeed()+10) //Run!
					break


				//Are they a Pokemon?
				if(istype(Target,/mob/Pokemon))
					var/mob/Pokemon/P = Target
					if(P.HP <= 0 || !P.loc) //Is the Pokemon absent, or unable to battle.
						Target = GetOwner(P.Owner) //If its defeated the Pokemon, move onto the master.
						continue
					if(!P.loc || !loc || P.z != z) //If it really comes to the person fainting, or the person..leaving, then just delete the pokemon..

						del src
						continue
					if(P.Owner == Owner)

						Target = null //FRIENDLY FIRE?!?!

					if(P.Level > src.Level +25) //Whoa..I can't take that guy!
						Run_Away(GetSpeed()) //Run!
						Target = GetOwner(P.Owner) //If its defeated the Pokemon, move onto the master.
						continue

					var/obj/Moves/M = AbleAttack()

					if(M)
						M.Check(src,P)

					else if(!AttacksLeft())

						Run_Away()
						break
				//Are they a player?
				if(istype(Target,/mob/Player))
					var/mob/Player/P = Target
					if(P.ControlingPokemon && P.ControlingPokemon.HP >= 1)
						Target = P.ControlingPokemon
						continue
					if(P.z != src.z || get_dist(P,src) > 8)
						Target = null
						break
					dir = get_dir(src,Target)

					if(P.Court)
						Target = null
						break

					else
						var/obj/Moves/M = AbleAttack()
						if(M)
							M.Check(src,P)
						else if(!AttacksLeft())
							Run_Away()
							break
				//Movement
				if(!Target)
					break
				var/atom/Move
				for(var/obj/Overworld/O in view(4)) //Lets fine what the hell is shooting me.
					Move = O
					break
				if(Move) //If they are dodging a move, do this
					if(prob(min(Level,100)))
						dir = turn(dir,pick(-90,90))
						step(src,dir)
						sleep(GetSpeed() + 1)
						dir = get_dir(src,Target)

				else if(istype(HM,/obj/HMs/Teleport) && prob(50))
					flick("TeleportOut",src)
					sleep(12)
					if(loc) del src

				else if(get_dist(Target,src) < 2) // If they are too close, step away
					step_away(src,Target)
					sleep(GetSpeed()+1)
					dir = get_dir(src,Target)
				else if(get_dist(Target,src) > 2) if(Target.loc)
					//step_towards(src,Target)
					Step_To(Target)
						//Target = null
						//break //If they are too far, step towards



			Target = null





		GiveTempStat(var/mob/Pokemon/Killer, var/Stat, var/Ammount,var/Spawn = 0)
			var/UPDOWN
			if(Ammount < 0) UPDOWN = "Down"
			else if(Ammount > 0) UPDOWN = "Up"
			else return

			spawn(Spawn)
				flick_overlay('Side Effects.dmi', "[Stat] [UPDOWN]")
				TempStats[Stat] += Ammount
		Pushback(var/mob/Pokemon/M, var/Power = 0, var/DIR)
			spawn()
				//If there is an M, it is a physical attack and relies on the Weight variable of the Pokemon.
				//If not, then it relies on Power, which is from an attack
				if(M && isPokemon(M))

					var/WeightDifference = M.Weight - Weight
					if(IsBetween(WeightDifference,0,33.1)) Power += 1
					else if(IsBetween(WeightDifference,33.2,66.1)) Power += 2
					else if(IsBetween(WeightDifference,66.2,110.2)) Power += 3
					else if(IsBetween(WeightDifference,110.3,143.4)) Power += 4
					else if(IsBetween(WeightDifference,143.5,220.5)) Power += 5
					else if(IsBetween(WeightDifference,220.6,677.3)) Power += 6
					else if(IsBetween(WeightDifference,677.4,2094.4)) Power += 7

				frozen = 1
				icon_state = "Pushback"


				for(var/i = 1, i <= Power, i++)
					frozen = 0
					step(src,DIR)

					frozen = 1
					sleep(2)
				frozen = 0
				if(icon_state == "Pushback") icon_state = null
				if(HP <= 0) icon_state = "Faint"
				if(Status == "Sleep") icon_state = "Sleep"









		ReturnStatus()
			if(Status == "Freeze" || Status == "Sleep")
				return 2
			if(Status == "Paralyze" || Status == "Burn" || Status == "Poison")
				return 1.5
			else return 1
		ReturnGender()
			if(Gender == "Male") return "he"
			if(Gender == "Female") return "she"
			else return "it"



//EXP -- MAX EXP procs

		FindExp(var/level)
			switch(GrowthRate)
				if("Fast")
					if(!Exp) Exp = Fast(max(1,level-1))
					MExp = Fast(level)
				if("Medium-Fast")
					if(!Exp) Exp = MediumFast(max(1,level-1))
					MExp = MediumFast(level)//MUDKIPZ
				if("Medium-Slow")
					if(!Exp) Exp = MediumSlow(max(1,level-1))
					MExp = MediumSlow(level)
				if("Slow")
					if(!Exp) Exp = Slow(max(1,level-1))
					MExp = Slow(level)
		MediumSlow(var/level)
			var/k = 1.2 * (level ** 3)
			var/l = 15 * (level ** 2)
			var/m = 100 * (level)
			var/n = 140
			return round(k - l + m - n)
		MediumFast(var/level)
			return round(level ** 3)
		Slow(var/level)
			return round(1.25 * (level ** 3))
		Fast(var/level)
			return round(0.8 * (level ** 3))

//Meter Proc//
mob/Pokemon/proc
	AddMeter(var/Invis = 1) //This is really backwards...but if Invis = 0, they ARE invisible... I think.
		if(!Meter)
			Meter = new
			Meter.Owner = src
		overlays -= Meter
		overlays -= /obj/HUD/Owned/
		Meter.Update(1)
		var/mob/M = GetOwner(Owner)
		if(M)
			if(M.Court)
				if(M.Find_Team() == "Team2")
					Meter.icon = 'Meter Blue.dmi'
			var/area/Routes/R = loc.loc
			if(istype(R)) if(R.Team2 && R.Team2 == M.Team) Meter.icon = 'Meter Blue.dmi'
			else
				Meter.icon = 'Meter.dmi'
		Meter.pixel_x = pixel_x * -1
		Meter.pixel_y = Pixel_y * -1 * 2 + 16
		if(Owner && Invis && !findtext(Owner, "WILD") && !Pixel_y) overlays += /obj/HUD/Owned/
		if(Invis) overlays += Meter

obj/HUD/Meter
	icon = 'Meter.dmi'
	icon_state = "0"
	pixel_y = 16
	var/mob/Pokemon/Owner
	var/width = 30
	layer = 90
	proc/Update()
		var/num = (Owner.HP/Owner.MHP) * width
		overlays = 0
		if(!Owner) return
		name = "[Owner.HP]/[Owner.MHP]"
		if(num < 0) //if the meter is negative
			num = 0 //set it to zero
		else if(num > width) //if the meter is over 100%
			num = width //set it to 100%
		src.icon_state = "[round(num)]"

obj/HUD/Owned
	icon = 'Meter.dmi'
	icon_state = "Owned"
	pixel_y = 8
	layer = 99

