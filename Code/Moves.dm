obj/Overworld
	layer = 100
	var
		mob/Pokemon/owner
		list/parts = list()
		atom/Center


obj/Moves
	density = 0
	icon = 'HUD.dmi'
	layer = 111
	icon_state = "Blank"
	New()
		if(Type != "Unprogramed") icon_state = name
	var/
		Type = "Unprogramed"
		mob/Pokemon/Owner
		PP = 0
		MPP = 0
		Power
		CriticalHit = 6.25
		Distance
		Range = "Status"
		Wait_Time
		tmp/WaitTime = 0
		tmp/Disabled = 0
		TimesUsed
		list/Parts = list()
		list/Hit = list() //This is a list of Hit Targets
	proc/Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		var/obj/Moves/Z = src
		if(!P || PP <= 0 || WaitTime || P.HP <= 0) return 0
		if(P.icon_state == "Sleep" && !istype(Z,/obj/Moves/Snore)) return 0
		if(P.Status == "Frozen") return 0
		if(P.SecondaryStatus["Attacking"]) return 0
		if(icon_state == "Pushback")
			return 0
		if(O && O.Court)
			if(O.Court.Battle_Banned_Move_Check(src,O)) return 0
		if(Disabled)
			O<<System("This move has been Disabled!")
			return 0
		if(istype(P.UsingAttack,/obj/Moves/SolarBeam))
			O<<System("[P] is taking in energy.")
			return 0
		if(P.SecondaryEffect["SkyAttack"]) return 0
		if(P.SecondaryStatus["Charge"])
			if(src.Type == "Electric")
				src.Power *= 2
				P.SecondaryStatus["Charge"] = 0
		PP -= 1
		TimesUsed += 1
		WaitTime = 1
		spawn(Wait_Time) WaitTime = 0
		P.UsingAttack = src
		P.LastAttack = src
		if(P.Status == "Burn")
			O<<System("[P] has been inflicted damage for its burn")
			var/Damage = P.MHP / 16
			P.HP = max(0, P.HP - Damage)
			if(!P.HP) P.Status = null
			P.DamageOverlay(Damage)
			P.DeathCheck(P.StatusKiller)
		if(P.SecondaryEffect["Taunt"])
			if(!Power)
				O<<System("[src] has been taunted. They are unable to use non-damaging moves")
				return 0
		if(P.SecondaryStatus["Confused"])
			P.SecondaryStatus["Confused"] -= 1
			if(!P.SecondaryStatus["Confused"]) spawn(40) O<<System("[P] snapped out of confusion!")
			if(prob(50))
				P.overlays += image('Moves.dmi',"Confused")
				spawn(15) P.overlays -= image('Moves.dmi',"Confused")
				flick("Pushback", P)
				var/obj/Moves/A = new
				A.Power = 40
				P.HP = max(0,P.HP - (P.HP/7))
				P.DeathCheck(P.SecondaryStatus["ConfusedTarget"])
				del A
				O<<System("[P] attacked itself in confusion!")
				return 0
		if(P.SecondaryStatus["ViceGrip"] || P.SecondaryStatus["Wrap"] || P.SecondaryStatus["Fire Spin"])
			return 0

		if(P.Status == "Paralysis")
			if(prob(25))
				O<<System("[P] is fully paralyzed!")
				flick("Pushback", P)
				P.overlays += image('Moves.dmi', "Paralysed")
				spawn(10) P.overlays -= image('Moves.dmi', "Paralysed")
				P.frozen = 1
				for(var/i = 1, i <= 10, i++)
					if(i == 1 || i == 3 || i == 5|| i == 7|| i == 9) P.pixel_x += 3
					else P.pixel_x -= 3
					sleep(1)
				P.frozen = 0
				return 0
		return 1
	proc/Check(mob/Pokemon/Attacker, mob/Pokemon/Defender)

	Click()
		Attack()

//Absorb//--------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Absorb
	Type = "Grass"
	Range = "Special"
	Power = 15
	PP = 25
	MPP = 25
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Absorb(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 7)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Absorb
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "Leech[pick(1,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

mob/Pokemon/proc/Absorb(var/obj/Moves/M)
	FindTarget()
	if(Target)
		if(get_dist(src,Target) >3) return
		for(var/i=1, i<7, i++)
			var/obj/Overworld/Absorb/A = new
			spawn(i)
				if(Target) missile(A, src, Target)
				del A
		if(Target) //Just in case the Target is gone(logs out) by the time the absorb's are done.
			var/Drain = BattleDamage(Target,M)
			Target.HP = max(0,Target.HP - Drain)
			HP = min(MHP, HP+ (Drain/2))
			Target.DeathCheck(src)
	else
		M.PP +=1
		M.WaitTime = 0
		return

//Acid Armour//-----------------------------------------------------------------------------------------------------------
obj/Moves/Acid_Armor
	Range = "Status"
	Type = "Poison"
	PP = 40
	MPP = 40
	Wait_Time = 450
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Acid_Armour(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		spawn() Attack() //FIX THIS
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDAA"
				src<<icon

mob/Pokemon/proc/Acid_Armour(var/obj/Moves/M)
	var/mob/Player/PP = GetOwner(Owner)
	var/list/images_to_record = list()
	if(TempStats["DEF"] >= 6) return
	spawn(1)
		icon_state = "Acid Armour"
		AddMeter(0)
		spawn(6) for(var/i, i <= 15, i++)
			icon += rgb(0,0,0,255-(i*17))
			sleep(3)
			if(PP.client)
				var/image/I = image(icon, src ,"Acid Armour Invis",MOB_LAYER+1)
				I.layer = 62
				PP << I
				images_to_record += I
		sleep(100)
		for(var/image/i in images_to_record) del i
		if(icon_state == "Acid Armour") icon_state = null
		icon = initial(icon)
		AddMeter(1)

	GiveTempStat(src,"DEF",2)
	GiveTempStat(src,"DEF",-2,450) //Waits 1 minute before returning the stat.
//Acid//------------------------------------------------------------------------------------------------------------------
obj/Moves/Acid
	Type = "Poison"
	Range = "Special"
	Power = 10
	PP = 30
	MPP = 30
	Wait_Time = 66
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Acid(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Acid
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
		var/obj/B
		for(var/i=0, i<9, i++)
			B = new
			B.pixel_y = rand(-10,10)
			B.pixel_x = rand(-10,10)
			B.icon_state = "Acid[rand(1,3)]"
			src.overlays += B
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			var/mob/M = D
			var/obj/Moves/Acid/A = new
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			sleep(5)
			del A
		del src

mob/Pokemon/proc/Acid(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=0, i<4, i++)
		var/obj/Overworld/Acid/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
		sleep(3)
	FindTarget()

//Aerial Ace//------------
obj/Moves/Aerial_Ace
	Type = "Flying"
	Range = "Physical"
	Power = 55
	PP = 20
	Distance = "Projectile"
	MPP = 20
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Aerial_Ace(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 5 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()

		spawn(20)
			overlays = null
			icon_state = null
			if(Owner)
				overlays += image(Owner.icon,"Tackle")
				overlays += image('Moves.dmi',"A Ace")
				overlays += image('HUD.dmi',"Frame")


mob/Pokemon/proc/Aerial_Ace(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	overlays += image('Moves.dmi',"A Ace")
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=0, i<7, i++)
		if(O) if(O.client) if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
		else step(src,SetDir)
		for(var/mob/D in src.loc)
			if(D == GetOwner(Owner) || D == src) continue
			if(D.HP > 0 && icon_state == "Tackle" && HP > 0) //Are they NOT dead?
				D.HP = max(0,D.HP - BattleDamage(D,M))
				D.overlays += image('Moves.dmi',"Aerial Ace")
				D.DeathCheck(src)

				spawn(5) if(D) D.overlays -= image('Moves.dmi',"Aerial Ace")
		sleep(1)
	overlays -= image('Moves.dmi',"A Ace")
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0

//Aeroblast//-------------
obj/Moves/Aeroblast
//Agility//---------------
obj/Moves/Agility
	Type = "Psychic"
	Range = "Status"
	PP = 30
	MPP = 30
	Distance = "None"
	Wait_Time = 300
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Agility(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		if(ATK.TempStats["SPD"] <= 5)
			Attack()

mob/Pokemon/proc/Agility(var/obj/Moves/M)
	var/direction = pick(45,-45)
	icon_state = "Blank"
	if(TempStats["SPD"] <= 5)
		GiveTempStat(src,"SPD",2)
		GiveTempStat(src,"SPD",-2,600)
	NoRunDelay = 1
	var/mob/currentfake = src
	var/mob/Fake = src
	for(var/i=1, i<9, i++)
		sleep(1)
		Fake = new(get_step(currentfake,turn(currentfake.dir,direction)))
		Fake.dir = turn(currentfake.dir,direction)
		Fake.icon = icon
		currentfake = Fake
		spawn(3)
			del Fake
	if(icon_state == "Blank") icon_state = null
	NoRunDelay = 0



//Air Cutter//Aircutter//------------
obj/Moves/Air_Cutter
	CriticalHit = 12.5
	Type = "Flying"
	Range = "Special"
	PP = 20
	MPP = 20
	Power = 45
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Air_Cutter(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Air_Cutter
	icon = 'Moves.dmi'
	icon_state = "Air Cutter"
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/obj/Moves/Air_Cutter/A = new

			var/mob/M = D
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			density = 0 //Its already damaged one Pokemon, so forget doing anymore damage.



		else del src

mob/Pokemon/proc/Air_Cutter(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Air_Cutter/A = new(get_step(src.loc,turn(dir,i)))
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)
	FindTarget()
//Amnesia//--------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Amnesia
	Type = "Psychic"
	Range = "Status"
	PP = 30
	MPP = 30
	Distance = "None"
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Amnesia(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		if(ATK.TempStats["SPL DEF"] <= 5)
			Attack()

obj/Overworld/Amnesia
	icon = 'Moves.dmi'
	icon_state = "?"
	pixel_y = 40
	layer = 32


mob/Pokemon/proc/Amnesia(var/obj/Moves/M)
	overlays += /obj/Overworld/Amnesia
	frozen = 1
	if(TempStats["SPL DEF"] <= 5)
		GiveTempStat(src,"SPL DEF",2)
		GiveTempStat(src,"SPL DEF",-2,300)
	sleep(15)
	frozen = 0
	overlays -= /obj/Overworld/Amnesia

//Ancient Power//----------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Ancient_Power
	Type = "Rock"
	Range = "Special"
	Power = 20
	PP = 5
	MPP = 5
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Ancient_Power(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		spawn() Attack()

obj/Overworld/Ancient_Power
	density = 0
	icon = 'Moves.dmi'
	icon_state = "Blank"
	pixel_x = -22
	New()
		spawn(60)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)




mob/Pokemon/proc/Ancient_Power(var/obj/Moves/M)
	FindTarget()
	var/atom/T
	if(Target) T = Target
	else
		M.PP +=1
		M.WaitTime = 0
		return
	for(var/i = 1, i <= 4, i++)
		spawn(i+1)
			if(T && T.loc)
				var/obj/Overworld/Ancient_Power/AP = new (Get_Steps(T.loc, turn(SOUTHEAST, i*90), 4))
				AP.owner = src
				flick("Rock1Rise", AP)
				AP.icon_state = "Rock1"
				sleep(20)
				var/counter = 0
				var/atom/TT
				while(AP)
					counter += 1
					if(counter < 2) step_towards(AP, T)
					else
						if(!TT && T) TT = T.loc
						step_towards(AP,TT)

					for(var/mob/MR in AP.loc)
						MR.HP = max(0,MR.HP - src.BattleDamage(MR,M))
						MR.DeathCheck(src)
						AP.loc = MR.loc
						walk(AP,0)
						AP.density = 0
						del AP
					if(AP.loc == TT) del AP
					sleep(1)
	if(prob(10)) //There is a 10% chance it raises every stat by 1...Wow, nice!
		var/list/Ss = list("ATK","DEF","SPL ATK", "SPL DEF", "SPD")
		for(var/i in Ss)
			if(TempStats[i] >= 6) continue
			GiveTempStat(src,i,1)
			GiveTempStat(src,i,-1,300) //Waits 1 minute before returning the stat.
obj/Moves/Arm_Thrust
//Aromatherapy//----------------------------------------------------------------------------------------------------------------------
obj/Moves/Aromatherapy
//Assist//-------------------------------------------------------------------------------------------------------------------------
obj/Moves/Assist
//Astonish//
obj/Moves/Astonish
//Aurora Beam//-----------------------------------------------------------------------------------------------------------------------
obj/Moves/Aurora_Beam
	Type = "Ice"
	Range = "Special"
	Power = 65
	PP = 20
	MPP = 20
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Aurora_Beam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else

				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'
	Aurora_Beam
		density = 1
		icon_state = "AuroraBeamHead"
		layer = 10
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Signal_Beam/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			density = 0

	AExtra
		density = 1
		icon_state = "AuroraBeamBody"


mob/Pokemon/proc/Aurora_Beam(var/obj/Moves/M)
	set background = 1
	var/obj/Overworld/Aurora_Beam/P = new(loc)
	var/list/Parts = list()
	P.dir = dir
	var/SetDir = P.dir
	P.owner = src
	frozen = 1
	spawn(8) if(P) P.density = 0
	flick("Fire",src)
	while(P.density)

		var/obj/Overworld/AExtra/E = new(P.loc)

		step(P,SetDir)

		if(length(Parts) == 1)
			E.icon_state = "AuroraBeamBody"
		if(!length(Parts))
			E.invisibility = 1

		E.layer = layer - 1
		E.owner = P.owner
		Parts += E
		E.dir = SetDir
		sleep(1)
	del P
	for(var/obj/E in Parts)
		spawn()
			E.density = 0
			E.icon_state = "Blank"
			del E
	frozen = 0
obj/Moves/Attract

obj/Moves/Barrage
obj/Moves/Barrier/
	Type = "Psychic"
	Range = "Status"
	PP = 30
	MPP = 30
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Barrier(src)
			if(P) P.UsingAttack = null

obj/Overworld/Barrier
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	BumpedInto(D)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			return 0
		else
			return 1
	New()
		spawn(600) del src

mob/Pokemon/proc/Barrier(var/obj/Moves/M)
	for(var/i = -45, i <= 45, i+= 45)
		var/obj/Overworld/Barrier/B1 = new (get_step(src,turn(src.dir,i)))
		B1.icon_state = "Barrier"
		M.Parts += B1
		B1.dir = dir

obj/Moves/Baton_Pass
//Beat-Up//Sneasel Only Move//-------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Beat_Up
	Range = "Physical"
	Type = "Dark"
	Power = 12
	PP = 10
	MPP = 10
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Beat_UP(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		spawn() Attack()

obj/Overworld/Pokemon_From_Party
	density = 1
	icon = 'Moves.dmi'
	icon_state = "Blank"
	var/Watcher
	var/BU //Beat Up
	var/mob/Pokemon/PokemonO
	New()
		spawn(80)
			ReturntoBall()
	proc/ReturntoBall()
		flick("Send",src)
		missile(image('Pokeballs.dmi',"throw [PokemonO.Ball.ricon_state]"), src, Watcher)
		del src
	Bump(D)
		if(isPokemon(D))
			var/mob/Pokemon/MR = D
			dir = get_dir(src,MR)
			flick("Physical",src)
			var/obj/Overworld/Scratch/Pound = new(MR.loc)
			flick("Pound",Pound)
			MR.HP = max(0,MR.HP - PokemonO.BattleDamage(MR,BU))
			BU = null //This tells the proc moving the Pokemon to stop. Its suppose to be Beat Up, but were done with it.
			MR.DeathCheck(owner)
			sleep(10)
			ReturntoBall()
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)




mob/Pokemon/proc/Beat_UP(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	var/mob/TT = Target
	if(!TT)
		M.PP +=1
		return
	var/counter
	for(var/mob/Pokemon/P in O.Party)
		if(P == src) continue
		counter += 1; if(counter == 3) counter += 1
		spawn(counter)
			var/atom/T = get_step(src,counter)
			var/obj/Overworld/Pokemon_From_Party/PfP = new
			PfP.icon = P.icon
			missile(image('Pokeballs.dmi',"throw [src.Ball.ricon_state]"), O.Watcher, T)
			sleep(max(0,get_dist(T,O.Watcher)-1))
			PfP.loc = T
			flick("Send",PfP)
			PfP.owner = src
			PfP.Watcher = O.Watcher
			PfP.BU = M
			PfP.PokemonO = P
			PfP.icon_state = null
			PfP.name = P.name

			while(PfP)
				if(!PfP.loc || !loc || HP <= 0)
					PfP.ReturntoBall()
					continue //The pokemon was returned/defeated
				if(PfP.BU) step_towards(PfP,TT)

				sleep(3)
//Belly Drum//
obj/Moves/Belly_Drum
	Type = "Normal"
	Range = "Status"
	Power = 35
	PP = 35
	MPP = 35
	Wait_Time = 600
	Distance = "Projectile"
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Belly_Drum(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Belly_Drum
	icon = 'Fireblast.dmi'
	icon_state = "Belly Drum"
	pixel_y = -42
	pixel_x = -42

mob/Pokemon/proc/Belly_Drum(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Belly_Drum/H = new
	overlays += H
	spawn(200) overlays -= H; del H
	if(TempStats["ATK"] >= 6 && round(HP) >= round(MHP/2)) return
	else O<<System("Belly Drum failed!")

	HP -= round(MHP/2)
	TempStats["ATK"] = 0
	GiveTempStat(src,"ATK",6)
	spawn()
		GiveTempStat(src,"ATK",-6,600)

obj/Moves/Bide
//Bite//-------------------------------------------------------
obj/Moves/Bite
	Type = "Dark"
	Range = "Physical"
	Power = 50
	PP = 25
	MPP = 25
	Distance = "Physical"
	Wait_Time = 55
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bite(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))

				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Bite
	layer = 100
	icon = 'Moves.dmi'
	New()
		flick("Bite",src)


mob/Pokemon/proc/Bite(var/obj/Moves/M)
	var/list/Turfs = list() //Find where the attack will go.
	if(dir == 5 || dir == 6 || dir == 9 || dir == 10) dir = turn(dir,pick(45,-45))
	Turfs += get_step(src,dir)
	Turfs += get_step(src,turn(dir,45))
	Turfs += get_step(src,turn(dir,-45))
	flick("Physical",src)
	for(var/atom/A in Turfs)
		var/obj/Overworld/Bite/B = new(A)
		B.dir = dir
		B.owner = src
		spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
			if(p == src) continue
			p.HP = max(0, p.HP - BattleDamage(p, M))
			if(!Target) Target = p
			p.DeathCheck(src)
		spawn() for(var/mob/Player/p in A) //Check for Players
			if(p == src) continue
			p.HP = max(0, p.HP - BattleDamage(p, M))
			if(!Target) Target = p
			p.DeathCheck(src)
		spawn(12)
			if(B) del B







obj/Moves/
	Bind
obj/Moves/Blaze_Kick
	Type = "Fire"
	Range = "Physical"
	Power = 85
	PP = 10
	MPP = 10
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Blaze_Kick(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Blaze_Kick
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Blaze_Kick(var/obj/Moves/M)
	var/obj/Overworld/Blaze_Kick/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Blaze Kick", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves
	Blizzard
	Block
//Bone Club//BoneClub//----------------------------------------------------------------------------------------------------------------
obj/Moves/Bone_Club
	Type = "Ground"
	Range = "Physical"
	Power = 65
	PP = 20
	MPP = 20
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bone_Club(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Scratch
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Bone_Club(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("BoneClub", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
//Bone Rush//Bonerush//----------------------------------------------------------------
obj/Moves/Bone_Rush
//Bonemerang//Bone merang//Boomerang//---------------------------------------------------------------------------
obj/Moves/Bonemerang
	Type = "Ground"
	Range = "Physical"
	Power = 65
	PP = 25
	MPP = 25
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bonemerang(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 7)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Bonemerang
	icon = 'Moves.dmi'
	icon_state = "Bone"
	layer = 100
	density = 1
	var/Hit
	New()
		..()
		spawn(100) del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			var/mob/M = D
			var/obj/Moves/Bonemerang/A = new
			if(M == owner && Hit)
				del src
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)
			if(Hit) del src


		Hit = 1
		GotoOwner()
	proc/GotoOwner()
		while(src)
			if(owner) step_towards(src, owner)
			sleep(2)

mob/Pokemon/proc/Bonemerang(var/obj/Moves/M)
	var/obj/Overworld/Bonemerang/B = new (loc)
	flick("Fire", src)
	B.owner = src
	B.dir = dir

	FindTarget()
	for(var/i = 1, i <= 9, i++)
		var/mob/Pokemon/P = Target
		if(isPokemon(P) && P.Ability == "Levitate") return
		else
			if(Target && get_dist(src,Target) >=3 && i >=4)
				step_towards(B,Target)
			else
				step(B,B.dir)
		sleep(2)
	if(!B.Hit)
		B.Hit = 1
		B.GotoOwner()


//Body Slam//-------------
/obj/Moves/Body_Slam
	Type = "Normal"
	Range = "Physical"
	Power = 85
	PP = 15
	MPP = 15
	Wait_Time = 85
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.BodySlam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/BodySlam(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<4, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
obj/Moves/Bounce
obj/Moves/Brick_Break
	Type = "Fighting"
	Range = "Physical"
	Power = 75
	PP = 15
	MPP = 15
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Brick_Break(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/Brick_Break(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	spawn(4) frozen = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Brick Break", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
			for(var/obj/Overworld/R in O.loc)
				if(istype(R,/obj/Overworld/Reflect) || istype(R,/obj/Overworld/Light_Screen) || istype(R,/obj/Overworld/Barrier))
					del R
//BubbleBeam//------------
obj/Moves/Bubblebeam
	Type = "Water"
	Range = "Special"
	Power = 70
	PP = 20
	MPP = 20
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bubblebeam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'


	Bubblebeam
		density = 1
		invisibility = 1
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Bubblebeam/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			loc = null

	BBExtra
		density = 1
		icon_state = "Bubblebeam"
		New()
			spawn(100) del src //Incase something fucks up.


mob/Pokemon/proc/Bubblebeam(var/obj/Moves/M)
	var/obj/Overworld/Bubblebeam/B = new(loc)
	M.Parts += B
	B.dir = dir
	var/SetDir = B.dir
	B.owner = src
	frozen = 1
	var/First = 0
	spawn(13) if(B) B.loc = null

	while(B.loc)
		step(B,SetDir)
		if(B)
			var/obj/Overworld/BBExtra/E = new(B.loc)
			if(!First)
				First = 1
				E.icon_state = "Bubblebeam Mouth"
			flick("Bubblebeam Head",E)
			E.layer = layer - 1
			E.owner = B.owner
			M.Parts += E
			E.dir = SetDir
			sleep(2)
			//if(V) if(V.loc) sleep(1)
	del B
	for(var/obj/E in M.Parts)
		del E
	frozen = 0

//Bubble//----------------
obj/Moves/Bubble
	Type = "Water"
	Range = "Special"
	Power = 8
	PP = 30
	MPP = 30
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bubble(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Bubble
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
		var/obj/B
		for(var/i=0, i<9, i++)
			B = new
			B.pixel_y = rand(-10,10)
			B.pixel_x = rand(-10,10)
			B.icon_state = "Bubble[rand(1,3)]"
			src.overlays += B
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			var/mob/M = D
			var/obj/Moves/Bubble/A = new
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)

		del src

mob/Pokemon/proc/Bubble(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=0, i<4, i++)
		var/obj/Overworld/Bubble/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,1)
		sleep(3)
	if(!Target) FindTarget()
obj/Moves/Bulk_Up
//Bullet Seed//Bulletseed//---------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Bullet_Seed
	Type = "Grass"
	Range = "Physical"
	Power = 25
	PP = 25
	MPP = 25
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Bullet_Seed(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Bullet_Seed
	icon = 'Moves.dmi'
	icon_state = "Leech Seed"
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			var/obj/Moves/Bullet_Seed/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)


		else del src

mob/Pokemon/proc/Bullet_Seed(var/obj/Moves/M)
	flick("Fire",src)
	var/HowMany = rand(14,22)
	for(var/i=0, i<HowMany, i++)
		var/obj/Overworld/Bullet_Seed/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,1)
		sleep(3)
	FindTarget()
obj/Moves/Camouflage
//Calm Mind//CalmMind//---------------------------------------------------------------------------------------------------
obj/Moves/Calm_Mind
	Type = "Psychic"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Calm_Mind(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
obj/Overworld/Calm_Mind
	icon = 'Calm Mind.dmi'
mob/Pokemon/proc/Calm_Mind(var/obj/Moves/M)
	var/obj/Overworld/Calm_Mind/G = new
	G.icon_state = "Calm Mind"
	overlays += G
	if(TempStats["SPL ATK"] >= 6 || TempStats["SPL DEF"] >=6) return
	GiveTempStat(src,"SPL ATK",1)
	GiveTempStat(src,"SPL DEF",1)
	GiveTempStat(src,"SPL ATK",-1,600)
	GiveTempStat(src,"SPL DEF",-1,600)
	sleep(20)
	overlays -= G

//Charge//------------------------------------------------------------------------------------------
obj/Moves/Charge
	Type = "Electric"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Charge(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Charge
	icon = 'Charge.dmi'
	icon_state = "Charge"
	pixel_y = -16
	pixel_x = -16

mob/Pokemon/proc/Charge(var/obj/Moves/M)
	if(TempStats["SPL DEF"] <= 6) return
	flick_overlay('Charge.dmi', "Charge",-16,-16)
	SecondaryStatus["Charge"] = 1
	GiveTempStat(src,"SPL DEF",1)
	GiveTempStat(src,"SPL DEF",1,600)
//Charm//---------------------------------------------------------------------------------------------------------------------
obj/Moves/Charm
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 300
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Charm(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Charm
	New()
		..()
		pixel_x = rand(-21,21)
		flick("Heart", src)
	icon = 'Moves.dmi'
	pixel_y = 32



mob/Pokemon/proc/Charm(var/obj/Moves/M)
	var/list/PokemonAffected = list()
	spawn()
		for(var/mob/Pokemon/P in view(4))
			spawn()
				if(PokemonAffected.Find(P) || P == src) continue
				if(isPokemon(P) && P.Ability == "Clear Body") return
				if(P) P.GiveTempStat(src,"ATK",-2)
				if(P) P.GiveTempStat(src,"ATK",2,400)
		for(var/i = 1, i <= 14,i++)
			var/obj/Overworld/Charm/CC = new(loc)
			M.Parts += CC
			sleep(2)
			spawn(20)
				del CC
		for(var/mob/Pokemon/P in view(4))
			spawn()
				if(PokemonAffected.Find(P) || P == src) continue
				if(P) P.GiveTempStat(src,"ATK",-2)
				if(P) P.GiveTempStat(src,"ATK",2,400)

obj/Moves/Clamp
obj/Moves/Comet_Punch
	Type = "Normal"
	Range = "Physical"
	Power = 18
	PP = 15
	MPP = 15
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Comet_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))
				var/L = 1
				spawn() while(L)
					ATK.Step_To(DEF)
					sleep(SPEED)

				Attack()
				L = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Comet_Punch
	layer = 100
	icon = 'Fireblast.dmi'
	pixel_x = -16
	pixel_y = -16



mob/Pokemon/proc/Comet_Punch(var/obj/Moves/M)
	var/Times
	Times = pick(2,2,3,3,4,5)

	for(var/i = 1, i <= Times, i ++)
		frozen = 1
		spawn(5) frozen = 0
		var/list/Turfs = list() //Find where the attack will go.
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)
		var/obj/Overworld/Comet_Punch/Hand = new(get_step(src,dir))
		Hand.dir = dir
		flick("comet",Hand)
		Hand.owner = src
		M.Parts += Hand
		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(10)
		del Hand
		sleep(4)
//Confuse Ray//--------------------------------------------------------------------------------------------
obj/Moves/Confuse_Ray
	Type = "Ghost"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Confuse_Ray(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



mob/Pokemon/proc/Confuse_Ray(var/obj/Moves/M)
	flick("Fire",src)
	frozen = 1


	var/obj/Overworld/Sweet_Kiss/A = new(src.loc)
	A.icon_state = "Confuse Ray"
	A.name = "Confuse Ray"
	A.owner = src
	A.dir = dir
	walk(A,A.dir,1)

	sleep(10)
	frozen = 0
	FindTarget()
//Confusion//-------------
obj/Moves/Confusion
	Type = "Psychic"
	Range = "Special"
	PP = 25
	MPP = 25
	Power = 50
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Confusion(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Confusion
	icon = 'Moves.dmi'
	icon_state = "Confusion"
	layer = 100


mob/Pokemon/proc/Confusion(var/obj/Moves/M)
	flick("Confusion",src)
	for(var/turf/T in view(src,1))
		spawn()
			var/obj/Overworld/Confusion/C = new(T)
			for(var/mob/Pokemon/P in C.loc)
				if(P == src) continue
				P.HP = max(0,P.HP - BattleDamage(P,M))
				P.DeathCheck(src)
			sleep(20)
			del C
obj/Moves/Constrict
obj/Moves
	Conversion
	Conversion_2
	Cosmic_Power
	Cotton_Spore
	Counter
	Covet
//Crabhammer//------------
	Crabhammer
		CriticalHit = 12.5
//Cross Chop//--------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Cross_Chop
	Type = "Fighting"
	Range = "Physical"
	Power = 100
	PP = 10
	MPP = 10
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Cross_Chop(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Slash
	layer = 100
	icon = 'Slash.dmi'
	icon_state = "Blank"
	New()
		spawn(50)
			del src

mob/Pokemon/proc/Cross_Chop(var/obj/Moves/M)
	var/obj/Overworld/Slash/O = new(get_step(src,turn(src.dir, -90)))
	M.CriticalHit = 6.25
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	switch(O.dir)
		if(2) O.pixel_y = -64
		if(8) O.loc = locate(x - 2, y - 1, z)
		if(1) O.loc = locate(x - 1, y, z)
	var/list/Turfs = list()
	Turfs += get_step(src,turn(src.dir, 90))
	Turfs += get_step(src,turn(src.dir, -90))
	var/turf/TTT = get_step(src,src.dir)
	Turfs += TTT
	Turfs += get_step(TTT,turn(src.dir, -45))
	Turfs += get_step(TTT,turn(src.dir, 45))

	flick("Physical", src)
	flick("Cross Chop", O)
	if(O.loc)
		spawn(0)
			for(var/turf/T in Turfs)
				for(var/mob/MOB in T)
					if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
						if(T == TTT) M.CriticalHit = 12.5
						MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
						MOB.DeathCheck(src)
						M.CriticalHit = 6.25
obj/Moves/Crunch
	Type = "Dark"
	Range = "Physical"
	Power = 80
	PP = 35
	MPP = 35
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Crunch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Crunch
	layer = 100
	icon = 'Crunch.dmi'
	icon_state = "Blank"
	pixel_x = -20
	pixel_y = -22
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Crunch(var/obj/Moves/M)
	var/obj/Overworld/Crunch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Crunch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves/Crush_Claw
	Type = "Normal"
	Range = "Physical"
	Power = 75
	PP = 10
	MPP = 10
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Crush_Claw(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Crush_Claw
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Crush_Claw(var/obj/Moves/M)
	var/obj/Overworld/Crush_Claw/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Crush Claw", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves/Curse
//Defense Curl//------------------------------------------------------------------------------------------------------------------------
obj/Moves/Defense_Curl
	New()
		spawn(20)
			overlays = null
			icon_state = null
			if(Owner)
				icon = Owner.icon
				icon_state = "HUD DC"
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Defense_Curl(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Defense_Curl(var/obj/Moves/M)
	if(TempStats["DEF"] >= 6) return
	var/DC = rand(1,9999)
	SecondaryStatus["Defense Curl"] = DC
	spawn(120) if(SecondaryStatus["Defense Curl"] == DC) SecondaryStatus["Defense Curl"] = 0
	icon_state = "Withdraw"
	GiveTempStat(src,"DEF",1)
	spawn(50) if(icon_state == "Withdraw") icon_state = null
	GiveTempStat(src,"DEF",-1,650) //Waits 1 minute before returning the stat.

obj/Moves/Destiny_Bond
//Detect//--------------------------------------------------------------------------------------------------------
obj/Moves/Detect
//Disable//----------------------------------------------------------------------------------------------------------------------
obj/Moves/Disable
	Type = "Psychic"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Disable(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 4)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Moves/
	proc/Disable(var/Time)
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		O<<System("[src] has been disabled!")
		Disabled = 1
		spawn(Time) Disabled = 0


mob/Pokemon/proc/Disable(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	if(Target)
		var/mob/Pokemon/P
		if(istype(Target,/mob/Pokemon)) P = Target
		if(!P) return
		if(get_dist(src,Target) <= 3)
			//Find a move
			var/obj/Moves/D
			for(var/obj/Moves/OO in P.Moves)
				if(!D) //By default, we need an attack to place. If there isn't one already, pick this one.
					D = OO
					continue
				if(OO.MPP - OO.PP >= D.MPP - D.PP && OO.PP > 0)
					D = OO
			P.overlays += image('Moves.dmi', "Disable")
			spawn(11) P.overlays -= image('Moves.dmi', "Disable")
			M.WaitTime = rand(160,220)
			spawn(M.WaitTime) M.WaitTime = 0
			O<<System("[D] has been disabled!")
			D.Disable(M.WaitTime)

obj/Moves/Dizzy_Punch
	Type = "Normal"
	Range = "Physical"
	Power = 70
	PP = 10
	MPP = 10
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thunder_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Dizzy_Punch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Dizzy_Punch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					if(isPokemon(MOB))
						var/mob/Pokemon/PPP = MOB
						if(prob(20)) if(PPP.Type1 != "Ghost" || PPP.Type2 != "Ghost") spawn() PPP.Paralysis(src)

					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					if(isPokemon(MOB))
						var/mob/Pokemon/PPP = MOB
						if(prob(20)) if(PPP.Type1 != "Ghost" || PPP.Type2 != "Ghost") spawn() PPP.Paralysis(src)

					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
//Double Edge//
obj/Moves/Double_Edge
	name = "Double-Edge"
	Type = "Normal"
	Range = "Physical"
	Power = 120
	PP = 15
	MPP = 15
	Wait_Time = 169
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Double_Edge(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(2,3,3)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/Double_Edge(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<=3, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
obj/Moves/Double_Kick
	Type = "Fighting"
	Range = "Physical"
	Power = 30
	PP = 30
	MPP = 30
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Double_Kick(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))
				var/L = 1
				spawn() while(L)
					ATK.Step_To(DEF)
					sleep(SPEED)

				Attack()
				L = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Double_Kick
	layer = 100
	icon = 'Moves.dmi'



mob/Pokemon/proc/Double_Kick(var/obj/Moves/M)
	var/Times
	Times = pick(2)

	for(var/i = 1, i <= Times, i ++)
		frozen = 1
		spawn(5) frozen = 0
		var/list/Turfs = list() //Find where the attack will go.
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)
		var/obj/Overworld/Double_Kick/Foot = new(get_step(src,dir))
		Foot.dir = dir
		flick("Double Kick",Foot)
		Foot.owner = src
		M.Parts += Foot
		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(10)
		del Foot
		sleep(4)

//Double Slap//DoubleSlap//---------------------------------------------------------------------------------------------------------------------
obj/Moves/DoubleSlap
	Type = "Normal"
	Range = "Physical"
	Power = 15
	PP = 15
	MPP = 15
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.DoubleSlap(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))
				var/L = 1
				spawn() while(L)
					ATK.Step_To(DEF)
					sleep(SPEED)

				Attack()
				L = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/DoubleSlap
	layer = 100
	icon = 'Moves.dmi'



mob/Pokemon/proc/DoubleSlap(var/obj/Moves/M)
	var/Times
	Times = pick(2,2,3,3,4,5)

	for(var/i = 1, i <= Times, i ++)
		frozen = 1
		spawn(5) frozen = 0
		var/list/Turfs = list() //Find where the attack will go.
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)
		var/obj/Overworld/DoubleSlap/Hand = new(get_step(src,dir))
		Hand.dir = dir
		flick("Double Slap",Hand)
		Hand.owner = src
		M.Parts += Hand
		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(10)
		del Hand
		sleep(4)
obj/Moves/
	Double_Team
obj/Moves/Dragon_Breath
	Type = "Dragon"
	Range = "Special"
	Power = 60
	PP = 20
	MPP = 15
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Dragon_Breath(src)
			if(P) P.UsingAttack = null
		spawn(10)
			for(var/obj/D in Parts)
				del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		spawn(2)
			for(var/i, i <= 15, i++)
				ATK.icon += rgb(17,17,17)
				sleep(5)
				if(ATK.HP <= 0 || ATK.Status == "Sleep" || !ATK.loc) return

		spawn(77)
			ATK.dir = get_dir(ATK,DEF)
			if(ATK.dir != 1 && ATK.dir != 2 && ATK.dir != 4 && ATK.dir != 8) ATK.dir = turn(ATK.dir, pick(45, -45))
			DEF = null
			ATK.Solar_Beam_Fire(src)
			return
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) return
			ATK.Step_To(DEF)
			sleep(SPEED)
		return




obj/Overworld/
	icon = 'Moves.dmi'

	Dragon_Breath
		pixel_y = -16
		pixel_x = -16
		icon = 'Hydro Pump.dmi'
		icon_state = "DragonBreathBody"
		layer = 21
		proc/FindDamaged()

	DBExtra
		pixel_y = -16
		pixel_x = -16
		icon = 'Hydro Pump.dmi'
		icon_state = "DragonBreathTail"
		layer = 20


mob/Pokemon/proc/Dragon_Breath(var/obj/Moves/M)
	icon = initial(icon)
	if(HP <= 0 || Status == "Sleep" || !loc) return
	var/obj/Overworld/Dragon_Breath/W = new(get_step(loc,dir))
	W.icon_state = "DragonBreathHead"
	M.Parts += W
	W.dir = dir
	W.owner = src
	frozen = 1
	flick("Fire",src)
	var/count = 0
	var/list/Damaged = list()
	while(W)
		if(count >= 10) break
		var/obj/Overworld/Dragon_Breath/HPE
		count += 1
		if(IsEven(count))
			HPE = new(get_step(loc,dir))
			HPE.dir = dir
			HPE.owner = src
			M.Parts += HPE
		//Do Damage
		for(var/mob/MOB in view(1,W))
			if(MOB == src) continue
			if(!Damaged.Find(MOB))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
				Damaged += MOB




		for(var/obj/HP in M.Parts)
			//if(HP.icon_state == "Beam") missile(/obj/Overworld/Hydro_Pump_Filler,HP.loc,get_step(HP,HP.dir))
			step(HP, HP.dir)
		sleep(2)

	frozen = 0
obj/Moves/Dragon_Claw
	Type = "Dragon"
	Range = "Physical"
	Power = 80
	PP = 15
	MPP = 15
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Dragon_Claw(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Dragon_Claw
	layer = 100
	icon = 'dragon claw.dmi'
	icon_state = "blank"
	pixel_x = -16
	pixel_y = -16
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Dragon_Claw(var/obj/Moves/M)
	var/obj/Overworld/Dragon_Claw/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("dragon claw", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/Dragon_Dance
	Type = "Dragon"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Dragon_Dance(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Dragon_Dance(var/obj/Moves/M)
	if(TempStats["ATK"] >= 6||TempStats["SPD"] >=6) return
	overlays += image('Moves.dmi',"Dance1")
	underlays += image('Moves.dmi',"Dance2")
	GiveTempStat(src,"ATK",1)
	GiveTempStat(src,"SPD",1)
	spawn(50)
		overlays -= image('Moves.dmi',"Dance1")
		underlays -= image('Moves.dmi',"Dance2")
	GiveTempStat(src,"ATK",-1,600)
	GiveTempStat(src,"SPD",-1,600)
obj/Moves/Dragon_Rage
	Type = "Dragon"
	Range = "Special"
	PP = 10
	MPP = 10
	Power = 120
	Wait_Time = 110
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Dragon_Rage(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Dragon_Rage
	icon = 'Dragon Rage.dmi'
	icon_state = "Dragon Rage"
	pixel_x = -9
	pixel_y = -9
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))

			var/mob/M = D
			M.DamageOverlay(40)
			M.HP = max(0,M.HP - 40)
			M.DeathCheck(owner)
			loc = M.loc
			density = 0
			del src


		else del src

mob/Pokemon/proc/Dragon_Rage(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Dragon_Rage/A = new(src.loc)
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)

//DreamEater//Dream Eater//----------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Dream_Eater
	Type = "Ghost"
	Range = "Special"
	Power = 90
	PP = 15
	MPP = 15
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Dream_Eater(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 7)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Dream_Eater
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "DreamEater[pick(1,2,3,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

mob/Pokemon/proc/Dream_Eater(var/obj/Moves/M)
	FindTarget()
	if(Target)
		var/mob/Pokemon/P = Target
		if(!isPokemon(P)) return
		if(P.Status != "Sleep")
			GetOwner(Owner)<<System("Dream Eater had no effect!")
			return
		if(get_dist(src,Target) > 3) return
		for(var/i=1, i<7, i++)
			var/obj/Overworld/Dream_Eater/A = new
			spawn(i)
				if(Target) missile(A, Target, src)
				del A
		if(Target) //Just in case the Target is gone(logs out) by the time the absorb's are done.
			var/Drain = BattleDamage(Target,M)
			Target.HP = max(0,Target.HP - Drain)
			HP = min(MHP, HP+ (Drain/4))
			Target.DeathCheck(src)

			if(prob(50))
				GetOwner(P.Owner)<<System("[P] awoke from it's sleep in a panic!")
	else
		M.PP +=1
		M.WaitTime = 0
		return

obj/Moves/Drill_Peck
	Type = "Flying"
	Range = "Physical"
	Power = 80
	PP = 35
	MPP = 35
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Drill_Peck(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Drill_Peck
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Drill_Peck(var/obj/Moves/M)
	var/obj/Overworld/Drill_Peck/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Drill Peck", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/DynamicPunch
	Type = "Normal"
	Range = "Physical"
	Power = 100
	PP = 5
	MPP = 5
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.DynamicPunch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/DynamicPunch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("d-punch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					if(isPokemon(MOB))
						var/mob/Pokemon/PPP = MOB
						spawn() PPP.Confuse(src)
					MOB.DeathCheck(src)
obj/Moves/Earthquake
	Type = "Ground"
	Range = "Physical"
	PP = 10
	MPP = 10
	Wait_Time = 400
	Power = 90
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Earthquake(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)

mob/Pokemon/proc/Earthquake(var/obj/Moves/M)
	var/list/Hit = list()
/*	for(var/mob/Watcher/W in view(src,20))
		spawn()
			var/mob/Player/P = W.Owner
			if(!isPlayer(P) || !P.client) continue
			for(var/i = 1, i <= 4, i++)
				for(var/j = 1, j <= 5, j++)
					switch(j)
						if(1) P.client.pixel_y = -16
						if(2) P.client.pixel_x = -16
						if(3)
							P.client.pixel_y = pick(-16,16)
							P.client.pixel_x = pick(-16,16)
						if(4) P.client.pixel_y = 16
						if(5) P.client.pixel_x = 16
					sleep(pick(1,2))
					P.client.pixel_y = 0
					P.client.pixel_x = 0*/
	for(var/i = 1, i <= 4, i++)
		var/obj/Overworld/Earthquake_Crack/EC = new
		switch(i)
			if(1) EC.loc = locate(x + rand(1,2), y + rand(1,2), z)
			if(2) EC.loc = locate(x - rand(1,2), y - rand(1,2), z)
			if(3) EC.loc = locate(x + rand(1,2), y - rand(1,2), z)
			if(4) EC.loc = locate(x - rand(1,2), y + rand(1,2), z)
		for(var/mob/Pokemon/PKMN in range(EC,2))
			if(PKMN.Ability == "Levitate") return
			else
				if(Hit.Find(PKMN)) continue
				Hit+= PKMN
				if(PKMN == src) continue
				flick(PKMN, "Pushback")
				PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
				PKMN.DeathCheck(src)
		flick("Crack", EC)
		sleep(3)



obj/Overworld/Earthquake_Crack
	icon = 'Moves.dmi'
	New()
		..()
		spawn(30) del src

//Egg Bomb//
obj/Moves/Egg_Bomb
//Ember//------------------
obj/Moves/Ember
	Type = "Fire"
	Range = "Special"
	Power = 15
	PP = 25
	MPP = 25
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Ember(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Ember
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
		var/obj/B
		for(var/i=0, i<9, i++)
			B = new
			B.pixel_y = rand(-16,16)
			B.pixel_x = rand(-16,16)
			B.icon_state = "Flame"
			src.overlays += B
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			if(isPokemon(M))
				var/mob/Pokemon/PPP = M
				if(prob(10)) PPP.Burn(src)
			var/obj/Moves/Ember/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)


		del src

mob/Pokemon/proc/Ember(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=0, i<3, i++)
		var/obj/Overworld/Ember/A = new(src.loc)
		for(var/obj/Overworld/SleepPowder/S in A.loc)
			del S
		A.owner = src
		A.dir = dir
		walk(A,A.dir,1)
		sleep(3)
	FindTarget()
obj/Moves
	Encore
	Endeavor
	Endure
	Eruption
obj/Moves/Explosion
	Type = "Normal"
	Range = "Physical"
	Power = 250
	PP = 5
	MPP = 5
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Explosion(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
mob/Pokemon/proc/Explosion(var/obj/Moves/M)
	var/area/A = loc.loc
	flick_overlay('Hypnosis.dmi',"Explosion",-16,-16)
	src.HP = src.HP - src.HP
	src.DeathCheck(src)
	for(var/mob/Pokemon/P in A)
		if(isPokemon(P) && P.Ability == "Damp") return
		P.HP = max(0,P.HP - BattleDamage(P,M))
		P.DeathCheck(src)
obj/Moves/Extrasensory
obj/Moves/Extremespeed
	Type = "Normal"
	Range = "Physical"
	Power = 80
	PP = 5
	MPP = 5
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Extremespeed(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,3,4)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"
				overlays += image('Moves.dmi',"A Ace")


mob/Pokemon/proc/Extremespeed(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	overlays += image('Moves.dmi',"A Ace")
	icon_state = "Quick Attack"
	NoRunDelay = 1
	frozen = 1
	for(var/i=1, i<5, i++)
		if(icon_state != "Quick Attack") break
		var/obj/Overworld/Scratch/S = new (src.loc)
		S.icon = icon
		S.layer = src.layer-1
		S.dir = dir

		spawn(10) del S
		flick("QStream", S)
		frozen = 0
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		frozen = 1

		sleep(1)
	if(icon_state == "Quick Attack") icon_state = null
	overlays -= image('Moves.dmi',"A Ace")
	frozen = 0
	NoRunDelay = 0
//Faint_Attack//
/*
obj/Moves/Faint_Attack
	Type = "Dark"
	PP = 20
	MPP = 20
	Power = 60
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Faint_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		if(ATK.Level <= 20) spawn() Attack()
		else
			var/CurrentHP = ATK.HP
			while(ATK.HP == CurrentHP)
				if(DEF.loc)
					if(get_dist(DEF,src) < 2) // If they are too close, step away
						step_away(src,DEF)
						sleep(max(1,ATK.GetSpeed()+1))
						if(DEF.loc) dir = get_dir(src,DEF)
					else if(get_dist(DEF,src) > 2) if(DEF.loc)
						ATK.Step_To(DEF)
			var/Attacking = 1
			spawn(0)
				Attack()
				Attacking = 0
			while(Attacking)
				sleep(max(1,ATK.GetSpeed()+1))
				ATK.Step_To(DEF)

	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDAA"
				src<<icon

obj/Overworld/Faint_Attack
	icon_state = "Faint"

mob/Pokemon/proc/Wait_Faint(var/obj/Moves/M) //This is for NPCs.
	set background = 1
	var/mob/Player/PP = GetOwner(Owner)
	FindTarget()
	var/Done = 0
	spawn(50) Done = 2
	while(!Done)
		sleep(2)
		if(!loc) Done = 2
		else if(get_dist(Target, src) <= 1)
			Done = 1

	dir = get_dir(src,Target)
	//They reappear
	if(PP && PP.client)
		for(var/image/i in PP.SavedImages)
			if(i.ID == "FaintAttack") del i

	AddMeter(1)
	if(invisibility == 10) invisibility = 0

	if(Done == 1)
		var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
		O.owner = src
		frozen = 1
		spawn(4) frozen = 0
		O.icon_state = "Blank"
		O.dir = dir
		flick("Physical", src)
		flick("Scratch", O)
		if(O.loc)
			spawn(0)
				for(var/mob/MOB in O.loc)
					if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
						MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
						MOB.DeathCheck(src)
			spawn(0)
				for(var/mob/MOB in get_step(O.loc,O.dir))
					if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
						MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
						MOB.DeathCheck(src)

mob/Pokemon/proc/Faint_Attack(var/obj/Moves/M)//This is the actual attack part
	var/mob/Player/PP = GetOwner(Owner)

	var/obj/Overworld/Faint_Attack/FA = new (loc)
	FA.icon = icon

	spawn(1)
		invisibility = 10
		AddMeter(0)
		if(PP.client)
			var/image/I = image(icon, src ,null,MOB_LAYER+1)
			I.layer = 62
			I.ID = "FaintAttack"
			PP << I
			PP.SavedImages += I



	Wait_Faint(M)
	del FA
*/

obj/Moves/
	Faint_Attack
	Fake_Out
	Fake_Tears
	False_Swipe
	FeatherDance

obj/Moves/Fire_Blast
	Type = "Fire"
	Range = "Special"
	Power = 120
	PP = 5
	MPP = 5
	Wait_Time = 400
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Fire_Blast(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Fire_Blast
	icon = 'Fireblast.dmi'
	icon_state = "Fireblast"
	pixel_x = -22
	pixel_y = -22
	layer = 100
	density = 0
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			if(isPokemon(M))
				var/mob/Pokemon/PPP = M
				if(prob(10)) PPP.Burn(src)
			var/obj/Moves/Fire_Blast/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			del A
			sleep(5)


		del src

mob/Pokemon/proc/Fire_Blast(var/obj/Moves/M)
	flick("Fire",src)
	var/obj/Overworld/Fire_Blast/A = new(src.loc)
	A.owner = src

	A.dir = dir
	for(var/i = 1, i<= 8, i++)
		step(A,A.dir)
		for(var/obj/Overworld/SleepPowder/S in A.loc)
			del S
		for(var/mob/MOB in view(1,A.loc))
			if(M.Hit.Find(MOB)) continue //They've been hit
			if(MOB == src) continue //Don't attack the attacker
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				if(!Status)
					if(prob(10))
						if(isPokemon(MOB))
							var/mob/Pokemon/PPP = MOB
							if(prob(10)) PPP.Burn(src)
				MOB.DeathCheck(src)


		sleep(2)
	del A
	M.Hit = list()
	FindTarget()
//Firepunch//Fire Punch//-----------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Fire_Punch
	Type = "Fire"
	Range = "Physical"
	Power = 75
	PP = 15
	MPP = 15
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Fire_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Fire_Punch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Fire Punch", O)
	var/list/DIR = list(1,2,4,5,6,8,9,10)
	for(var/i in DIR)
		spawn()
			var/obj/Overworld/Electricity/E = new(O.loc)
			E.icon = 'Moves.dmi'
			E.dir = i
			flick("Flame",E)
			step(E,E.dir)
			sleep(3)
			del E
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves/Fire_Spin
/*	Type = "Fire"
	Range = "Special"
	PP = 15
	MPP = 15
	Power = 35
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Fire_Spin(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Fire_Spin
	icon = 'Moves.dmi'
	icon_state = "Firespin"
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/M = D
			M.SecondaryStatus["Fire Spin"] = 1
			M.overlays += image('Moves.dmi', "Firespin")
			M.NoReturn = 1

			var/TimesFire = pick(2,5)
			var/obj/Moves/Fire_Spin/V = new

			for(var/i = 1, i<= TimesFire, i++)
				if(M.HP <= 0) break
				if(!M || !owner) break


				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				M.DeathCheck(owner)
				sleep(25)

			M.overlays -= image('Moves.dmi', "Firespin")
			M.SecondaryStatus["Fire Spin"] = 0
			M.NoReturn = 0
			del V
			del src


		else del src

mob/Pokemon/proc/Fire_Spin(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Fire_Spin/A = new(src.loc)
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)*/
obj/Moves/Fissure
//Flamethrower//

obj/Moves/Flamethrower
	Type = "Fire"
	Range = "Special"
	Power = 85 //Power was lowered as it is a wider ranged of area.
	PP = 15
	MPP = 15
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Flamethrower(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
			Hit = list()
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'


	Flamethrower
		var/obj/Moves/Base //This is the original Move being used.
		density = 1
		icon_state = "FlamethrowerHead" //This is for the head part, However it needs to be iconed.
		layer = 10
		Bump(var/atom/m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))

				var/mob/M = m
				if(Base.Hit.Find(M))
					return ..() //They've already taken damage for this attack.
				Base.Hit += M
				var/obj/Moves/Flamethrower/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			loc = m.loc

	FTExtra
		var/obj/Moves/Base //This is the original Move being used.
		density = 0
		icon_state = "Flamethrower"
		SteppedOn(var/atom/m)
			if(isPokemon(m) || isPlayer(m))

				var/mob/M = m
				if(Base.Hit.Find(M))
					return ..() //They've already taken damage for this attack.
				Base.Hit += M
				var/obj/Moves/Flamethrower/A = new
				A.Power = 60

				M.HP = max(0,M.HP - owner.BattleDamage(M,A))
				M.DeathCheck(owner)
				del A
				return ..()





mob/Pokemon/proc/Flamethrower(var/obj/Moves/M)
	var/obj/Overworld/Flamethrower/W = new(loc)
	M.Parts += W
	W.Base = M
	W.dir = dir
	var/SetDir = W.dir
	W.owner = src //Set the owner, so if damage is dealt, we know who gets experience
	frozen = 1
	spawn(5) if(W) W.density = 0
	icon_state = "Fire"
	while(W.density)
		var/obj/Overworld/FTExtra/E = new(W.loc)
		E.Base = M
		step(W,SetDir)
		if(length(M.Parts) == 2)
			E.icon_state = "Flamethrower" //This is for the first part, However it needs to be iconed.
		if(length(M.Parts) == 1)
			E.invisibility = 1
		E.layer = layer - 1
		E.owner = W.owner //Set the owner, so if damage is dealt, we know who gets experience
		M.Parts += E
		E.dir = SetDir
		sleep(1)
		if(!W) break
	sleep(30)

	for(var/obj/E in M.Parts)
		spawn()
			if(E)
				E.density = 0
				E.icon_state = "Blank"
				flick("Flamethrower",E) //This is for the fade part, however it needs to be iconed.
				sleep(6)
				del E
	spawn(6) del W
	M.Parts = list()
	if(icon_state == "Fire") icon_state = null
	frozen = 0
//FlameWheel//Flame Wheel//--------------------------------------------------------------------------------------------------
obj/Moves/Flame_Wheel
	Type = "Fire"
	Range = "Physical"
	Power = 60
	PP = 25
	MPP = 25
	Wait_Time = 300
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Flame_Wheel(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		var/F = 1
		spawn()
			while(F)
				dir = get_dir(ATK,DEF)
				sleep(2)
		Attack() //Do This!!!
		F = 0



mob/Pokemon/
	proc/Flame_Wheel(var/obj/Moves/M)
		set background = 1
		if(Rolling) return //In case they are doing another attack already involving the Rolling var.
		var/mob/Player/O = GetOwner(Owner)
		NoRunDelay = 1
		Rolling = 1
		spawn(110) Rolling = 0
		var/Counter = 0
		overlays += image('Moves.dmi', "Flame Wheel Build")
		while(Rolling)
			Counter += 1
			if(Status == "Sleep") break

			if(Counter == 11)
				overlays -= image('Moves.dmi', "Flame Wheel Build")
				overlays += image('Moves.dmi', "Flame Wheel")
				icon_state = "Blank"

			if(O)
				if(O.client)
					if(get_step(src,dir) in view(O.client)) step(src,dir)
				else step(src,dir)
			else step(src,dir)

			if(Counter <= 10) sleep(2)
			else sleep(1)
		overlays -= image('Moves.dmi', "Flame Wheel Build")
		overlays -= image('Moves.dmi', "Flame Wheel")
		if(icon_state == "Blank") icon_state = null
		NoRunDelay = 0

obj/Moves
	Flail
	Flatter
//Focus Energy//
	Focus_Energy
	Focus_Punch
	Follow_Me
	Foresight
//Fury Attack//
obj/Moves/Fury_Attack
	Type = "Normal"
	Range = "Physical"
	Power = 15
	PP = 20
	MPP = 20
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Fury_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))
				var/L = 1
				spawn() while(L)
					ATK.Step_To(DEF)
					sleep(SPEED)

				Attack()
				L = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Fury_Attack
	layer = 100
	icon = 'Fury attack.dmi'
	pixel_x = -32
	pixel_y = -32



mob/Pokemon/proc/Fury_Attack(var/obj/Moves/M)
	var/Times
	Times = pick(2,2,3,3,4,5)

	for(var/i = 1, i <= Times, i ++)
		frozen = 1
		spawn(5) frozen = 0
		var/list/Turfs = list() //Find where the attack will go.
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)
		var/obj/Overworld/Fury_Attack/Hand = new(get_step(src,dir))
		Hand.dir = dir
		flick("Fury Attack",Hand)
		Hand.owner = src
		M.Parts += Hand
		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(10)
		del Hand
		sleep(4)
obj/Moves/Fury_Swipes
	Type = "Normal"
	Range = "Physical"
	Power = 18
	PP = 15
	MPP = 15
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Fury_Swipes(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))
				var/L = 1
				spawn() while(L)
					ATK.Step_To(DEF)
					sleep(SPEED)

				Attack()
				L = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Fury_Swipes
	layer = 100
	icon = 'Moves.dmi'



mob/Pokemon/proc/Fury_Swipes(var/obj/Moves/M)
	var/Times
	Times = pick(2,2,3,3,4,5)

	for(var/i = 1, i <= Times, i ++)
		frozen = 1
		spawn(5) frozen = 0
		var/list/Turfs = list() //Find where the attack will go.
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)
		var/obj/Overworld/Fury_Swipes/Hand = new(get_step(src,dir))
		Hand.dir = dir
		flick("Fury Swipes",Hand)
		Hand.owner = src
		M.Parts += Hand
		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(10)
		del Hand
		sleep(4)
obj/Moves
	Fury_Cutter
	Future_Sight
//Giga_Drain//----------
obj/Moves/Giga_Drain
	Type = "Grass"
	Range = "Special"
	Power = 60
	PP = 5
	MPP = 5
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Giga_Drain(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 7)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Giga_Drain
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "Leech[pick(1,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

mob/Pokemon/proc/Giga_Drain(var/obj/Moves/M)
	FindTarget()
	if(Target)
		if(get_dist(src,Target) >5) return
		for(var/i=1, i<7, i++)
			var/obj/Overworld/Giga_Drain/A = new
			spawn(i)
				if(Target) missile(A, src, Target)
				del A
		if(Target) //Just in case the Target is gone(logs out) by the time the absorb's are done.
			var/Drain = BattleDamage(Target,M)
			Target.HP = max(0,Target.HP - Drain)
			HP = min(MHP, HP+ (Drain/2))
			Target.DeathCheck(src)
	else
		M.PP +=1
		M.WaitTime = 0
		return
//Glare//----------------
obj/Moves/Glare
	Type = "Normal"
	Range = "Status"
	PP = 30
	MPP = 30
	Wait_Time = 300
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Glare(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

mob/Pokemon/proc/Glare(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(!P || !istype(P,/mob/Pokemon)) return
	var/obj/O = new
	O.icon = 'Glare2.dmi'
	O.icon_state = "Glare"
	O.layer = 100
	overlays += O
	spawn(30) overlays -= O
	spawn() P.Paralysis(src)

obj/Moves/GrassWhistle
//Growl//------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Growl
	Type = "Normal"
	Range = "Status"
	Power = 35
	PP = 35
	MPP = 35
	Wait_Time = 50
	Distance = "Projectile"
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Growl(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Growl
	icon = 'Moves.dmi'
	icon_state = "Note"

mob/Pokemon/proc/Growl(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(isPokemon(P) && P.Ability == "Clear Body") return
	if(!P || !istype(P,/mob/Pokemon)) return
	if(P.Owner == Owner || P.TempStats["ATK"] <= -5) return
	spawn() missile(/obj/Overworld/Growl, src, P)
	P.GiveTempStat(src,"ATK",-1)
	if(P)
		P.GiveTempStat(src,"ATK",1,600)
		if(!P.Target) P.Target = src

//Growth//-------------------------------------------------------------------------------------------------------------------------
obj/Moves/Growth
	Type = "Normal"
	Range = "Status"
	PP = 40
	MPP = 40
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Growth(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
obj/Overworld/Growth
	icon = 'Growth.dmi'
	pixel_y = -8
	pixel_x = -8
mob/Pokemon/proc/Growth(var/obj/Moves/M)
	var/obj/Overworld/Growth/G = new
	G.icon_state = "Growth"
	overlays += G
	if(TempStats["SPL ATK"] >= 6) return
	GiveTempStat(src,"SPL ATK",1)
	GiveTempStat(src,"SPL ATK",-1,600)
	sleep(20)
	overlays -= G


obj/Moves/
	Grudge
	Guillotine
//Gust//----------------------------------------------------------------------------------------------------------------------
/obj/Moves/Gust
	Type = "Flying"
	Range = "Special"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Gust(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Gust
	density = 0
	icon = 'Fireblast.dmi'
	icon_state = "Gust"
	pixel_x = -22
	New()
		spawn(20)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)




mob/Pokemon/proc/Gust(var/obj/Moves/M)
	flick("Gust",src)
	var/obj/Overworld/Gust/G = new
	var/list/Hit = list()
	G.loc = loc
	G.owner = src
	FindTarget()
	var/atom/T
	if(Target) T = Target.loc
	if(Target)
		while(G)
			sleep(3)
			if(!G) break //In case G is deleted in that .3 seconds.
			step_towards(G,T)
			for(var/mob/MR in G.loc)
				if(Hit.Find(MR)) continue
				Hit += MR
				MR.HP = max(0,MR.HP - src.BattleDamage(MR,M))
				MR.DeathCheck(src)
				G.loc = MR.loc
				walk(G,0)
				G.density = 0
				spawn(10)
					del G
					return //If G is deleted, and for some reason the loop continues, it calls on null.loc. This should stop both loops if this happens..
			for(var/obj/Overworld/OO in range(G,2))
				if(istype(OO,/obj/Overworld/SleepPowder) || istype(OO,/obj/Overworld/PoisonPowder)|| istype(OO,/obj/Overworld/StunSpore))
					OO.owner = src
					step_away(OO,G)
	else
		var/D = src.dir
		while(G)
			sleep(3)
			step(G,D)
			for(var/obj/Overworld/OO in range(G,2))
				if(istype(OO,/obj/Overworld/SleepPowder) || istype(OO,/obj/Overworld/PoisonPowder))
					step_away(OO,G)

//Hail//-----------------------------------------------------------------------------------------------------------
obj/Moves/Hail
	Type = "Ice"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 1000
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Hail(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)

mob/Pokemon/proc/Hail(var/obj/Moves/M)




//Harden//------------------------------------------------------------------------------------------------------------
obj/Moves/Harden
	Type = "Normal"
	Range = "Status"
	PP = 30
	MPP = 30
	Wait_Time = 300
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Harden(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Harden(var/obj/Moves/M)
	if(TempStats["DEF"] >= 6) return
	flick("Harden",src)
	GiveTempStat(src,"DEF",1)
	spawn(50) if(icon_state == "Withdraw") icon_state = null
	GiveTempStat(src,"DEF",-1,650) //Waits 1 minute before returning the stat.

obj/Moves/Haze
obj/Moves/Headbutt
	Type = "Normal"
	Range = "Physical"
	Power = 70
	PP = 15
	MPP = 15
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Headbutt(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/Headbutt(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<4, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
obj/Moves/Heat_Wave
	Type = "Fire"
	Range = "Special"
	PP = 10
	MPP = 10
	Power = 80
	Wait_Time = 160
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Heat_Wave(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Heat_Wave
	icon = 'Moves.dmi'
	icon_state = "Heat Wave"
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/obj/Moves/Heat_Wave/A = new

			var/mob/M = D
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			density = 0 //Its already damaged one Pokemon, so forget doing anymore damage.



		else del src

mob/Pokemon/proc/Heat_Wave(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Heat_Wave/A = new(get_step(src.loc,turn(dir,i)))
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)
	FindTarget()
obj/Moves
	Heal_Bell
	Helping_Hand
	Hidden_Power
	Hi_Jump_Kick
//Horn Attack//HornAttack//-----------------------------------------------------------------------------------------------------------------
obj/Moves/Horn_Attack
	Type = "Normal"
	Range = "Physical"
	Power = 55
	PP = 25
	MPP = 25
	Wait_Time = 85
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Horn_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUD Horn"
obj/Overworld/Horn_Attack
	icon_state = "Horn"

	New()
		spawn(50)
			del src
		..()


mob/Pokemon/proc/Horn_Attack(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	var/obj/Overworld/Horn_Attack/H = new(get_step(src, dir)) //The Horn appears in front of them.
	H.icon = icon
	NoRunDelay = 1
	//Tackle Part
	if(O)
		if(O.client)
			if(get_step(src,SetDir) in view(O.client))
				step(src,SetDir)
				missile(H, src, get_step(H, SetDir))
				step(H,SetDir)
		else
			step(src,SetDir)
			missile(H, src, get_step(H, SetDir))
			step(H,SetDir)
	else
		step(src,SetDir)
		missile(H, src, get_step(H, SetDir))
		step(H,SetDir)
	sleep(2)
	// Horn Part
	spawn(0)
		for(var/mob/MOB in H.loc)
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	spawn(0)
		for(var/mob/MOB in get_step(H.loc,H.dir))
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	M.Hit = new/list

	spawn(10) del H
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
//   //-----------------------------------------------------------------------------------------------------------------------
obj/Moves/Horn_Drill
	Type = "Normal"
	Range = "Physical"
	Power = 40
	PP = 5
	MPP = 5
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Horn_Drill(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/Horn_Drill(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Horn Drill", O)
	if(O.loc)
		spawn(0)
			for(var/mob/Pokemon/P in O.loc)
				if(prob(src.Level - P.Level + 30))
					P.HP = max(0,P.HP - P.HP)
					P.DeathCheck(src)
obj/Moves/Howl
//Hydro Pump//Hydropump//------------------------------------------------------------------------------------------------

obj/Moves/Hydro_Pump
	Type = "Water"
	Range = "Special"
	Power = 110
	PP = 5
	MPP = 5
	Wait_Time = 270
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Hydro_Pump(src)
			if(P) P.UsingAttack = null
		spawn(10)
			for(var/obj/D in Parts)
				del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()




obj/Overworld/
	icon = 'Moves.dmi'

	Hydro_Pump
		pixel_y = -16
		pixel_x = -16
		icon = 'Hydro Pump.dmi'
		icon_state = "Beam"
		layer = 21
		proc/FindDamaged()

	Hydro_Pump_Filler
		pixel_y = -16
		pixel_x = -16
		icon = 'Hydro Pump.dmi'
		icon_state = "Filler"
		layer = 20


mob/Pokemon/proc/Hydro_Pump(var/obj/Moves/M)
	icon = initial(icon)
	if(HP <= 0 || Status == "Sleep" || !loc) return
	var/obj/Overworld/Hydro_Pump/W = new(get_step(loc,dir))
	W.icon_state = "Head"
	M.Parts += W
	W.dir = dir
	W.owner = src
	frozen = 1
	flick("Fire",src)
	var/count = 0
	var/list/Damaged = list()
	while(W)
		if(count >= 10) break
		var/obj/Overworld/Hydro_Pump/HPE
		count += 1
		if(IsEven(count))
			HPE = new(get_step(loc,dir))
			HPE.dir = dir
			HPE.owner = src
			M.Parts += HPE
		//Do Damage
		for(var/mob/MOB in view(1,W))
			if(MOB == src) continue
			if(!Damaged.Find(MOB))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
				Damaged += MOB

				if(isPokemon(MOB))
					var/mob/Pokemon/POKE = MOB
					POKE.Pushback(null,5,W.dir)




		for(var/obj/HP in M.Parts)
			//if(HP.icon_state == "Beam") missile(/obj/Overworld/Hydro_Pump_Filler,HP.loc,get_step(HP,HP.dir))
			step(HP, HP.dir)
		sleep(2)

	frozen = 0
	/*
		var/obj/Overworld/SBExtra/E = new(W.loc)
		var/obj/Overworld/SBExtra/EE = new(get_step(W.loc,turn(dir,-90)))
		E.dir = W.dir
		EE.dir = W.dir
		if(dir == 8)
			E.pixel_y = -16
			EE.pixel_y = -16
		if(dir == 4)
			E.pixel_y = 16
			EE.pixel_y = 16
		if(dir == 1)
			E.pixel_x = -16
			EE.pixel_x = -16
		if(dir == 2)
			E.pixel_x = 16
			EE.pixel_x = 16
		//Collect the Turfs that will do damage
		Turfs += W.loc
		Turfs += get_step(W.loc,turn(dir,-90))
		Turfs += get_step(W.loc,turn(dir,90))
		//Add the Extras to the Parts Var
		M.Parts += E
		M.Parts += EE
		E.icon_state = "SolarBeamTop"
		EE.icon_state = "SolarBeamBottom"
		step(W,SetDir)
		E.owner = W.owner
		E.owner = W.owner
		sleep(1)
		spawn()
			for(var/turf/T in Turfs)
				for(var/mob/Pokemon/P in T)
					if(P == src || Damaged.Find(P)) continue
					P.HP = max(0,P.HP - BattleDamage(P,M))
					P.DeathCheck(src)
					Damaged += P

		if(!W) break

	del W
	spawn(3)
		for(var/obj/E in M.Parts)
			spawn()
				var/L = "[E.icon_state]Fade"
				E.icon_state = "Blank"
				flick("[L]",E)
				sleep(4)
				del E
	frozen = 0
	Target = null
	return*/


obj/Moves
	Hyper_Beam
obj/Moves/Hyper_Fang
	Type = "Normal"
	Range = "Physical"
	Power = 80
	PP = 15
	MPP = 15
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Hyper_Fang(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



mob/Pokemon/proc/Hyper_Fang(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Hyper Fang", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/Hyper_Voice
//Hypnosis //----------------------------------------------------------------------------------------------------------------------
obj/Moves/Hypnosis
	Type = "Psychic"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 240
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Hypnosis(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				var/H = 1
				spawn(300) H = 0 //This is a safety. For some reason this was never ending.
				spawn()
					while(H && DEF.Status != "Sleep")
						ATK.Step_To(DEF)
						sleep(SPEED)
				Attack()
				H = 0
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Hypnosis
	icon = 'Hypnosis.dmi'
	icon_state = "Hypnosis"
	layer = 100
	pixel_y = -16
	pixel_x = -16



mob/Pokemon/proc/Hypnosis(var/obj/Moves/M)
	var/list/Saved = list()
	var/obj/Overworld/Hypnosis/H = new
	overlays += H
	TEMPSpeed = 3
	for(var/i = 1, i <= 6, i++)
		for(var/mob/Pokemon/P in view(src,1))
			if(P == src || P.Status || Saved.Find(P)) continue
			var/mob/Player/O1 = GetOwner(Owner)
			var/mob/Player/O2 = GetOwner(P.Owner)
			if(O1.Court != O2.Court || !O1.Court  || !O2.Court)
				continue
			if(P.LastSlept)
				if(world.timeofday - P.LastSlept < 1200)
					if(prob(40))
						Saved += P
						continue

			spawn() if(prob(60)) P.Sleep(src)
		sleep(10)
	TEMPSpeed = 0
	overlays -= H
//Ice Ball//Iceball//Ice_Ball//
obj/Moves/Ice_Ball
//IceBeam//Ice Beam//------------------------------------------------------------------------------------------
obj/Moves/Ice_Beam
	Type = "Ice"
	Range = "Special"
	Power = 95
	PP = 10
	MPP = 10
	Wait_Time = 190
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Ice_Beam(src)
			if(P) P.UsingAttack = null
			spawn(20) for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack() //Why is this here?....


obj/Overworld/
	icon = 'Moves.dmi'
	Ice_Beam
		density = 1
		invisibility = 1
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Ice_Beam/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				if(isPokemon(M))
					var/mob/Pokemon/P = M
					if(prob(10)) P.Frozen(owner)
				M.DeathCheck(owner)
			loc = null

	IBExtra
		density = 1
		icon_state = "Ice Beam"
		New()
			spawn(100) del src //Incase something fucks up.


mob/Pokemon/proc/Ice_Beam(var/obj/Moves/M)
	var/obj/Overworld/Ice_Beam/V = new(loc)
	M.Parts += V
	V.dir = dir
	var/SetDir = V.dir
	V.owner = src
	icon_state = "Fire"
	spawn(8) if(V) V.loc = null

	while(V.loc)
		step(V,SetDir)
		if(V)
			var/obj/Overworld/IBExtra/E = new(V.loc)
			E.layer = layer - 1
			E.owner = V.owner
			M.Parts += E
			E.dir = SetDir
			sleep(1)
			//if(V) if(V.loc) sleep(1)
	del V
	for(var/obj/E in M.Parts)
		spawn()
			E.density = 0
			flick("Ice Beam Disipate",E)
			sleep(4)
			del E

	if(icon_state == "Fire") icon_state = null

//Ice Punch//IcePunch//----------------------------------------------------------------------------------------------------------------------------
obj/Moves/Ice_Punch
	Type = "Ice"
	Range = "Physical"
	Power = 75
	PP = 15
	MPP = 15
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Ice_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()




mob/Pokemon/proc/Ice_Punch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Ice Punch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/Icicle_Spear
	Type = "Ice"
	Range = "Physical"
	Distance = "Projectile"
	Power = 25
	PP = 30
	MPP = 30
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Icicle_Spear(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Icicle_Spear
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	icon_state = "Icicle Spear"
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(!owner) return
			var/mob/M = D
			var/obj/Moves/Icicle_Spear/A = new
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			sleep(5)
			del A
		del src

mob/Pokemon/proc/Icicle_Spear(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=0, i<4, i++)
		var/obj/Overworld/Icicle_Spear/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
		sleep(3)
	FindTarget()
obj/Moves/Icy_Wind
	Type = "Ice"
	Range = "Special"
	Power = 55
	PP = 15
	MPP = 15
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Icy_Wind(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Scratch
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Icy_Wind(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Fire", src)
	flick("Icy Wind", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					var/mob/Pokemon/P = MOB
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
					if(P.TempStats["SPD"] <= -5) return
					P.GiveTempStat(src,"SPD",-1)
					if(P) P.GiveTempStat(src,"SPD",1,600)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					var/mob/Pokemon/P = MOB
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
					if(P.TempStats["SPD"] <= -5) return
					P.GiveTempStat(src,"SPD",-1)
					if(P) P.GiveTempStat(src,"SPD",1,600)
obj/Moves
	Imprison
	Ingrain
obj/Moves/Iron_Defence
	New()
		spawn(20)
			overlays = null
			icon_state = null
			if(Owner)
				icon = Owner.icon
	Type = "Steel"
	Range = "Status"
	PP = 15
	MPP = 15
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Iron_Defence(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Iron_Defence(var/obj/Moves/M)
	if(TempStats["DEF"] >= 6) return
	icon_state = "Withdraw"
	GiveTempStat(src,"DEF",2)
	spawn(50) if(icon_state == "Withdraw") icon_state = null
	GiveTempStat(src,"DEF",-2,650) //Waits 1 minute before returning the stat.
obj/Moves
	Iron_Tail

	Jump_Kick
//Karate Chop//
obj/Moves/Karate_Chop
	CriticalHit = 12.5
	Type = "Fighting"
	Range = "Physical"
	Power = 50
	PP = 25
	MPP = 25
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Karate_Chop(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Karate_Chop
	layer = 100
	icon = 'More fighting.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Karate_Chop(var/obj/Moves/M)
	var/obj/Overworld/Karate_Chop/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Karate Chop", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves
	Kinesis
	Knock_Off
obj/Moves/Leaf_Blade
	Type = "Grass"
	Range = "Physical"
	Power = 90
	PP = 30
	MPP = 30
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Leaf_Blade(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x-1 == DEF.x || ATK.x+1 == DEF.x || ATK.y+1 == DEF.y || ATK.y-1 == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Leaf_Blade(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Wing_Attack/W = new(get_step(src,turn(dir,90)))
	var/obj/Overworld/Wing_Attack/WW = new(get_step(src,turn(dir,-90)))
	W.icon = 'Moves.dmi'
	flick("Leaf Blade1",W)
	WW.icon = 'Moves.dmi'
	flick("Leaf Blade2",WW)
	icon_state = "Tackle"
	frozen = 1
	NoRunDelay = 1
	for(var/i=1, i<6, i++)
		W.dir = dir
		WW.dir = dir
		for(var/mob/Pokemon/PKMN in W.loc)
			if(PKMN == src) continue
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		for(var/mob/Pokemon/PKMN in WW.loc)
			if(PKMN == src) continue
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		frozen = 0
		if(!O)
			step(src,dir)
		if(O) if(get_step(O.ControlingPokemon,dir) in view(O.client))
			step(src,dir)
		frozen = 1

		W.loc = get_step(src,turn(dir,90))
		WW.loc = get_step(src,turn(dir,-90))
		sleep(pick(1,0))
	frozen = 0
	del WW
	del W
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0



//Leech Life//---------------------------------------------------------------------------------------------------------------
obj/Moves/Leech_Life
	Type = "Bug"
	Range = "Physical"
	Power = 40
	PP = 15
	MPP = 15
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Leech_Life(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (IsBetween(ATK.x, DEF.x-1,DEF.x+1) || IsBetween(ATK.y, DEF.y-1,DEF.y+1)))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Leech_Bubble
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "Life[pick(1,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

obj/Overworld/Leech_Life
	icon = 'Moves.dmi'
	icon_state = "Leech Needle"
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/mob/M = D
			if(M == owner) del src
			//This is the Animation//-----------------
			for(var/i=1, i<7, i++)
				var/obj/Overworld/Leech_Bubble/L = new
				spawn(i)
					if(owner) missile(L, M, owner)
					del L
			//-----------------------------------------
			var/obj/Moves/Leech_Life/A = new
			var/Damage = owner.BattleDamage(M,A)
			owner.HP = min(owner.MHP, owner.HP + (Damage/2))
			M.HP = max(0,M.HP - Damage)
			M.DeathCheck(owner)

			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)

		del src

mob/Pokemon/proc/Leech_Life(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i = -45, i <= 45, i+=45)
		var/obj/Overworld/Leech_Life/A = new(get_step(src,turn(dir,i)))
		for(var/mob/P in A.loc)
			A.Bump(P)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
	if(!Target) FindTarget()
//Leech Seed//---------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Leech_Seed
	Type = "Grass"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Leech_Seed(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			if(get_dist(ATK, DEF) == 3)
				ATK.dir = get_dir(ATK,DEF)
				Attack()
				return
			ATK.dir = get_dir(ATK,DEF)
			sleep(1)





mob/Pokemon/proc/
	Leech_Drain(var/mob/Pokemon/P, var/obj/Moves/M) //Where P is the killer, src is the one being drained
		set background = 1
		spawn(rand(1,20))
			if(Type1 == "Grass" || Type2 == "Grass" || SecondaryStatus["Leeched"]) return //This move does not work against Grass types.
			var/Done = 1
			SecondaryStatus["Leeched"] = P
			var/mob/Player/O = GetOwner(P.Owner)
			while(Done)
				var/mob/Pokemon/R
				var/mob/Pokemon/Giver = SecondaryStatus["Leeched"]
				//Is the Pokemon okay...
				if(!SecondaryStatus["Leeched"]) //Somehow they've gotten rid of the status..
					break
				if(HP <= 0 || Giver.HP <= 0) //They aren't suited for battle.
					break
				if(!O.Court) //The Battle has ended.
					break
				if(!loc) //Pokeball? We can wait.
					sleep(100)
					continue
				//Find the P
				if(P.HP >= 1 && get_dist(P,src) < 15 && P.loc) //Make sure the P is on the field.
					R = P
				else //Find the predecessor
					if(!O) break
					if(TotalHealth(O.Party) <= 100) break
					for(var/mob/Pokemon/p in O.Party)
						if(p.HP >= 1 && get_dist(p,src) < 15 && p.loc)
							R = p
							break
				if(!R)
					sleep(100)
					continue //No one to give energy too..


				if(R) //Just in case the person logs out before the bubbles are done
					for(var/i=1, i<7, i++)
						var/obj/Overworld/Absorb/A = new
						spawn(i)
							if(Target) missile(A, src, R)
							del A
					var/Drain = round(src.MHP / 8)
					if(HP < MHP/16) Drain = 1

					HP = max(0,HP - Drain)

					R.HP = min(R.MHP, R.HP + round(Drain/2))

					O.UpdateParty()
					DeathCheck(P)
				sleep(100)
			SecondaryStatus["Leeched"] = 0




	Leech_Seed(var/obj/Moves/M)
		var/obj/Overworld/Leech_Seed/LS = new (src.loc)
		walk(LS,dir,1)
		sleep(3)
		walk(LS,0)
		for(var/turf/T in view(src))
			if(get_dist(LS,T) <= 1)
				spawn(1)
					var/obj/Overworld/Leech_Sprout/LSp = new (T)
					flick(LSp, "Leech Plant")
					for(var/mob/Pokemon/P in T)
						if(!SecondaryStatus["Leeched"]) P.Leech_Drain(src,M)
					spawn(8) del LSp

		del LS
obj/Overworld/
	icon = 'Moves.dmi'
	Leech_Seed
		icon_state = "Leech Seed"

	Leech_Sprout
		icon_state = "Leech Plant"
		layer = 100

//Leer//-------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Leer
	Type = "Normal"
	Range = "Status"
	Power = 35
	PP = 35
	MPP = 35
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Leer(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

mob/Pokemon/proc/Leer(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(isPlayer(P) && P.Ability == "Clear Body") return
	if(!P || !istype(P,/mob/Pokemon)) return
	if(P.Owner == Owner || P.TempStats["DEF"] <= -5) return
	var/obj/O = new
	O.icon = 'Moves.dmi'
	O.icon_state = "Leer"
	O.layer = 100
	overlays += O
	spawn(30) overlays -= O

	P.GiveTempStat(src,"DEF",-1)
	if(P) P.GiveTempStat(src,"DEF",1,600)
	if(!P.Target) P.Target = src
//Lick//---------------------------------------------------------------------------------------------------------------
obj/Moves/Lick
	Type = "Ghost"
	Range = "Physical"
	Power = 20
	PP = 30
	MPP = 30
	Wait_Time = 40
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Lick(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Lick(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Lick", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					if(!Status)
						if(prob(30))
							if(isPokemon(MOB))
								var/mob/Pokemon/PPP = MOB
								spawn() if(PPP.Type1 != "Normal" || PPP.Type2 != "Normal") PPP.Paralysis(src)
					MOB.DeathCheck(src)



obj/Moves/Light_Screen
	Type = "Psychic"
	Range = "Status"
	PP = 30
	MPP = 30
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Light_Screen(src)
			if(P) P.UsingAttack = null

obj/Overworld/Light_Screen
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	BumpedInto(D)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			return 0
		else
			return 1
	New()
		spawn(600) del src

mob/Pokemon/proc/Light_Screen(var/obj/Moves/M)
	for(var/i = -45, i <= 45, i+= 45)
		var/obj/Overworld/Light_Screen/L1 = new (get_step(src,turn(src.dir,i)))
		L1.icon_state = "Light Shield"
		M.Parts += L1
		L1.dir = dir

obj/Moves
	Lock_On
	Lovely_Kiss
//Low Kick//-------------------------------------------------------------------------------------------------------------------
obj/Moves/Low_Kick
	Type = "Fighting"
	Range = "Physical"
	Power = 30
	PP = 20
	MPP = 20
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Low_Kick(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y > DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(get_step(DEF, 1))
			sleep(SPEED)
		Attack()


obj/Overworld/Low_Kick
	layer = 100
	icon = 'Low Kick.dmi'
	New()
		flick("Low Kick",src)
		spawn(50) del src


mob/Pokemon/proc/Low_Kick(var/obj/Moves/M)
	var/obj/Overworld/Low_Kick/OO = new(get_step(src,turn(2,-45)))
	for(var/i = 1, i <= 2, i++)
		var/list/Turfs = list() //Find where the attack will go.
		dir = 2
		Turfs += get_step(src,dir)
		Turfs += get_step(src,turn(dir,45))
		Turfs += get_step(src,turn(dir,-45))
		flick("Physical",src)


		for(var/atom/A in Turfs)
			spawn() for(var/mob/Pokemon/p in A) //Check for Pokemon
				if(p == src) continue
				M = new/obj/Moves/Low_Kick
				switch(p.Weight)
					if(0.1 to 22) M.Power = 20
					if(22.1 to 55) M.Power = 40
					if(55.1 to 110) M.Power = 60
					if(110.1 to 220) M.Power = 80
					if(220.1 to 440) M.Power = 100
					if(440.1 to 2000) M.Power = 120
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
				del M
			spawn() for(var/mob/Player/p in A) //Check for Players
				if(p == src) continue
				p.HP = max(0, p.HP - BattleDamage(p, M))
				if(!Target) Target = p
				p.DeathCheck(src)
		sleep(3)
		step(src,2)
		step(OO,2)
		spawn(50)
			if(OO) del OO

obj/Moves/Mach_Punch
	Type = "Fighting"
	Range = "Physical"
	Power = 40
	PP = 30
	MPP = 30
	Wait_Time = 30
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Mach_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Mach_Punch
	layer = 100
	icon = 'Mach Punch.dmi'
	icon_state = "blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Mach_Punch(var/obj/Moves/M)
	var/obj/Overworld/Mach_Punch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("mach punch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves
	Magic_Coat
	Magical_Leaf
	Magnitude
obj/Moves/Meditate
	Type = "Normal"
	Range = "Status"
	PP = 40
	MPP = 40
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Meditate(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Meditate(var/obj/Moves/M)
	if(TempStats["ATK"] >= 6) return
	overlays += image('Moves.dmi',"Meditate")
	GiveTempStat(src,"ATK",1)
	icon_state = "Meditate"
	spawn(50)
		overlays -= image('Moves.dmi',"Meditate")
		if(icon_state == "Meditate") icon_state = null
	GiveTempStat(src,"ATK",-1,600) //Waits 1 minute before returning the stat.
obj/Moves/Mean_Look
	Type = "Normal"
	Range = "Status"
	PP = 5
	MPP = 5
	Wait_Time = 400
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Mean_Look(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

mob/Pokemon/proc/Mean_Look(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(!P || !istype(P,/mob/Pokemon)) return
	var/obj/O = new
	O.icon = 'Moves.dmi'
	O.icon_state = "Mean Look"
	O.layer = 100
	overlays += O
	spawn(30) overlays -= O

	P.NoReturn = 1
	sleep(600)
	P.NoReturn = 0
	if(!P.Target) P.Target = src
obj/Moves/Mega_Drain
	Type = "Grass"
	Range = "Special"
	Power = 40
	PP = 15
	MPP = 15
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Mega_Drain(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 7)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Mega_Drain
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "Leech[pick(1,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

mob/Pokemon/proc/Mega_Drain(var/obj/Moves/M)
	FindTarget()
	if(Target)
		if(get_dist(src,Target) >4) return
		for(var/i=1, i<7, i++)
			var/obj/Overworld/Mega_Drain/A = new
			spawn(i)
				if(Target) missile(A, src, Target)
				del A
		if(Target) //Just in case the Target is gone(logs out) by the time the absorb's are done.
			var/Drain = BattleDamage(Target,M)
			Target.HP = max(0,Target.HP - Drain)
			HP = min(MHP, HP+ (Drain/2))
			Target.DeathCheck(src)
	else
		M.PP +=1
		M.WaitTime = 0
		return

obj/Moves
	Mega_Kick
	Mega_Punch
obj/Moves/Megahorn
	Type = "Bug"
	Range = "Physical"
	Power = 120
	PP = 10
	MPP = 10
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Megahorn(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/Megahorn(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Megahorn", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
//Metal Claw//Metalclaw//-----------------------------------------------------------------------------------------------------------------
obj/Moves/Metal_Claw
	Type = "Steel"
	Range = "Physical"
	Power = 50
	PP = 35
	MPP = 35
	Wait_Time = 75
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Metal_Claw(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/Metal_Claw(var/obj/Moves/M)
	var/obj/Overworld/Slash/O = new(get_step(src,turn(src.dir, -90)))
	M.CriticalHit = 6.25
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	switch(O.dir)
		if(2) O.pixel_y = -64
		if(8) O.loc = locate(x - 2, y - 1, z)
		if(1) O.loc = locate(x - 1, y, z)
	var/list/Turfs = list()
	Turfs += get_step(src,turn(src.dir, 90))
	Turfs += get_step(src,turn(src.dir, -90))
	var/turf/TTT = get_step(src,src.dir)
	Turfs += TTT
	Turfs += get_step(TTT,turn(src.dir, -45))
	Turfs += get_step(TTT,turn(src.dir, 45))

	flick("Physical", src)
	flick("Metal Claw", O)
	if(O.loc)
		spawn(0)
			for(var/turf/T in Turfs)
				for(var/mob/MOB in T)
					if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
						if(T == TTT) M.CriticalHit = 50 //If its the center tile, it could be a critical hit!
						MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
						MOB.DeathCheck(src)
						M.CriticalHit = 6.25
obj/Moves
	Metal_Sound
	Meteor_Mash
obj/Moves/Metronome
/*	Type = "Normal"
	Range = "Status"
	PP = 5
	MPP = 5
	Wait_Time = 40
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Metronome(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
mob/Pokemon/proc/Metronome(var/obj/Moves/M)
	var/list/BannedAttacks = list(/obj/Moves/Counter, /obj/Moves/Metronome, /obj/Moves/Selfdestruct, /obj/Moves/Explosion,/obj/Moves/Covet,/obj/Moves/Destiny_Bond,/obj/Moves/Detect,/obj/Moves/Endure,/obj/Moves/Focus_Punch,/obj/Moves/Helping_Hand,/obj/Moves/Mimic,/obj/Moves/Mirror_Coat,/obj/Moves/Protect,/obj/Moves/Sketch,/obj/Moves/Sleep_Talk,/obj/Moves/Thief,/obj/Moves/Trick)
	var/list/MOVES = typesof(/obj/Moves)
	var/obj/Moves/Z = pick(MOVES)*/

obj/Moves
	Milk_Drink
	Mimic
	Mind_Reader
	Minimize
//Mirror Coat//-----------------------------------------------------------------------------------------------------
obj/Moves/Mirror_Coat
	Type = "Psychic"
	Range = "Projectile"
	PP = 20
	MPP = 20
	Wait_Time = 115
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Mirror_Coat(src)
			if(P) P.UsingAttack = null
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				var/list/MirrorCoatPokemon = icon_states('Mirror Coat.dmi')
				var/Poke = copytext("[Owner.type]",14)
				if(MirrorCoatPokemon.Find(Poke))
					icon = 'Mirror Coat.dmi'
					icon_state = "HUD [Poke]MirrorCoat"


mob/Pokemon/proc/Mirror_Coat(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	if(Target && isPokemon(Target))
		var/list/MirrorCoatPokemon = icon_states('Mirror Coat.dmi')
		var/Poke = copytext("[type]",14)
		if(MirrorCoatPokemon.Find(Poke)) overlays += image('Mirror Coat.dmi', "[Poke]")
		spawn(50) overlays -= image('Mirror Coat.dmi', "[Poke]")
		var/mob/Pokemon/P = Target
		if(P && P.LastAttack && P.LastAttack.Power)
			if(P.LastAttack.Range == "Projectile" || P.LastAttack.Range == "Special")
				var/obj/Moves/NM = new P.LastAttack.type
				NM.Power *=2
				NM.Owner = src
				NM.Type = "Psychic"
				NM.Attack()
				del NM
				return

	else
		O<<System("Mirror Coat failed")
		M.PP += 1
		M.WaitTime = 0






obj/Moves/Mirror_Move
	Type = "Flying"
	Range = "Special"
	PP = 20
	MPP = 20
	Wait_Time = 115
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Mirror_Move(src)
			if(P) P.UsingAttack = null
			for(var/i in Parts) del i



mob/Pokemon/proc/Mirror_Move(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	if(Target && isPokemon(Target))


		var/mob/Pokemon/P = Target
		if(P && P.LastAttack)
			var/obj/NP = new
			NP.density = 0
			M.Parts += NP
			NP.icon = 'Mirror Move.dmi'
			spawn(100) if(NP) del NP
			spawn(1)
				while(NP)
					NP.loc = get_step(src, src.dir)
					NP.icon_state = icon_state
					NP.dir = dir
					sleep(1)
			var/obj/Moves/NM = new P.LastAttack.type
			O<<System("[src] used [NM]")
			NM.Owner = src
			NM.Attack()
			del NM
			return

	else
		O<<System("Mirror Move failed")
		M.PP += 1
		M.WaitTime = 0
obj/Moves
	Mist
	Memento
	Moonlight
	Morning_Sun
	Muddy_Water
//Mud Shot//Mudshot//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Mud_Shot
	Type = "Ground"
	Range = "Damage"
	PP = 15
	MPP = 15
	Wait_Time = 100
	Power = 55
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(..())
			P.Mud_Shot(src)
			if(P) P.UsingAttack = null
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()





mob/Pokemon/proc/
	Mud_Shot(var/obj/Moves/M)
		var/obj/Overworld/Mud_Bullet/MB = new (src.loc)
		MB.owner = src
		walk(MB,dir,1)
		sleep(4)
		walk(MB,0)
		//If it hits a target before it can expand, then it will delete itself instantly. So this should stop it from continuing
		new/obj/Overworld/Mud_Puddle (MB.loc)
		del MB






		spawn(180)
			for(var/obj/O in M.Parts) del O
		del MB
obj/Overworld/
	icon = 'Moves.dmi'
	Mud_Bullet
		name = "Mud Shot"
		icon_state = "Mud Shot"
		density = 1
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Mud_Shot/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)

				new/obj/Overworld/Mud_Puddle (M.loc)
				del src

			else ..()


	Mud_Puddle
		pixel_y = -16
		pixel_x = -16
		var/list/Hit = list() //Since there can be 2 puddles on the field, they have to distinguish which one is hit by puddle, not Move..
		layer = 2
		icon = 'Mudshot.dmi'
		icon_state = "Puddle"
		var/list/Parts = list()
		New()
			..()
			spawn(180)
				del src
			flick("Expand", src)
			for(var/turf/T in ObjectView(1, src))
				var/obj/Overworld/Mud_Puddle/Damage/D = new (T) //Will delete itself
				D.MudP = src


		Damage
			icon_state = "Blank"
			invisibility = 60
			var/obj/Overworld/Mud_Puddle/MudP
			New()
				spawn(180)
					del src
			SteppedOn(atom/movable/M)
				if(isPokemon(M) && !M.PathFinding)
					var/mob/Pokemon/P = M
					if(!MudP.Hit.Find(P)) //They haven't been hit before
						MudP.Hit += P
						if(P.Owner == owner || P.TempStats["SPD"] <= -6) return ..() //They can't hit their own Pokemon with the move. Or Pokemon on their team.
						P.GiveTempStat(src,"SPD",-1)
						if(P) P.GiveTempStat(src,"SPD",1,600)
				return 1





//Mud Slap//Mudslap//-----------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Mud_Slap
	Type = "Ground"
	Range = "Physical"
	Power = 20
	PP = 10
	MPP = 10
	Wait_Time = 30
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Mud_Slap(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Mud_Slap
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Mud_Slap(var/obj/Moves/M)
	var/obj/Overworld/Mud_Slap/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Mud Slap", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/
	Mud_Sport
	Nature_Power
	Nightmare
//Night Shade//------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Night_Shade
	Type = "Ghost"
	Range = "Special"
	PP = 15
	MPP = 15
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Night_Shade(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'


	Night_Shade
		density = 1
		icon_state = "Night Shade Tip"
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				if(istype(m,/mob/Player))
					var/mob/Player/M = m
					if(M.Court || owner.Owner)
						loc = null
						return	//Only Wild Pokemon can inflict Battle Damage to trainers.
				if(istype(m,/mob/Pokemon))
					var/mob/Pokemon/M = m
					if(M.Owner && owner.Owner)
						var/mob/Player/O1 = GetOwner(owner.Owner)
						var/mob/Player/O2 = GetOwner(M.Owner)
						if(O1.Court != O2.Court || !O1.Court  || !O2.Court)
							loc = null
							return
					if(M.Type1 == "Normal" || M.Type2 == "Normal")
						M.DamageOverlay(0)
						return

				var/mob/M = m
				M.HP = max(0,M.HP - owner.Level)
				M.DamageOverlay(owner.Level)
				M.DeathCheck(owner)
			loc = null

	NSExtra
		density = 1
		icon_state = "Night Shade"
		New()
			spawn(100) del src //Incase something fucks up. //Wow, why did I swear?...


mob/Pokemon/proc/Night_Shade(var/obj/Moves/M)
	var/obj/Overworld/Night_Shade/V = new(loc)
	M.Parts += V
	V.dir = dir
	var/SetDir = V.dir
	V.owner = src
	frozen = 1
	spawn(13) if(V) V.loc = null

	while(V.loc)
		step(V,SetDir)
		if(V)
			var/obj/Overworld/NSExtra/E = new(V.loc)
			E.layer = layer - 1
			E.owner = V.owner
			M.Parts += E
			E.dir = SetDir
			sleep(1)
			//if(V) if(V.loc) sleep(1)
	del V
	for(var/obj/E in M.Parts)
		del E
	frozen = 0
obj/Moves/Needle_Arm
	Type = "Grass"
	Range = "Physical"
	Power = 60
	PP = 15
	MPP = 15
	Wait_Time = 50
	icon_state = "HUDNA"
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Needle_Arm(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1  && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDPeck"



obj/Overworld/Needle_Arm
	layer = 100
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Needle_Arm(var/obj/Moves/M)
	var/obj/Overworld/Needle_Arm/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon = icon
	O.icon_state = "Blank"
	O.dir = dir
	O.pixel_y = pixel_y
	O.pixel_x = pixel_x
	flick("Physical", src)
	flick("Needle Arm", O)
	if(O) if(O.loc)
		for(var/mob/MOB in O.loc)
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	if(O) if(O.loc)
		for(var/mob/MOB in get_step(O.loc,O.dir))
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
obj/Moves
	Octazooka
	Odor_Sleuth
	Outrage
	Pain_Split
	Pay_Day
//Peck//----------------------------------------------------------------------------------------------------------------
obj/Moves/Peck
	Type = "Flying"
	Range = "Physical"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 50
	icon_state = "HUDPeck"
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Peck(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1  && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				var/list/Iconstates = icon_states(Owner.icon)
				if(Iconstates.Find("HUDPeck"))
					icon = Owner.icon
					icon_state = "HUDPeck"



obj/Overworld/Peck
	layer = 100
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Peck(var/obj/Moves/M)
	var/obj/Overworld/Peck/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	spawn(12) frozen = 0
	O.icon = icon
	O.icon_state = "Blank"
	O.dir = dir
	O.pixel_y = pixel_y
	O.pixel_x = pixel_x
	flick("Physical", src)
	flick("Peck", O)
	if(O) if(O.loc)
		for(var/mob/MOB in O.loc)
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	if(O) if(O.loc)
		for(var/mob/MOB in get_step(O.loc,O.dir))
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)



//Parish Song//---------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Perish_Song
	Type = "Normal"
	Range = "Status"
	PP = 5
	MPP = 5
	Wait_Time = 750
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Perish_Song(src)
			if(P) P.UsingAttack = null
	Check()
		Attack()


mob/Pokemon/proc/Perish_Song(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	if(Target && isPokemon(Target))
		flick_overlay('Moves.dmi', "Perish Song")
		Target.flick_overlay('Moves.dmi', "Perish Song")
		sleep(200)
		flick_overlay('Moves.dmi', "Perish Song")
		Target.flick_overlay('Moves.dmi', "Perish Song")
		sleep(200)
		flick_overlay('Moves.dmi', "Perish Song")
		Target.flick_overlay('Moves.dmi', "Perish Song")
		sleep(200)
		HP = 0
		Target.HP = 0
		flick_overlay('Moves.dmi', "Perish Song Death")
		Target.flick_overlay('Moves.dmi', "Perish Song Death")
		Target.DeathCheck(src)
		DeathCheck(src)



	else
		O<<System("Mirror Move failed")
		M.PP += 1
		M.WaitTime = 0
//Petal Dance//--------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Petal_Dance
	Type = "Grass"
	Range = "Special"
	PP = 10
	MPP = 10
	Power = 120
	Wait_Time = 230
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Petal_Dance(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Petal_Dance
	icon = 'Moves.dmi'
	icon_state = "Petal Dance"
	layer = 100


mob/Pokemon/proc/Petal_Dance(var/obj/Moves/M)
	dir = 1;sleep(3)
	dir = 4;sleep(2)
	dir = 2;sleep(3)
	dir = 8;sleep(2)
	for(var/turf/T in view(src,2))
		spawn()
			var/obj/Overworld/Petal_Dance/C = new(T)
			for(var/mob/Pokemon/P in C.loc)
				if(P == src) continue
				P.HP = max(0,P.HP - BattleDamage(P,M))
				P.DeathCheck(src)
			sleep(20)
			del C
	Confuse(src)


//Pin Missle//--------------------------------------------------------------------------------------------------------
obj/Moves/Pin_Missle
	Type = "Bug"
	Range = "Physical"
	Distance = "Projectile"
	Power = 14
	PP = 20
	MPP = 20
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Pin_Missle(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Pin_Missle
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	icon_state = "Pin Missle"
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(!owner) return
			var/mob/M = D
			var/obj/Moves/Pin_Missle/A = new
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			sleep(5)
			del A
		del src

mob/Pokemon/proc/Pin_Missle(var/obj/Moves/M)
	flick("Fire",src)
	var/HowMany = rand(14,20)
	for(var/i=0, i<HowMany, i++)
		var/obj/Overworld/Pin_Missle/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
		sleep(3)
	FindTarget()
obj/Moves/Poison_Fang
	Type = "Poison"
	Range = "Physical"
	Power = 50
	PP = 15
	MPP = 15
	Distance = "Physical"
	Wait_Time = 65
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Poison_Fang(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				if(ATK.dir != 1 || ATK.dir != 4 || ATK.dir != 8 || ATK.dir != 2) ATK.dir = turn(ATK.dir, pick(45,-45))

				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Poison_Fang
	layer = 100
	density = 0
	pixel_y = -32
	pixel_x = -32
	icon = null
	New()
		flick('Poison Fang.dmi',src)
		spawn(400) del src


mob/Pokemon/proc/Poison_Fang(var/obj/Moves/M)
	var/list/Turfs = list() //Find the spots to push from
	var/atom/Middle = null //Find spot to do damage
	if(dir == 5 || dir == 6 || dir == 9 || dir == 10) dir = turn(dir,pick(45,-45))
	Middle += get_step(src,dir)
	Turfs += get_step(src,turn(dir,45))
	Turfs += get_step(src,turn(dir,-45))
	flick("Physical",src)
	var/obj/Overworld/Poison_Fang/PG = new
	PG.loc = src.loc
	PG.dir = dir

	step(PG, PG.dir)
	for(var/atom/A in Turfs)
		for(var/mob/m in A)
			step_towards(m,Middle) // pushes them to the middle)
	sleep(3)
	for(var/mob/Pokemon/p in Middle) //Check for Pokemon
		if(p == src) continue
		p.HP = max(0, p.HP - BattleDamage(p, M))
		if(!Target) Target = p
		if(prob(35))
			p.StatusKiller = src
			p.Poison(src)
		p.DeathCheck(src)
	spawn(15) del PG
//PoisonGas//Poison Gas//Poision Gas//----------------------------------------------------------------------------------------------------------------------
obj/Moves/Poison_Gas
	Type = "Poison"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(O) if(!O.Court  && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.PoisonGas(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/PoisonGasStep
	invisibility = 1
	SteppedOn(D)
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D

			if(!P.PathFinding)

				P.Target = null
				if(P != owner)
					if(P.Type1 != "Poison" || P.Type2 != "Poison" || P.Type2 != "Ground" || P.Type1 != "Ground")
						if(prob(95))
							P.StatusKiller = owner
							P.Poison(owner)
		return ..()
	New()
		spawn(150) del src
		..()

obj/Overworld/PoisonGas
	icon = 'Poison Gas.dmi'
	icon_state = "Blank"
	pixel_y = -48
	pixel_x = -48
	New()
		flick("Enter", src)
		spawn(10) icon_state = "Poison Gas"
		spawn(150) del src
		..()

mob/Pokemon/proc/PoisonGas(var/obj/Moves/M)
	new/obj/Overworld/PoisonGas (src.loc)
	for(var/turf/T in view(src,1))
		spawn()
			var/obj/Overworld/PoisonGasStep/SP = new(T)
			SP.owner = src
			for(var/mob/Pokemon/P in SP.loc)
				if(P == src) continue
				if(prob(90))
					P.StatusKiller = src
					P.Poison(src)

//PoisonPowder//Poison Powder//----------------------------------------------------------------------------------------------------------------
obj/Moves/PoisonPowder
	Type = "Poison"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 110
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(O) if(!O.Court  && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.PoisonPowder(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/PoisonPowder
	icon = 'Moves.dmi'
	icon_state = "Blank"
	layer = 100

	SteppedOn(D)
		if(istype(D,/obj/Overworld/Ember))
			del src
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			P.Target = null
			if(P != owner)
				if(P.Type1 != "Poison" || P.Type2 != "Poison" || P.Type2 != "Ground" || P.Type1 != "Ground")
					for(var/obj/Overworld/PoisonPowder/PP in Center)
						P.StepAway = PP
		return ..()


mob/Pokemon/proc/PoisonPowder(var/obj/Moves/M)
	for(var/turf/T in view(src,3))
		spawn()
			var/obj/Overworld/PoisonPowder/SP = new(T)
			M.Parts += SP
			SP.Center = loc
			flick("Poison Powder",SP)
			spawn(18)
				if(!SP) continue
				for(var/mob/Pokemon/P in SP.loc)
					if(P == src) continue
					if(prob(75))
						P.StatusKiller = src
						P.Poison(src)

				sleep(6)
				del SP
//Poison Sting
obj/Moves/Poison_Sting
	Type = "Poison"
	Range = "Physical"
	Distance = "Projectile"
	Power = 10
	PP = 30
	MPP = 30
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Poison_Sting(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Poison_Sting
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	icon_state = "Poison Sting"
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(!owner) return
			var/mob/M = D
			var/obj/Moves/Poison_Sting/A = new
			var/HHHP = M.HP
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			if(prob(20) && istype(M,/mob/Pokemon))
				if(HHHP != M.HP)
					var/mob/Pokemon/P = M
					P.StatusKiller = src.owner
					P.Poison(owner)
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			sleep(5)
			del A
		del src

mob/Pokemon/proc/Poison_Sting(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=0, i<4, i++)
		var/obj/Overworld/Poison_Sting/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
		sleep(3)
	FindTarget()
obj/Moves/Poison_Tail
//Pound//----------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Pound
	Type = "Normal"
	Range = "Physical"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 50
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Pound(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()



mob/Pokemon/proc/Pound(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Pound", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					if(!Status)
						if(prob(30))
							if(isPokemon(MOB))
								var/mob/Pokemon/PPP = MOB
								spawn() PPP.Paralysis(src)
					MOB.DeathCheck(src)

obj/Moves/Powder_Snow
	Type = "Ice"
	Range = "Special"
	PP = 25
	MPP = 25
	Power = 40
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Powder_Snow(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Powder_Snow
	icon = 'Moves.dmi'
	icon_state = "Powder Snow"
	layer = 100


mob/Pokemon/proc/Powder_Snow(var/obj/Moves/M)
	flick("Confusion",src)
	for(var/turf/T in view(src,1))
		spawn()
			var/obj/Overworld/Powder_Snow/C = new(T)
			for(var/mob/Pokemon/P in C.loc)
				if(P == src) continue
				P.HP = max(0,P.HP - BattleDamage(P,M))
				P.DeathCheck(src)
			sleep(20)
			del C

obj/Moves/Protect
	Type = "Normal"
	Range = "Status"
	Power = 65
	PP = 10
	MPP = 10
	Wait_Time = 400
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Protect(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D



mob/Pokemon/
	proc/Protect(var/obj/Moves/M)
		frozen = 1
		flick_overlay('Moves.dmi', "ProtectStart")
		sleep(5)
		overlays += image('Moves.dmi',"Protect")
		SecondaryStatus["Protect"] = 1
		frozen = 0
		sleep(100)
		overlays -= image('Moves.dmi',"Protect")
		SecondaryStatus["Protect"] = 0



obj/Moves/Present
//Psybeam//
obj/Moves/Psybeam
	Type = "Psychic"
	Range = "Special"
	Power = 65
	PP = 15
	MPP = 15
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Psybeam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else

				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'
	Psybeam
		density = 1
		icon_state = "Psybeam"
		layer = 10
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Psybeam/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			density = 0

	PExtra
		density = 1
		icon_state = "Psybeam"


mob/Pokemon/proc/Psybeam(var/obj/Moves/M)
	set background = 1
	var/obj/Overworld/Psybeam/P = new(loc)
	var/list/Parts = list()
	P.dir = dir
	var/SetDir = P.dir
	P.owner = src
	frozen = 1
	spawn(8) if(P) P.density = 0
	flick("Confusion",src)
	while(P.density)

		var/obj/Overworld/PExtra/E = new(P.loc)

		step(P,SetDir)

		if(length(Parts) == 1)
			E.icon_state = "Psybeam1"
		if(!length(Parts))
			E.invisibility = 1

		E.layer = layer - 1
		E.owner = P.owner
		Parts += E
		E.dir = SetDir
		sleep(1)
	del P
	for(var/obj/E in Parts)
		spawn()
			E.density = 0
			E.icon_state = "Blank"
			flick("PsybeamFade",E)
			sleep(6)
			del E
	frozen = 0






//Psychic //--------------------------------------------------------------------------------------------------------------
obj/Moves/Psychic
	Type = "Psychic"
	Range = "Special"
	Power = 90
	PP = 10
	MPP = 10
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Psychic(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D

	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				var/H = 1
				spawn(300) H = 0 //This is a safety. For some reason this was never ending.
				spawn()
					while(H && DEF.Status != "Sleep")
						ATK.Step_To(DEF)
						sleep(SPEED)
				Attack()
				H = 0
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Psychic
	icon = 'Hypnosis.dmi'
	icon_state = "Psychic"
	layer = 50
	pixel_y = -16
	pixel_x = -16

	New()
		..()
		spawn(10) del src



mob/Pokemon/proc/Psychic(var/obj/Moves/M)
	var/obj/Overworld/Psychic/P = new (Get_Steps(src,src.dir,2))
	//Deletes from New() in 90 seconds
	var/list/Hit = list()
	while(P)
		sleep(1)
		P.loc = Get_Steps(src,src.dir,2)
		P.dir = dir

		for(var/mob/Pokemon/Poke in ObjectView(1, P))
			Poke.loc = P.loc
			Poke.dir = turn(dir, 180)
			Poke.icon_state = "Pushback"
			if(!Hit.Find(Poke))
				Hit += Poke
				Poke.HP = max(0,Poke.HP - BattleDamage(Poke,M))
				Poke.DeathCheck(src)

				if(prob(10))
					if(Poke.Owner != Owner && Poke.TempStats["SPL DEF"] <= -5) return
					Poke.GiveTempStat(src,"SPL DEF",-1)
					if(P)
						Poke.GiveTempStat(src,"SPL DEF",1,600)
						if(!Poke.Target) Poke.Target = src


				frozen = 1
				Poke.frozen = 1
				sleep(20)
				frozen = 0
				Poke.frozen = 0
				Poke.Pushback(null,4,turn(dir, 90))

				del P

				break













obj/Moves/
	Psych_Up
obj/Moves/Psywave
	Type = "Psychic"
	Range = "Special"
	Power = 40
	PP = 15
	MPP = 15
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Psywave(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Psywave
	layer = 100
	icon = 'Psywave.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Psywave(var/obj/Moves/M)
	var/obj/Overworld/Psywave/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	M.Power = (pick(0,1,2,3,4,5,6,7,8,9,10) + 5) * (src.Level / 10)
	O.icon_state = "Blank"
	O.dir = dir
	flick("Fire", src)
	flick("Psywave", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves/Pursuit
	Type = "Dark"
	Range = "Physical"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 30
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Pursuit(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

mob/Pokemon/proc/Pursuit(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Pursuit", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

//Quick Attack//----------------------------------------------------------------------------------------------------------
obj/Moves/Quick_Attack
	Type = "Normal"
	Range = "Physical"
	Power = 40
	PP = 30
	MPP = 30
	Wait_Time = 45
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Quick_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,3,4)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/Quick_Attack(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Quick Attack"
	NoRunDelay = 1
	frozen = 1
	for(var/i=1, i<5, i++)
		if(icon_state != "Quick Attack") break
		var/obj/Overworld/Scratch/S = new (src.loc)
		S.icon = icon
		S.layer = src.layer-1
		S.dir = dir

		spawn(10) del S
		flick("QStream", S)
		frozen = 0
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		frozen = 1

		sleep(1)
	if(icon_state == "Quick Attack") icon_state = null
	frozen = 0
	NoRunDelay = 0
//Rain Dance//Raindance//--------------------------------------------------------------------------------------------------------------
area/var/WeatherID

obj/Moves/Rain_Dance
	Type = "Water"
	Range = "Status"
	PP = 5
	MPP = 5
	Wait_Time = 900
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Rain_Dance(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)

mob/Pokemon/proc/Rain_Dance(var/obj/Moves/M)
	var/area/Area = loc.loc
	var/DanceSteps = 5


	if(Area.WeatherID) //If there is already a weather effect in place, the dance will take longer.
		DanceSteps += 5

	SecondaryStatus["Attacking"] = 1
	for(var/i = 1, i<= DanceSteps, i++)
		dir = pick(1,2,4,8)
		flick(pick("Fire","Physical"), src)
		sleep(10)
	SecondaryStatus["Attacking"] = 0

	Area.WeatherID = "Rain Dance"
	//Add the Overlay to everyone.
	for(var/mob/Watcher/W in view(20, src))
		var/mob/Player/P = W.Owner
		if(!P) continue
		P.TimeHUD.WeatherEffect = "Rain Dance"
		P.UpdateDayHUD()
		P<<System("Rain starts pouring down on the battlefield.")
		spawn(1500)
			if(P)
				if(P.TimeHUD.WeatherEffect == "Rain Dance") P.TimeHUD.WeatherEffect = null
				P.UpdateDayHUD()

	spawn(1500) if(Area.WeatherID == "Rain Dance") Area.WeatherID = null




//Rapid Spin//RapidSpin//------------------------------------------------------------
obj/Moves/Rapid_Spin
//Rage//-----------------------------------------------------------------------------------------------------
obj/Moves/Rage
/*	Type = "Normal"
	Power = 20
	PP = 20
	MPP = 20
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!P || PP <= 0 || WaitTime || P.HP <= 0|| P.icon_state == "Sleep") return
		if(Disabled)
			O<<System("This move has been Disabled!")
			return
		PP -= 1
		TimesUsed += 1
		WaitTime = 1
		spawn(rand(20,35)) WaitTime = 0
		P.UsingAttack = src
		P.LastAttack = src
		P.Rage(src)
		if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Rage(var/obj/Moves/M)
	var/mob/O = GetPlayer(Owner)
	var/hp = HP
	overlays += image('Moves.dmi', "Rage")
	sleep(10)
	for(var/i = 1, i <= 12, i++)
		sleep(1)
		if(!istype(UsingAttack,/obj/Moves/Rage))

			break
		if(HP != hp)
			break
		if(O) if(O.client) if(get_step(src,dir) in view(O.client)) step(src,dir)
	overlays -= image('Moves.dmi', "Rage")*/




//Razor Leaf//-----------------------------------------------------------------------------------------------------------
obj/Moves/Razor_Leaf
	CriticalHit = 12.5
	Type = "Grass"
	Range = "Special"
	Power = 10
	PP = 25
	MPP = 25
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Razor_Leaf(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Razor_Leaf
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
		var/obj/B
		for(var/i=0, i<9, i++)
			B = new
			B.pixel_y = rand(-16,16)
			B.pixel_x = rand(-16,16)
			B.icon_state = "Razor Leaf"
			src.overlays += B
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			var/obj/Moves/Razor_Leaf/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)


		del src

mob/Pokemon/proc/Razor_Leaf(var/obj/Moves/M)
	flick("Physical",src)
	for(var/i=0, i<3, i++)
		var/obj/Overworld/Razor_Leaf/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,2)
		sleep(3)
	FindTarget()

obj/Moves/Razor_Wind
	CriticalHit = 12.5
	Type = "Normal"
	Range = "Special"
	Power = 80
	PP = 10
	MPP = 10
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Razor_Wind(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Razor_Wind
	icon = 'Moves.dmi'
	icon_state = "Razor Wind"
	layer = 100
	density = 1
	New()
		..()
		spawn(40)
			del src
		pixel_y = rand(-8,8)
		pixel_x = rand(-8,8)


	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(owner.SecondaryStatus["Fire Razor Wind"])
				var/mob/M = D

				var/obj/Moves/Razor_Wind/A = new

				M.HP = max(0,M.HP - owner.BattleDamage(M,A))
				M.DeathCheck(owner)
				owner.SecondaryStatus["Fire Razor Wind"] = 0
				del A
				sleep(5)


		del src

mob/Pokemon/proc/Razor_Wind(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	FindTarget()
	if(Target && isPokemon(Target))
		var/obj/Overworld/Gust/G = new
		G.layer = 2
		underlays += G
		sleep(30)
		spawn()
			SecondaryStatus["Fire Razor Wind"] = 1
			while(SecondaryStatus["Fire Razor Wind"])
				var/obj/Overworld/Razor_Wind/RW = new(loc)
				M.Parts += RW
				RW.owner = src
				flick("Fire", src)
				walk(RW, get_dir(src, Target), 1)
				sleep(2)
			underlays -= G
			del G
			for(var/obj/Overworld/oO in M.Parts)
				flick("Razor Wind Fade",oO)
				spawn(5) del oO



	else
		O<<System("Razor Wind failed")
		M.PP += 1
		M.WaitTime = 0
//Recover//-----------------------------------------------------------------------
obj/Moves/Recover
	Type = "Psychic"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Recover(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()


mob/Pokemon/proc/Recover(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/HPRise = min(MHP, HP + (MHP*0.5))-HP
	spawn() flick_overlay('Moves.dmi', "Recover")
	spawn()
		for(var/i = 1, i>= 15,i++)
			HP += HPRise / 15
			sleep(min(1,HPRise/15))
			O.UpdateParty()






//Reflect//--------------------------------------------------------------------------------------------------------------------------
obj/Moves/Reflect
	Type = "Psychic"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Reflect(src)
			if(P) P.UsingAttack = null

obj/Overworld/Reflect
	icon = 'Moves.dmi'
	layer = 100
	density = 1
	BumpedInto(D)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			return 0
		else
			return 1
	New()
		spawn(600) del src

mob/Pokemon/proc/Reflect(var/obj/Moves/M)
	for(var/i = -45, i <= 45, i+= 45)
		var/obj/Overworld/Reflect/R1 = new (get_step(src,turn(src.dir,i)))
		R1.icon_state = "Reflect"
		M.Parts += R1
		R1.dir = dir






obj/Moves
//Rest//
	Refresh
obj/Moves/Rest
	Type = "Normal"
	Range = "Physical"
	PP = 10
	MPP = 10
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Rest(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
mob/Pokemon/proc/Rest(var/obj/Moves/M)
	src.HP = src.MHP
	src.Sleep(src)
obj/Moves
	Return
	Revenge
	Reversal

//Roar//---------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Roar
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Roar(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

obj/Overworld/Roar
	icon = 'Moves.dmi'
	density = 0
	New()
		flick("Roar", src)
mob/Pokemon/proc/Roar(var/obj/Moves/M)
	frozen = 1
	var/obj/Overworld/Roar/R = new (get_step(src,src.dir))
	R.dir = dir
	spawn(10)
		del R
		frozen = 0
	for(var/mob/Pokemon/P in view(src,5))
		if(P == src) continue
		if(isPokemon(P) && P.Ability == "Suction Cups") return
		P.NoSend = world.realtime + 300 //They can't send out for 1 minute.
		P.ReturntoBall(0)


obj/Moves/Rock_Blast
//Rock Slide//Rockslide//Rock_Slide//------------------------------------------------------
obj/Moves/Rock_Slide
	Type = "Rock"
	Range = "Physical"
	Power = 75
	PP = 10
	MPP = 10
	Wait_Time = 185
	var/tmp/list/Affected = list()
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Rock_Slide(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 4 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				//This is the stepping proc so it doesn't just stand still whilst waiting for the Thunder
				var/TH = 1
				spawn(100)
					TH = 0
				spawn()
					while(TH)
						if(!ATK.loc || !DEF.loc) break
						if(ATK.Status == "Sleep") break
						if(prob(50)) if(get_dist(ATK, DEF) > 3)ATK.Step_To(DEF)
						if(prob(70)) if(get_dist(ATK, DEF) < 3) step_away(ATK,DEF)
						ATK.dir = get_dir(ATK,DEF)


						sleep(4)



				Attack()
				TH = 0
				return
				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)

mob/Pokemon/
	var/obj/Overworld/Crosshairs
	proc/Rock_Slide(var/obj/Moves/Thunder/M)
		var/mob/Player/O = GetOwner(Owner)
		var/obj/Overworld/ThunderCrossHair/TCH = new (Get_Steps(src,src.dir,3))
		var/image/I
		spawn(1) while(TCH)
			if(!LockOn) TCH.loc = Get_Steps(src,src.dir,3)
			else if(LockOn.loc) TCH.loc = LockOn

			sleep(1)
		for(var/i = 5, i >= 1, i--)
			if(I) del I
			if(O.client)
				I = image('Moves.dmi', TCH ,"ThunderCrossHair[i]",MOB_LAYER+1)
				I.layer = 62
				O << I
			sleep(10)
		del I//So they can't see the crosshairs, but it still remains on the battle field.

		var/list/Turfs = list()
		var/list/DIR = list(1,2,4,8)
		for(var/i in DIR)
			Turfs += get_step(TCH.loc, i)

		for(var/turf/T in Turfs)
			spawn(5)
				var/obj/Overworld/RockSlide/R = new (T)
				var/obj/Overworld/RockSlideRock/RR = new (locate(T.x,T.y+6,T.z))

				flick("RockSlide",R)
				for(var/i = 1, i<=6, i++)
					step(RR,2)
					sleep(1)

				del R
				del RR
				for(var/mob/P in T)
					if(M.Affected.Find(P)) continue
					P.HP = max(0,P.HP - BattleDamage(P,M))
					P.DeathCheck(src)
					M.Affected += P

		Turfs = list()
		DIR = list(5,6,9,10)
		for(var/i in DIR)
			Turfs += get_step(TCH.loc, i)

		for(var/turf/T in Turfs)
			spawn(0)
				var/obj/Overworld/RockSlide/R = new (T)
				var/obj/Overworld/RockSlideRock/RR = new (locate(T.x,T.y+6,T.z))

				flick("RockSlide",R)
				for(var/i = 1, i<=6, i++)
					step(RR,2)
					sleep(1)

				del R
				del RR
				for(var/mob/P in T)
					if(M.Affected.Find(P)) continue
					P.HP = max(0,P.HP - BattleDamage(P,M))
					P.DeathCheck(src)
					M.Affected += P


		M.Affected = list()



obj/Overworld/RockSlide
	icon = 'Moves.dmi'
	density = 0

obj/Overworld/RockSlideRock
	icon = 'Moves.dmi'
	layer = 3
	density = 0
	New()
		spawn(35)
			del src
		icon_state = "Rock[rand(1,4)]"




//Rock Throw//-----------------------------------------------------------------------------
obj/Moves/Rock_Throw
	Type = "Rock"
	Range = "Physical"
	Power = 12
	PP = 15
	MPP = 15
	Wait_Time = 75
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Rock_Throw(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Rock_Throw
	icon = 'Moves.dmi'
	layer = 3
	density = 1
	New()
		spawn(35)
			del src
		icon_state = "Rock[rand(1,4)]"
		pixel_y = rand(-4,4)
		pixel_x = rand(-4,4)

	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			var/mob/M = D
			var/obj/Moves/Rock_Throw/A = new
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)
		del src

mob/Pokemon/proc/Rock_Throw(var/obj/Moves/M)
	flick("Physical",src)
	for(var/i=0, i<4, i++)
		var/obj/Overworld/Rock_Throw/A = new(src.loc)
		A.owner = src
		A.dir = dir
		walk(A,A.dir,1)
		sleep(3)
	if(!Target) FindTarget()
obj/Moves/Rock_Tomb
obj/Moves/Role_Play
//Rolling Kick//RollingKick//--------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Rolling_Kick
	Type = "Fighting"
	Range = "Physical"
	Power = 60
	PP = 15
	MPP = 15
	Wait_Time = 75
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Rolling_Kick(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2))
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Rolling_Kick
	icon = 'Moves.dmi'
	New()
		..()
		spawn(10) del src

mob/Pokemon/proc/Rolling_Kick(var/obj/Moves/M)
	var/list/DIR = list(2,6,4,5,1,9,8,10)
	frozen = 0
	var/list/HIT = list()
	icon_state = "Physical"
	for(var/i in DIR)
		dir = i
		var/obj/Overworld/Rolling_Kick/R = new(get_step(src,src.dir))
		R.dir = i
		flick("Rolling Kick", R)

		for(var/mob/MOB in R.loc)
			if(HIT.Find(MOB)) continue
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
				HIT += MOB
			if(istype(MOB,/mob/Pokemon))
				var/mob/Pokemon/POKE
				POKE.Pushback(src,0,src.dir)

		sleep(1)
	if(icon_state == "Physical") icon_state = null





obj/Moves/Rolling_Kick
//Rollout//-------------------------------------------------------------------------------------------------------------
obj/Moves/Rollout
	Type = "Rock"
	Range = "Physical"
	Power = 15
	PP = 20
	MPP = 20
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Rollout(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack() //Do This!!!
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUD Roll"


mob/Pokemon/
	var/tmp/Rolling
	proc/Rollout(var/obj/Moves/M)
		set background = 1

		var/mob/Player/O = GetOwner(Owner)
		icon_state = "Rollout"
		NoRunDelay = 1
		Rolling = 1
		spawn(100) if(icon_state == "Rollout") icon_state = null

		while(icon_state == "Rollout")
			if(prob(1))
				dir = turn(dir,45)
				spawn(3) dir = turn(dir,45)
			if(O)
				if(O.client)
					if(get_step(src,dir) in view(O.client)) step(src,dir)
				else step(src,dir)
			else step(src,dir)
			sleep(1)

		NoRunDelay = 0
		Rolling = 0




obj/Moves
	Sacred_Fire
	Safeguard
//Sand-Attack//

	Sand_Attack
		name = "Sand-Attack"
//Sandstorm//--------------------------------------------------------------
obj/Moves/Sandstorm
	Type = "Ground"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 1000
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Sandstorm(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)

mob/Pokemon/proc/Sandstorm(var/obj/Moves/M)



area/proc/SandstormBrew(var/OriginalID, var/mob/Pokemon/owner, var/MaxTurns = 5)


obj/Moves/Sand_Tomb
//Scratch//----------------------------------------------------------------------------------------------------------------
obj/Moves/Scratch
	Type = "Normal"
	Range = "Physical"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 30
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Scratch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Scratch
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Scratch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Scratch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)






//Scary Face//--------------------------------------------------------------------------------------------------------------------
obj/Moves/Scary_Face
	Type = "Normal"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 500
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Scary_Face(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Scary_Face
	icon = 'Hypnosis.dmi'
	icon_state = "Scary Face"
	pixel_y = -16
	pixel_x = -16

mob/Pokemon/proc/Scary_Face(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	flick_overlay('Hypnosis.dmi', "Scary Face",-16,-16)
	if(!P || !istype(P,/mob/Pokemon)) return
	if(isPokemon(P) && P.Ability == "Clear Body") return

	if(get_dist(Target,src) <=3)
		if(P.Owner == Owner || P.TempStats["SPD"] <= -4) return
		P.GiveTempStat(src,"SPD",-2)
		if(P) P.GiveTempStat(src,"SPD",2,600)
		if(!P.Target) P.Target = src
//Screech//----------------------------------------------------------------------------------------------------
obj/Moves/Screech
	Type = "Normal"
	Range = "Status"
	Power = 35
	PP = 15
	MPP = 15
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Screech(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

mob/Pokemon/proc/Screech(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(isPokemon(P) && P.Ability == "Clear Body") return
	if(!P || !istype(P,/mob/Pokemon)) return
	if(P.Owner == Owner || P.TempStats["DEF"] <= -5) return
	var/obj/O = new
	O.icon = 'Moves.dmi'
	O.icon_state = "Screech"
	O.layer = 100
	overlays += O
	spawn(30) overlays -= O

	P.GiveTempStat(src,"DEF",-2)
	if(P) P.GiveTempStat(src,"DEF",2,600)
	if(!P.Target) P.Target = src
obj/Moves
	Seismic_Toss
	Silver_Wind
	Sheer_Cold
//Selfdestruct//
obj/Moves/Selfdestruct
	Type = "Normal"
	Range = "Physical"
	Power = 200
	PP = 5
	MPP = 5
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Selfdestruct(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()
mob/Pokemon/proc/Selfdestruct(var/obj/Moves/M)
	var/area/A = loc.loc
	flick_overlay('Moves.dmi',"Explode")
	src.HP = src.HP - src.HP
	src.DeathCheck(src)
	for(var/mob/Pokemon/P in A)
		if(isPokemon(P) && P.Ability == "Damp") return
		P.HP = max(0,P.HP - BattleDamage(P,M))
		P.DeathCheck(src)
obj/Moves/Shadow_Ball
	Type = "Ghost"
	Range = "Special"
	Power = 80
	PP = 15
	MPP = 15
	Wait_Time = 195
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Shadow_Ball(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Shadow_Ball
	icon = 'Hypnosis.dmi'
	icon_state = "Shadow Ball"
	pixel_x = -16
	pixel_y = -16
	layer = 100
	density = 0
	New()
		spawn(40)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			var/obj/Moves/Fire_Blast/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			del A
			sleep(5)


		del src

mob/Pokemon/proc/Shadow_Ball(var/obj/Moves/M)
	flick("Fire",src)
	var/obj/Overworld/Shadow_Ball/A = new(src.loc)
	A.owner = src

	A.dir = dir
	for(var/i = 1, i<= 8, i++)
		step(A,A.dir)
		for(var/obj/Overworld/SleepPowder/S in A.loc)
			del S
		for(var/mob/MOB in view(1,A.loc))

			if(M.Hit.Find(MOB)) continue //They've been hit
			if(MOB == src) continue //Don't attack the attacker
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)


		sleep(2)
	del A
	M.Hit = list()
	FindTarget()
obj/Moves/Shadow_Punch
	Type = "Ghost"
	Range = "Physical"
	Power = 60
	PP = 20
	MPP = 20
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Shadow_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Shadow_Punch
	layer = 100
	icon = 'Moves.dmi'
	icon_state = "Blank"
	New()
		spawn(30)
			del src

mob/Pokemon/proc/Shadow_Punch(var/obj/Moves/M)
	var/obj/Overworld/Shadow_Punch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Shadow Punch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

obj/Moves/

	Sharpen
obj/Moves/Signal_Beam
	Type = "Bug"
	Range = "Special"
	Power = 75
	PP = 15
	MPP = 15
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Signal_Beam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else

				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'
	Signal_Beam
		density = 1
		icon_state = "SignalBeamHead"
		layer = 10
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Signal_Beam/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			density = 0

	SExtra
		density = 1
		icon_state = "SignalBeamBody"


mob/Pokemon/proc/Signal_Beam(var/obj/Moves/M)
	set background = 1
	var/obj/Overworld/Signal_Beam/P = new(loc)
	var/list/Parts = list()
	P.dir = dir
	var/SetDir = P.dir
	P.owner = src
	frozen = 1
	spawn(8) if(P) P.density = 0
	flick("Fire",src)
	while(P.density)

		var/obj/Overworld/SExtra/E = new(P.loc)

		step(P,SetDir)

		if(length(Parts) == 1)
			E.icon_state = "SignalBeamTail"
		if(!length(Parts))
			E.invisibility = 1

		E.layer = layer - 1
		E.owner = P.owner
		Parts += E
		E.dir = SetDir
		sleep(1)
	del P
	for(var/obj/E in Parts)
		spawn()
			E.density = 0
			E.icon_state = "Blank"
			del E
	frozen = 0
//Sing//
obj/Moves/Sing
	Type = "Normal"
	Range = "Status"
	PP = 15
	MPP = 15
	Wait_Time = 275
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sing(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				var/H = 1
				spawn()
					while(H)
						ATK.Step_To(DEF)
						sleep(SPEED)
				Attack()
				H = 0
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Sing
	icon = 'Moves.dmi'
	icon_state = "Sing"
	layer = 100



mob/Pokemon/proc/Sing(var/obj/Moves/M)
	var/list/Saved = list()
	var/obj/Overworld/Sing/H = new
	overlays += H
	TEMPSpeed = 3
	for(var/i = 1, i <= 6, i++)
		for(var/mob/Pokemon/P in view(src,1))
			if(P == src || P.Status || Saved.Find(P)) continue
			var/mob/Player/O1 = GetOwner(Owner)
			var/mob/Player/O2 = GetOwner(P.Owner)
			if(O1.Court != O2.Court || !O1.Court  || !O2.Court)
				continue
			if(P.LastSlept)
				if(world.timeofday - P.LastSlept < 1200)
					if(prob(40))
						Saved += P
						continue

			spawn() if(prob(75)) P.Sleep(src)
		sleep(10)
	TEMPSpeed = 0
	overlays -= H


//Sketch//----------------------------------------------------------------------------------------------------------------
obj/Moves/Sketch
	Type = "Normal"
	Range = "Status"
	PP = 1
	MPP = 1
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sketch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


mob/Pokemon/proc/Sketch(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/list/BannedAttacks = list(/obj/Moves/Transform, /obj/Moves/Metronome, /obj/Moves/Selfdestruct, /obj/Moves/Explosion)
	FindTarget()
	if(Target)
		var/mob/Pokemon/P = Target
		if(!isPokemon(P))
			M.PP += 1
			O<<System("Sketch failed.")
			return
		else if(P.Owner && Owner)
			M.PP += 1
			O<<System("Sketch failed. (Sketch does not work on trainer's Pokemon)")
			return
		else if(BannedAttacks.Find(P.LastAttack.type))
			M.PP += 1
			O<<System("Sketch failed.")
			return
		else if(istype(P.LastAttack,/obj/Moves))
			flick("Physical",P)
			var/obj/Moves/MM = new P.LastAttack.type
			Moves += MM
			MM.Owner = src
			var/obj/Overworld/Scratch/S = new(P.loc)
			flick("Sketch", S)
			missile(MM, P, src)
			spawn(50) del S
			O.UpdateParty()
			del M


		else
			M.PP += 1
			O<<System("Sketch failed.")
			return
	else
		M.PP += 1
		O<<System("Sketch failed.")
		return




/obj/Moves


	Skull_Bash
//Sky Attack//SkyAttack//--------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Sky_Attack
	Type = "Flying"
	Range = "Physical"
	Power = 140
	CriticalHit = 12.5
	PP = 5
	MPP = 5
	Wait_Time = 350
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sky_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(2,3,3)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)


mob/Pokemon/proc/Sky_Attack(var/obj/Moves/M)

	SecondaryEffect["SkyAttack"] = 1
	NoReturn = world.realtime + 60
	density = 0
	AddMeter(0)

	var/obj/F = new
	F.icon = icon
	F.icon_state = "Fly"

	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/ThunderCrossHair/TCH = new (src.loc)
	var/image/I
	spawn(1) while(TCH)
		if(!LockOn) TCH.loc = src.loc
		else if(LockOn.loc) TCH.loc = LockOn

		sleep(1)

	icon_state = "Blank"
	missile(F, src, locate(x,y+12,z))
	spawn(33)
		missile(F, locate(x,y+12,z),TCH)
		spawn(get_dist(locate(x,y+12,z),src)) if(icon_state == "Blank") icon_state = null
		del TCH

	for(var/i = 3, i >= 1, i--)
		if(I) del I
		if(O.client)
			I = image('Moves.dmi', TCH ,"ThunderCrossHair[i]",MOB_LAYER+1)
			I.layer = 62
			O << I
		sleep(11)
	del I//So they can't see the crosshairs, but it still remains on the battle field. TCH used for loc.


	SecondaryEffect["SkyAttack"] = 0
	AddMeter(1)





obj/Moves/Sky_Uppercut
obj/Moves/Slack_Off
//Slam//---------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Slam
	Type = "Normal"
	Range = "Physical"
	Power = 80
	PP = 20
	MPP = 20
	Wait_Time = 155
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Slam(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/Slam(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<4, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0

//Slash//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Slash
	Type = "Normal"
	Range = "Physical"
	Power = 55
	PP = 20
	MPP = 20
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Slash(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 1 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/Slash
	layer = 100
	icon = 'Slash.dmi'
	icon_state = "Blank"
	New()
		spawn(50)
			del src

mob/Pokemon/proc/Slash(var/obj/Moves/M)
	var/obj/Overworld/Slash/O = new(get_step(src,turn(src.dir, -90)))
	M.CriticalHit = 6.25
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	switch(O.dir)
		if(2) O.pixel_y = -64
		if(8) O.loc = locate(x - 2, y - 1, z)
		if(1) O.loc = locate(x - 1, y, z)
	var/list/Turfs = list()
	Turfs += get_step(src,turn(src.dir, 90))
	Turfs += get_step(src,turn(src.dir, -90))
	var/turf/TTT = get_step(src,src.dir)
	Turfs += TTT
	Turfs += get_step(TTT,turn(src.dir, -45))
	Turfs += get_step(TTT,turn(src.dir, 45))

	flick("Physical", src)
	flick("Slash", O)
	if(O.loc)
		spawn(0)
			for(var/turf/T in Turfs)
				for(var/mob/MOB in T)
					if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
						if(T == TTT) M.CriticalHit = 50 //If its the center tile, it could be a critical hit!
						MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
						MOB.DeathCheck(src)
						M.CriticalHit = 6.25



//Sludge//----------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Sludge
	Type = "Poison"
	Range = "Special"
	Power = 65
	PP = 20
	MPP = 20
	Wait_Time = 160
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sludge(src)
			if(P) P.UsingAttack = null
			//Reassurance that the attacks are deleted.
			spawn(170) for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Sludge
	icon = 'Moves.dmi'
	icon_state = "Sludge"
	layer = 31
	density = 1
	var/obj/Moves/Owner
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(!Owner.Hit.Find(D))
				var/mob/M = D
				var/obj/Moves/Sludge/A = new
				A.Power = 75
				Owner.Hit += M
				M.HP = max(0,M.HP - owner.BattleDamage(M,A))
				M.DeathCheck(owner)
				loc = M.loc
				walk(src,0)
				density = 0
				if(isPokemon(M))
					var/mob/Pokemon/P = M
					if(prob(30)) P.Poison(owner)
				del A
		del src

obj/Overworld/Sludge_AOE
	density = 0
	name = "Sludge"
	icon = 'Fireblast.dmi'
	//icon_state = "blank"
	var/obj/Moves/Owner
	pixel_y = -17
	pixel_x = -17
	SteppedOn(var/mob/D)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))
			if(!Owner.Hit.Find(D))
				var/mob/M = D
				var/obj/Moves/Sludge/A = new
				Owner.Hit += M
				M.HP = max(0,M.HP - owner.BattleDamage(M,A))
				M.DeathCheck(owner)
				loc = M.loc
				walk(src,0)
				density = 0
				if(isPokemon(M))
					var/mob/Pokemon/P = M
					if(prob(30)) P.Poison(owner)
				del A


mob/Pokemon/proc/Sludge(var/obj/Moves/M)
	flick("Fire",src)
	var/obj/Overworld/Sludge/A = new(src.loc)
	A.owner = src //This is record who is dealing damage, for BattleDamage()
	A.Owner = M //This is to record who was hit, and who was not.
	A.dir = dir
	for(var/i = 1, i<= 5, i++)
		sleep(1)
		step(A,A.dir)

	var/obj/Overworld/Sludge_AOE/AOE = new(A.loc)
	del A
	flick("Sludge AOE Flick",AOE)
	spawn(8) AOE.icon_state = "Sludge AOE"
	M.Parts += AOE
	for(var/turf/t in view(1,AOE.loc))
		if(t == AOE.loc) continue
		var/obj/Overworld/Sludge_AOE/AOEe = new (t)
		AOEe.owner = src //This is record who is dealing damage, for BattleDamage()
		AOEe.Owner = M
		M.Parts += AOEe


//Sludge_Bomb//-----------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Sludge_Bomb
//SleepPowder// //Sleep Powder//----------------
obj/Moves/SleepPowder
	Type = "Grass"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.SleepPowder(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/SleepPowder
	icon = 'Moves.dmi'
	icon_state = "Blank"
	layer = 100
	SteppedOn(D)
		if(istype(D,/obj/Overworld/Ember))
			del src
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			P.Target = null
			if(P != owner || P.Status)
				for(var/obj/Overworld/SleepPowder/PP in Center)
					P.StepAway = PP

		return ..()


mob/Pokemon/proc/SleepPowder(var/obj/Moves/M)
	for(var/turf/T in view(src,3))
		spawn()
			var/obj/Overworld/SleepPowder/SP = new(T)
			M.Parts += SP
			SP.icon_state = "Sleep Spore"
			SP.Center = src.loc
			spawn(18)
				if(!SP) continue
				spawn(6) del SP
				for(var/mob/Pokemon/P in SP.loc)
					if(P == src || P.Status) continue
					spawn() P.Sleep(src)
					break


obj/Moves/Sleep_Talk
obj/Moves/SmellingSalt
obj/Moves/Smog
//Smokescreen//--------------------------------------------------------------------------------------
obj/Moves/Smokescreen
/*	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 500
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Smokescreen(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)


obj/Overworld/Smokescreen
	layer = 100
	icon = 'Smokescreen.dmi'
	icon_state = "OpagueSides"
	invisibility = 1
	var/Middle

	proc/UpdateSS()
		var/South
		var/North
		var/West
		var/East

		for(var/obj/Overworld/Smokescreen/S in get_step(src,2)) South = 1
		for(var/obj/Overworld/Smokescreen/S in get_step(src,1)) North = 1
		for(var/obj/Overworld/Smokescreen/S in get_step(src,8)) West = 1
		for(var/obj/Overworld/Smokescreen/S in get_step(src,4)) East = 1


		if(!North && East && South && West) dir = NORTH
		if(!North && !East && South && West)	dir = 5
		if(!East && South && West && North) dir = 4
		if(!South && !East && North && West) dir = 6
		if(!South && North && East && West) dir = SOUTH
		if(!South && !West && North && East) dir = 10
		if(North && East && South && !West) dir = 8
		if(!North && East && South && !West) dir = 9
		if(North && East && South && West) Middle = 1

mob/Pokemon/proc/Smokescreen(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/PP = Target
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Smokescreen/S
	if(isPokemon(PP) && PP.Ability == "Clear Body" || PP.Ability == "Keen Eye") return
	for(var/turf/T in view(src,3))
		S = new(T)
		M.Parts += S
		S.owner = src

	for(S in M.Parts)
		S.UpdateSS()

	for(var/mob/Player/P in world)
		for(var/obj/Overworld/Smokescreen/E in M.Parts)
			var/image/L = image('Smokescreen.dmi', E ,"[E.Middle?  "Opague":"OpagueSides"]",MOB_LAYER+99,E.dir)
			if(P == O) L = image('Smokescreen.dmi', E ,"[E.Middle?  "Trans":"TransSides"]",MOB_LAYER+99,E.dir)
			P << L

	sleep(300)
	for(S in M.Parts) del S
*/



obj/Moves/Snatch


obj/Moves/Snore
	Type = "Normal"
	Range = "Special"
	PP = 15
	MPP = 15
	Power = 40
	Wait_Time = 50
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Snore(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Snore
	icon = 'Moves.dmi'
	icon_state = "Snore"
	layer = 100


mob/Pokemon/proc/Snore(var/obj/Moves/M)
	if(src.Status == "Sleep")
		for(var/turf/T in view(src,2))
			spawn()
				var/obj/Overworld/Snore/C = new(T)
				for(var/mob/Pokemon/P in C.loc)
					if(P == src) continue
					P.HP = max(0,P.HP - BattleDamage(P,M))
					P.DeathCheck(src)
				sleep(20)
				del C
obj/Moves/Softboiled
//Solar Beam SolarBeam//----------------------------------------------------------------------------------------------------------------------------

obj/Moves/SolarBeam
	Type = "Grass"
	Range = "Special"
	Power = 120
	PP = 10
	MPP = 10
	Wait_Time = 220
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Solar_Beam(src)
			if(P) P.UsingAttack = null
		spawn(10)
			for(var/obj/D in Parts)
				del D
		WaitTime = 1
		spawn(250) WaitTime = 0
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		spawn(2)
			for(var/i, i <= 15, i++)
				ATK.icon += rgb(17,17,17)
				sleep(5)
				if(ATK.HP <= 0 || ATK.Status == "Sleep" || !ATK.loc) return

		spawn(77)
			ATK.dir = get_dir(ATK,DEF)
			if(ATK.dir != 1 && ATK.dir != 2 && ATK.dir != 4 && ATK.dir != 8) ATK.dir = turn(ATK.dir, pick(45, -45))
			DEF = null
			ATK.Solar_Beam_Fire(src)
			return
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) return
			ATK.Step_To(DEF)
			sleep(SPEED)
		return




obj/Overworld/
	icon = 'Moves.dmi'

	Solar_Beam
		invisibility = 1

	SBExtra
		icon = 'Moves.dmi'
		icon_state = "SolarBeamTop"
		name = "Solar Beam"



mob/Pokemon/proc/Solar_Beam_Fire(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	icon = initial(icon)
	if(HP <= 0 || Status == "Sleep" || !loc) return
	if(Status == "Paralysis")
		if(prob(25))
			O<<System("[src] is fully paralyzed!")
			flick("Pushback", src)
			frozen = 1
			for(var/j = 1, j <= 10, j++)
				if(j == 1 || j == 3 || j == 5|| j == 7|| j == 9) pixel_x += 3
				else pixel_x -= 3
				sleep(1)
			frozen = 0
			return 0
	var/obj/Overworld/Solar_Beam/W = new(get_step(loc,dir))
	M.Parts += W
	W.dir = dir
	var/SetDir = dir
	W.owner = src
	frozen = 1
	spawn(8) if(W) del W
	flick("Fire",src)
	var/first
	var/list/Damaged = list()
	while(W)
		var/list/Turfs = list()
		var/obj/Overworld/SBExtra/E = new(W.loc)
		var/obj/Overworld/SBExtra/EE = new(get_step(W.loc,turn(dir,-90)))
		E.dir = W.dir
		EE.dir = W.dir
		if(dir == 8)
			E.pixel_y = -16
			EE.pixel_y = -16
		if(dir == 4)
			E.pixel_y = 16
			EE.pixel_y = 16
		if(dir == 1)
			E.pixel_x = -16
			EE.pixel_x = -16
		if(dir == 2)
			E.pixel_x = 16
			EE.pixel_x = 16
		//Collect the Turfs that will do damage
		Turfs += W.loc
		Turfs += get_step(W.loc,turn(dir,-90))
		Turfs += get_step(W.loc,turn(dir,90))
		//Add the Extras to the Parts Var
		M.Parts += E
		M.Parts += EE
		E.icon_state = "SolarBeamTop"
		EE.icon_state = "SolarBeamBottom"
		if(!first)
			first = 1
			E.icon_state = "SolarBeamTopStart"
			EE.icon_state = "SolarBeamBottomStart"
		step(W,SetDir)
		E.owner = W.owner
		E.owner = W.owner
		sleep(1)
		spawn()
			for(var/turf/T in Turfs)
				for(var/mob/Pokemon/P in T)
					if(P == src || Damaged.Find(P)) continue
					P.HP = max(0,P.HP - BattleDamage(P,M))
					P.DeathCheck(src)
					Damaged += P

		if(!W) break

	del W
	spawn(3)
		for(var/obj/E in M.Parts)
			spawn()
				var/L = "[E.icon_state]Fade"
				E.icon_state = "Blank"
				flick("[L]",E)
				sleep(4)
				del E
	frozen = 0
	Target = null
	return


mob/Pokemon/proc/Solar_Beam(var/obj/Moves/M)
	var/i = 1
	var/area/Area = loc.loc
	if(Area.WeatherID == "Sunny Day") //It is raining
		i = 14
	//Later put i = lower if Sunny day is here.
	//Charging
	for(i, i <= 15, i++)
		icon += rgb(17,17,17)
		sleep(5)
		if(HP <= 0 || Status == "Sleep" || !loc) break


	Solar_Beam_Fire(M)
	return




//Sonicboom//-----------------------------------------------------------------------------------------------
obj/Moves/Sonicboom
	Type = "Normal"
	Range = "Special"
	PP = 20
	MPP = 20
	Wait_Time = 60
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sonicboom(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Sonicboom
	icon = 'Moves.dmi'
	icon_state = "Sonicboom"
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) )
			var/mob/M = D
			M.DamageOverlay(20) //It will always do 20 damage.
			M.HP = max(0,M.HP - 20)
			M.DeathCheck(owner)
			loc = M.loc
			density = 0 //Its already damaged one Pokemon, so forget doing anymore damage.



		else del src

mob/Pokemon/proc/Sonicboom(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Sonicboom/A = new(get_step(src.loc,turn(dir,i)))
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)
	FindTarget()
obj/Moves/Spark
	Type = "Electric"
	Range = "Physical"
	Power = 65
	PP = 20
	MPP = 20
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Spark(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,3,4)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDSpark"


mob/Pokemon/proc/Spark(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Quick Attack"
	NoRunDelay = 1
	frozen = 1
	for(var/i=1, i<5, i++)
		if(icon_state != "Quick Attack") break
		var/obj/Overworld/Scratch/S = new (src.loc)
		S.icon = icon
		S.layer = src.layer-1
		S.dir = dir
		flick("Spark", src)
		spawn(10) del S
		flick("QStream", S)
		frozen = 0
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		frozen = 1

		sleep(1)
	if(icon_state == "Quick Attack") icon_state = null
	frozen = 0
	NoRunDelay = 0
//Spider Web Spiderweb//----------------------------------------------------------------------------
obj/Moves/Spider_Web
obj/Moves/Spikes
/*	Type = "Ground"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 400
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Spikes(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)

mob/Pokemon/proc/Spikes(var/obj/Moves/M)
	for(var/mob/Watcher/W in view(src,20))
	for(var/i = 1, i <= 4, i++)
		var/obj/Overworld/Earthquake_Crack/EC = new
		switch(i)
			if(1) EC.loc = locate(x + rand(1,4), y + rand(1,4), z)
			if(2) EC.loc = locate(x - rand(1,4), y - rand(1,4), z)
			if(3) EC.loc = locate(x + rand(1,4), y - rand(1,4), z)
			if(4) EC.loc = locate(x - rand(1,4), y + rand(1,4), z)
		flick("SpikeFire", EC)
		sleep(3)
		var/area/A = src.loc
		A.FieldStatus = "Spikes"
		A.FieldStatusUser = src.Owner*/
obj/Moves/Spike_Cannon
//Spite//-------------------------------------------------------------------------------------------------------------------------
obj/Moves/Spite
	Type = "Ghost"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Spite(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 4)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/
	Spite_Overlay

mob/Pokemon/proc/Spite(var/obj/Moves/M)
	var/obj/Overworld/Spite_Overlay/SO = new
	flick("Fire",src)
	FindTarget()
	var/mob/Pokemon/Pokemon = Target
	if(!isPokemon(Pokemon)) return
	if(Pokemon)
		if(get_dist(src,Pokemon) >4) return
		SO.icon = Pokemon.icon
		SO.icon_state = "Pushback"
		SO.icon += rgb(0,0,0,150)
		var/obj/Moves/Move = Pokemon.LastAttack
		var/mob/Player/O2 = GetOwner(Owner)
		if(Move)
			var/mob/Player/O = GetOwner(Pokemon.Owner)
			O<<System("[Pokemon]'s [Move] lost 4 PP!")
			O2<<System("[Pokemon]'s [Move] lost 4 PP!")
			Move.PP -= 4
		else O2<<System("[src]'s Spite failed...")
		spawn()
			for(var/i = 1, i <= 20, i++)
				SO.pixel_y = rand(-8,8)
				SO.pixel_x = rand(-8,8)
				Pokemon.overlays += SO
				sleep(1)
				Pokemon.overlays -= SO
			del SO





obj/Moves/Splash
	Type = "Normal"
	Range = "Status"
	PP = 40
	MPP = 40
	Power = 0
	Wait_Time = 20
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Splash(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 5)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)




mob/Pokemon/proc/Splash(var/obj/Moves/M)
	flick_overlay('Moves.dmi', "Splash")
	for(var/mob/Pokemon/P in view())
		P.DeathCheck(src)
//Spit Up//Spitup//-----------------------
obj/Moves/Spit_Up
//Spore//
obj/Moves/Spore
	Type = "Grass"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 200
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Spore(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)




mob/Pokemon/proc/Spore(var/obj/Moves/M)
	for(var/turf/T in view(src,5))
		spawn()
			var/obj/Overworld/SleepPowder/SP = new(T)
			M.Parts += SP
			SP.icon_state = "Stun Spore"
			SP.Center = src.loc
			spawn(18)
				if(!SP) continue
				spawn(6) del SP
				for(var/mob/Pokemon/P in SP.loc)
					if(P == src) continue
					spawn() P.Sleep(src)
					break
//SteelWing//Steel Wing //Steel_Wing //------------------------------------------------------------------------------------
obj/Moves/Steel_Wing
	Type = "Steel"
	Range = "Physical"
	Power = 70
	PP = 25
	MPP = 25
	Wait_Time = 105
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Steel_Wing(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x-1 == DEF.x || ATK.x+1 == DEF.x || ATK.y+1 == DEF.y || ATK.y-1 == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()

obj/Overworld/
	icon = 'Moves.dmi'
	Wing_Attack
		New()
			spawn(20) del src


mob/Pokemon/proc/Steel_Wing(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Wing_Attack/W = new(get_step(src,turn(dir,90)))
	var/obj/Overworld/Wing_Attack/WW = new(get_step(src,turn(dir,-90)))

	W.icon = icon
	W.icon_state = "Wing Attack"
	WW.icon = icon
	WW.icon_state = "Wing Attack2"
	W.icon += rgb(255,255,255)
	WW.icon += rgb(255,255,255)
	icon_state = "Tackle"
	frozen = 1
	NoRunDelay = 1
	for(var/i=1, i<7, i++)
		W.dir = dir
		WW.dir = dir
		for(var/mob/Pokemon/PKMN in W.loc)
			if(PKMN == src) continue
			PKMN.overlays += image('Moves.dmi',"Aerial Ace")
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		for(var/mob/Pokemon/PKMN in WW.loc)
			if(PKMN == src) continue
			PKMN.overlays += image('Moves.dmi',"Aerial Ace")
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		frozen = 0
		if(src && src.icon_state == "Tackle")
			frozen = 0
			if(!O)
				step(src,src.dir)
			if(O) if(get_step(O.ControlingPokemon,src.dir) in view(O.client))
				step(src,src.dir)
			frozen = 1
			missile(W, W.loc, get_step(src,turn(src.dir,90)))
			missile(WW, WW.loc, get_step(src,turn(src.dir,-90)))
			W.loc = get_step(src,turn(src.dir,90))

			WW.loc = get_step(src,turn(src.dir,-90))
			for(var/mob/Pokemon/PKMN in W.loc)
				if(PKMN == src) continue
				PKMN.overlays += image('Moves.dmi',"Aerial Ace")
				spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
				PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, src))
				Target = PKMN
				PKMN.DeathCheck(src)
			for(var/mob/Pokemon/PKMN in WW.loc)
				if(PKMN == src) continue
				PKMN.overlays += image('Moves.dmi',"Aerial Ace")
				spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
				PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, src))
				PKMN.DeathCheck(src)
			sleep(pick(1,0,0))
/*		if(!O)
			step(src,dir)
		if(O) if(get_step(O.ControlingPokemon,dir) in view(O.client))
			step(src,dir)
		frozen = 1

		W.loc = get_step(src,turn(dir,90))
		WW.loc = get_step(src,turn(dir,-90))
		sleep(1)*/
	frozen = 0
	del WW
	del W
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
//Stockpile//----------------------------------------------------------------------
obj/Moves/Stockpile
//Stomp//---------------------------------------------------------------------------------------
obj/Moves/Stomp
	Type = "Normal"
	Range = "Physical"
	Power = 65
	PP = 20
	MPP = 20
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Stomp(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)


mob/Pokemon/proc/Stomp(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Scratch/H = new(get_step(src, dir)) //The Horn appears in front of them.
	H.icon = icon
	flick("Physical", src)
	flick("Stomp",H)
	NoRunDelay = 1
	//Tackle Part
	if(O)
		if(O.client)
			if(get_step(src,SetDir) in view(O.client))
				step(src,SetDir)
				missile(H, src, get_step(H, SetDir))
				step(H,SetDir)
		else
			step(src,SetDir)
			missile(H, src, get_step(H, SetDir))
			step(H,SetDir)
	else
		step(src,SetDir)
		missile(H, src, get_step(H, SetDir))
		step(H,SetDir)
	sleep(2)
	// Foot Part
	spawn(0)
		for(var/mob/MOB in H.loc)
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	spawn(0)
		for(var/mob/MOB in get_step(H.loc,H.dir))
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
	M.Hit = new/list

	spawn(10) del H
	NoRunDelay = 0
//String Shot//----------------------------------------------------------------------------------
obj/Moves/String_Shot
	Type = "Normal"
	Range = "Status"
	Power = 40
	PP = 35
	MPP = 35
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.StringShot(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/String_Shot
	layer = 100
	icon = 'Moves.dmi'
	New()
		spawn(50)
			del src


mob/Pokemon/proc/StringShot(var/obj/Moves/M)
	frozen = 1

	var/obj/Overworld/String_Shot/S1 = new(get_step(src,src.dir))
	S1.icon_state = "String Shot 2,1"
	S1.dir = dir
	M.Parts += S1
	var/obj/Overworld/String_Shot/S2 = new(get_step(S1,src.dir))
	S2.icon_state = "String Shot 2,2"
	S2.dir = dir
	M.Parts += S2
	var/obj/Overworld/String_Shot/S3 = new(get_step(S2,turn(S1.dir,90)))
	S3.icon_state = "String Shot 1,2"
	S3.dir = dir
	M.Parts += S3
	var/obj/Overworld/String_Shot/S4 = new(get_step(S2,turn(S1.dir,-90)))
	S4.icon_state = "String Shot 3,2"
	S4.dir = dir
	M.Parts += S4

	var/list/Affected = list()
	for(var/i = 1, i <= 6, i ++)
		for(var/obj/O in M.Parts)
			for(var/mob/Pokemon/P in O.loc)
				if(isPokemon(P) && P.Ability == "Clear Body") return
				if(Affected.Find(P)) continue
				Affected += P
				if(P.TempStats["SPD"] <= -5) continue
				P.GiveTempStat(src,"SPD",-1)
				if(P) P.GiveTempStat(src,"SPD",1,600)
				if(!P.Target) P.Target = src
		sleep(5)


	frozen = 0



//Stun Spore//----------------------------------------------------------------------------------------------------------------
obj/Moves/Stun_Spore
	name = "Stun Spore"
	Type = "Grass"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.StunSpore(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= 3)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/StunSpore
	icon = 'Moves.dmi'
	icon_state = "Blank"
	layer = 100
	SteppedOn(D)
		if(istype(D,/obj/Overworld/Ember))
			del src
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			if(P.Owner) P.Target = null
			if(owner != P || P.Status != "Paralysis")
				for(var/obj/Overworld/StunSpore/PP in Center)
					P.StepAway = PP
		return ..()


mob/Pokemon/proc/StunSpore(var/obj/Moves/M)
	for(var/turf/T in view(src,3))
		spawn()
			var/obj/Overworld/StunSpore/SP = new(T)
			M.Parts += SP
			SP.icon_state = "Stun Spore"
			SP.Center = src.loc
			spawn(18)
				if(!SP) continue
				for(var/mob/Pokemon/P in SP.loc)
					if(P == src) continue
					spawn() P.Paralysis(src)
					del SP
					break
				sleep(6)
				del SP
//Submission//-----------------------------------------------------------------------------------------------------------------
obj/Moves/Submission
obj/Moves/Substitute
//Sunny Day//-------------------------------------------------------------------------------------------------------------------
obj/Moves/Sunny_Day
	Type = "Fire"
	Range = "Status"
	PP = 5
	MPP = 5
	Wait_Time = 900
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Sunny_Day(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)

mob/Pokemon/proc/Sunny_Day(var/obj/Moves/M)
	var/area/Area = loc.loc
	var/DanceSteps = 5

	if(Area.WeatherID) //If there is already a weather effect in place, the dance will take longer.
		DanceSteps += 5

	SecondaryStatus["Attacking"] = 1
	for(var/i = 1, i<= DanceSteps, i++)
		dir = pick(1,2,4,8)
		flick(pick("Fire","Physical"), src)
		sleep(10)
	SecondaryStatus["Attacking"] = 0

	Area.WeatherID = "Sunny Day"
	//Add the Overlay to everyone.
	for(var/mob/Watcher/W in view(20, src))
		var/mob/Player/P = W.Owner
		if(!P) continue
		P.TimeHUD.WeatherEffect = "Sunny Day"
		P.UpdateDayHUD()
		P<<System("The Sun begins to shine brightly.")
		spawn(1500)
			if(P)
				if(P.TimeHUD.WeatherEffect == "Sunny Day") P.TimeHUD.WeatherEffect = null
				P.UpdateDayHUD()

	spawn(1500) if(Area.WeatherID == "Sunny Day") Area.WeatherID = null
//Super Fang//Superfang//-------------------------------------------------------------------------------------------------------------------
obj/Moves/Super_Fang
	Type = "Normal"
	Range = "Physical"
	Power = 30
	PP = 10
	MPP = 10
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Super_Fang(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)



mob/Pokemon/proc/Super_Fang(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Super Fang", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - round(MOB.HP/2))
					MOB.DeathCheck(src)
obj/Moves/Superpower
//Supersonic//---------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Supersonic
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Supersonic(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!isPokemon(DEF)) return
		if(DEF.SecondaryStatus["Confused"]) return
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,3)
			if(get_dist(ATK, DEF) <= dist)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Supersonic



mob/Pokemon/proc/Supersonic(var/obj/Moves/M)
	if(dir == 5 || dir == 6 || dir == 9 || dir == 10) dir = turn(dir,pick(45,-45))
	//if(dir != 1 || dir != 2 || dir != 4 || dir != 8) dir = turn(dir, pick(-45,45))

	frozen = 1
	var/obj/Overworld/Supersonic/S = new (get_step(src,dir))

	S.dir = dir
	M.Parts += S

	flick('SuperSonic.dmi',S)
	switch(S.dir)
		if(1) S.pixel_x = -32
		if(8)
			S.pixel_y = -24
			S.pixel_x = -64
		if(2)
			S.pixel_x = -32
			S.pixel_y = -64
		if(4) S.pixel_y = -24
	//The turfs that will be affected
	var/list/Turfs = list()
	Turfs += S.loc
	for(var/i = -45, i <= 45, i += 45)
		Turfs += get_step(S.loc,turn(src.dir,i))
	var/turf/T = get_step(S.loc,S.dir)
	for(var/i = -45, i <= 45, i += 45)
		Turfs += get_step(T,turn(src.dir,i))

	for(var/i = 0 , i <= 30, i+= 6)
		for(var/turf/TT in Turfs)
			for(var/mob/Pokemon/P in TT)
				if(prob(90)) // 10% chance of not confusing the target.
					P.Confuse(src)
		sleep(5)

	del S
	frozen = 0


// //----------------------------------------------------------------------------------------------------------------------------
obj/Moves
	Swagger
	Swallow

//Sweet Scent//Sweetscent//------------------------------------------------------------------------------
obj/Moves/Sweet_Scent
	Type = "Grass"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 110
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sweet_Scent(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		set background = 1
		if(!istype(DEF,/mob/Pokemon))
			DEF = null
			ATK = null
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(DEF.Status) break
			if(get_dist(ATK,DEF) <= pick(1,1,1,1,1,2))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else if(ATK) ATK.Step_To(DEF)
			sleep(SPEED)



obj/Overworld/Sweet_Scent
	icon = 'Moves.dmi'
	icon_state = "Sweet Scent"
	layer = 100
	New()
		..()
		spawn(20) del src


mob/Pokemon/proc/Sweet_Scent(var/obj/Moves/M)
	for(var/turf/T in view(src,1))
		spawn()
			var/obj/Overworld/Sweet_Scent/C = new(T)
			for(var/mob/Pokemon/P in C.loc)
				if(P == src) continue
				if(P.Owner == Owner || P.TempStats["SPD"] <= -5) return
				P.GiveTempStat(src,"SPD",-1)
				if(P) P.GiveTempStat(src,"SPD",1,700)
				if(!P.Target) P.Target = src
			sleep(20)
			del C

//Sweet Kiss//SweetKiss//-----------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Sweet_Kiss
	Type = "Normal"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Sweet_Kiss(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Sweet_Kiss
	icon = 'Moves.dmi'
	icon_state = "Heart2"
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			if(prob(90)) // 10% chance of not confusing the target.
				P.Confuse(owner)
			density = 0


		else del src
mob/Pokemon/proc/Sweet_Kiss(var/obj/Moves/M)
	flick("Physical",src)
	frozen = 1

	flick_overlay('Moves.dmi', "Sweet Kiss")
	var/obj/Overworld/Sweet_Kiss/A = new(src.loc)
	A.owner = src
	A.dir = dir
	walk(A,A.dir,1)

	sleep(10)
	frozen = 0
	FindTarget()
//Swift//-----------------------------------------------------------------------------------------
obj/Moves/Swift
	Type = "Normal"
	Range = "Special"
	Power = 12 //Possibly hits a total of 6 times
	PP = 20
	MPP = 20
	Wait_Time = 160
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Swift(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 4)
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				spawn() Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Swift
	icon = 'Moves.dmi'
	icon_state = "Star1"
	layer = 100
	New()
		spawn(200)
			del src


mob/Pokemon/proc/Swift(var/obj/Moves/M)
	FindTarget()
	if(Target && get_dist(Target, src) <= 4)
		var/atom/TLoc = Target.loc
		flick("Physical",src)
		for(var/i = 1, i <= 6, i++)
			var/LastLoc = src
			sleep(4)
			var/obj/Overworld/Swift/S = new
			S.owner = src
			var/list/DIR = list(1,5,4,6,2,10,8,9,1)
			spawn(0)
				for(var/d in DIR)
					var/Distance = 3
					if(d == 1 || d == 2 || d == 4 || d == 8) Distance = 4
					if(!Target)
						del S
						break
					var/NewLoc = Get_Steps(TLoc, d, Distance)

					missile(S, LastLoc, NewLoc)
					sleep(get_dist(LastLoc, NewLoc))
					LastLoc = NewLoc
					S.loc = NewLoc
				var/atom/TT
				var/counter
				var/GDist = get_dist(S, Target)
				while(S)
					if(!Target || !Target.loc || Target.z != S.z)
						del S
						break
					counter += 1
					if(counter < GDist - 1 && Target) step_towards(S, Target)
					else
						if(!TT && Target)
							TT = Target.loc
							step_towards(S,TT)
						else
							step(S,S.dir)

					for(var/mob/MR in S.loc)
						MR.HP = max(0,MR.HP - src.BattleDamage(MR,M))
						MR.DeathCheck(src)
						S.loc = MR.loc
						S.density = 0
						del S
					if(S && S.loc == TT) del S
					sleep(1)



	FindTarget()
//Swords Dance//--------------------------------------------------------------------------------------------------------
obj/Moves/Swords_Dance
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 450
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Swords_Dance(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Swords_Dance(var/obj/Moves/M)
	if(TempStats["ATK"] >= 6) return
	overlays += image('Moves.dmi',"Sword Dance")
	underlays += image('Moves.dmi',"Sword Dance Back")
	GiveTempStat(src,"ATK",2)
	spawn(50)
		overlays -= image('Moves.dmi',"Sword Dance")
		underlays -= image('Moves.dmi',"Sword Dance Back")
	GiveTempStat(src,"ATK",-2,600) //Waits 1 minute before returning the stat.
//Synthesis//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Synthesis
	Type = "Grass"
	Range = "Status"
	Power = 5
	PP = 1
	MPP = 1
	Wait_Time = 250
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(O.Court && !O.MasterGMCheck())
			O<<System("You cannot use this within Battle..")
			return
		if(..())
			P.Synthesis(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
//		var/mob/Pokemon/P = Owner
//		var/mob/Player/O = GetOwner(P.Owner)
		if(1)
			spawn() Attack()

obj/Overworld/Synthesis
	New()
		..()
		pixel_x = rand(-21,21)
		flick("Synthesis", src)
		sleep(20)
		del src
	icon = 'Moves.dmi'


mob/Pokemon/proc/Synthesis(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	if(O) if(1) return
	frozen = 1
	for(var/i = 1, i <= 14,i++)
		if(icon_state != null) return
		spawn(i*2)
			var/obj/Overworld/Synthesis/CC = new(loc)
			M.Parts += CC
			sleep(2)
			spawn(20)
				del CC

		HP = min(MHP, HP + ((MHP / 3)*2))
	frozen = 0
//Taunt//
obj/Moves/Taunt
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Taunt(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()


mob/Pokemon/proc/Taunt(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	flick_overlay('Hypnosis.dmi', "Taunt",-16,-16)
	if(!P || !istype(P,/mob/Pokemon)) return

	if(get_dist(Target,src) <=3)
		P.flick_overlay('Moves.dmi', "Rage")
		P.SecondaryEffect["Taunt"] = 1
		var/mob/Player/O = GetPlayer(P.Owner)
		if(O) O<<System("[P] has been taunted. [P] is restricted to damage dealing moves")
		spawn(600)
			P.SecondaryEffect["Taunt"] = 0
//Tackle//---------------------
obj/Moves/Tackle
	Type = "Normal"
	Range = "Physical"
	Power = 30
	PP = 35
	MPP = 35
	Wait_Time = 30
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Tackle(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				var/list/Iconstates = icon_states(Owner.icon)
				if(Iconstates.Find("HUDTackle"))
					icon = Owner.icon
					icon_state = "HUDTackle"


mob/Pokemon/proc/Tackle(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<3, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0

//Tail Whip//
obj/Moves/Tail_Whip
	Type = "Normal"
	Range = "Status"
	icon_state = "HUDTailWhip"
	Power = 35
	PP = 40
	MPP = 40
	Wait_Time = 40
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Tail_Whip(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 4 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()
				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		spawn(20)
			overlays = null
			icon_state = null
			if(Owner)
				icon = Owner.RICON
				icon_state = "HUDTailWhip"



obj/Overworld/Tail_Whip
	icon_state = "Blank"
	density = 0
	New()
		spawn(40) del src

mob/Pokemon/proc/Tail_Whip(var/obj/Moves/M)
	var/obj/Overworld/Tail_Whip/T = new(get_step(src,src.dir))
	T.dir = dir
	dir = turn(dir,180)
	T.icon = icon
	frozen = 1
	spawn(10) frozen = 0
	flick("Tail Whip",T)
	for(var/mob/Pokemon/P in view(4))
		if(isPokemon(P) && P.Ability == "Clear Body") return
		if(TempStats["DEF"] >= -5 && P != src)
			P.GiveTempStat(src,"DEF",-1)
			if(P) P.GiveTempStat(src,"DEF",1,600)





//Take-Down//--------------------------------------------------------------------------------------------------
obj/Moves/Take_Down
	Type = "Normal"
	Range = "Physical"
	Power = 90
	PP = 20
	MPP = 20
	Wait_Time = 169
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Take_Down(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(2,3,3)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDTackle"


mob/Pokemon/proc/Take_Down(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	icon_state = "Tackle"
	NoRunDelay = 1
	for(var/i=1, i<=3, i++)
		if(icon_state != "Tackle") break
		if(O)
			if(O.client)
				if(get_step(src,SetDir) in view(O.client)) step(src,SetDir)
			else step(src,SetDir)
		else step(src,SetDir)
		sleep(2)
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0
//Thrash
obj/Moves/Thrash
	Type = "Normal"
	Range = "Physical"
	Power = 90
	PP = 20
	MPP = 20
	Wait_Time = 275
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thrash(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)


mob/Pokemon/proc/Thrash(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	spawn(4) frozen = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Scratch", O)
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
obj/Moves/Teeter_Dance
//Tickle//
obj/Moves/Tickle
	Type = "Normal"
	Range = "Status"
	Power = 35
	PP = 35
	MPP = 35
	Wait_Time = 50
	Distance = "Projectile"
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Tickle(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

mob/Pokemon/proc/Tickle(var/obj/Moves/M)
	FindTarget()
	var/mob/Pokemon/P = Target
	if(get_dist(P,src) >= 3)
		var/mob/Player/O = GetOwner(Owner)
		if(O) O<<System("Tickle has failed!")
		return
	if(!P || !istype(P,/mob/Pokemon)) return
	P.overlays += image('Moves.dmi', "Tickle")
	if(P.Owner == Owner || P.TempStats["ATK"] <= -5) return
	spawn() missile(/obj/Overworld/Growl, src, P)
	P.GiveTempStat(src,"ATK",-1)
	if(P)
		P.GiveTempStat(src,"ATK",1,600)
		P.GiveTempStat(src,"DEF",1,600)
		if(!P.Target) P.Target = src
//Thief//
obj/Moves/Thief
//Thunder//---------------------------------------------------------------------------------------------------------------------------
obj/Moves/Thunder
	Type = "Electric"
	Range = "Special"
	Power = 120
	PP = 10
	MPP = 10
	Wait_Time = 180
	var/tmp/list/Affected = list()
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thunder(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 4 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				//This is the stepping proc so it doesn't just stand still whilst waiting for the Thunder
				var/TH = 1
				spawn(100)
					TH = 0
				spawn()
					while(TH)
						if(!ATK.loc || !DEF.loc) break
						if(ATK.Status == "Sleep") break
						if(prob(50)) if(get_dist(ATK, DEF) > 3)ATK.Step_To(DEF)
						if(prob(70)) if(get_dist(ATK, DEF) < 3) step_away(ATK,DEF)
						ATK.dir = get_dir(ATK,DEF)


						sleep(4)



				Attack()
				TH = 0
				return
				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)

mob/Pokemon/

	proc/Thunder(var/obj/Moves/Thunder/M)
		var/mob/Player/O = GetOwner(Owner)
		var/obj/Overworld/ThunderCrossHair/TCH = new (Get_Steps(src,src.dir,3))
		var/area/Area = loc.loc
		var/image/I
		spawn(1) while(TCH)
			FindTarget(20)
			if(Area.WeatherID == "Rain Dance") //It is raining
				if(Target)TCH.loc = Target.loc
			else if(!LockOn) TCH.loc = Get_Steps(src,src.dir,3)
			else if(LockOn.loc) TCH.loc = LockOn

			sleep(1)
		for(var/i = 5, i >= 1, i--)
			if(I) del I
			if(O.client)
				I = image('Moves.dmi', TCH ,"ThunderCrossHair[i]",MOB_LAYER+1)
				I.layer = 62
				O << I
			sleep(10)
		icon_state = "Jolt"
		var/obj/Overworld/Thunder/T = new (TCH.loc)
		for(var/mob/P in T.loc) //Check if there was a direct Hit!
			if(isPlayer(P) || isPokemon(P))
				if(M.Affected.Find(P)) continue
				if(isPokemon(P)) flick("Jolt",P)
				P.HP = max(0,P.HP - BattleDamage(P,M))
				M.Affected += P
				if(prob(20)) Paralysis(src)
				P.DeathCheck(src)
		del TCH
		var/list/DIR = list(2,4,5,6,8,9,10)
		for(var/i in DIR)
			spawn(1)
				var/obj/Overworld/ThunderElectric/TE = new (T.loc)
				TE.dir = i
				TE.owner = src
				TE.AFF = M
				for(var/j = 1, j <= 2, j++)
					flick(TE, "Electricity")
					step(TE, TE.dir)
					for(var/mob/P in TE.loc) //Check if one of the bolts hit the Pokemon
						if(isPlayer(P) || isPokemon(P))
							if(M.Affected.Find(P)) continue
							if(isPokemon(P)) flick("Jolt",P)
							P.HP = max(0,P.HP - BattleDamage(P,M))
							M.Affected += P
							if(prob(10)) Paralysis(src)
							P.DeathCheck(src)
					sleep(5)
				del TE
		if(icon_state == "Jolt") icon_state = null
		M.Affected = list()




obj/Overworld/ThunderCrossHair
	icon = 'Moves.dmi'
	icon_state = "Blank"//"ThunderCrossHair"
	New()
		spawn(100)
			del src
obj/Overworld/Thunder
	icon = 'Thunderz.dmi'
	icon_state = "Bolt"
	pixel_x = -32
	New()
		spawn(100)
			del src
obj/Overworld/ThunderElectric
	var/obj/Moves/AFF
	icon = 'Thunder.dmi'
	New()
		spawn(100)
			del src //Just to ensure deletion
	Bump(m)
		if(istype(m,/obj/Overworld))
			var/obj/O = m
			O.BumpedInto(src)
		if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
			var/mob/M = m
			if(isPokemon(M)) flick("Jolt",M)
			AFF.Power = 100
			M.HP = max(0,M.HP - owner.BattleDamage(M,AFF))
			AFF.Power = 120
			M.DeathCheck(owner)
		loc = null

//Thunderbolt//--------------------------------------------------------------------------------------------------------------
obj/Moves/Thunderbolt
	Type = "Electric"
	Range = "Special"
	Power = 45
	PP = 15
	MPP = 15
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thunderbolt(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			if(ATK.Level >= 20)
				sleep(1)
				if(isPokemon(DEF))
					var/mob/Pokemon/P = DEF
					if(P.Type1 == "Ground" || P.Type2 == "Ground") return //If they are smart enough, they'll know not to attack with electric type moves

			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				var/T = 1
				spawn()
					while(T)
						if(!ATK.loc || !DEF.loc) break
						if(ATK.Status == "Sleep") break
						ATK.Step_To(DEF)
						sleep(3)
				ATK.Automated_Thunderbolt(src, DEF)
				T = 0
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
obj/Overworld/Thunderbolt_Tail
	icon = 'Moves.dmi'
	icon_state = "Thunderbolt"
	density = 0
	New()
		..()
		spawn(40) del src
obj/Overworld/Thunderbolt
	icon = 'Moves.dmi'
	icon_state = "Thunderbolt"
	layer = 100
	density = 1
	var/list/Tail = list()
	Move(loc,dir)
		for(var/obj/O in Tail)
			step(O,dir)
		..()
	New()

		spawn(30)
			flick("Thunderbolt Fade",src)
			for(var/obj/O in Tail)
				flick("Thunderbolt Fade",O)
				spawn(5)
					del O
			spawn(10) del src

	Bump(D)
		walk(src, 0)
		density = 0
		icon_state = "Thunderbolt Fade"
		for(var/obj/O in Tail)
			flick("Thunderbolt Fade",O)
			spawn(5)
				del O
		spawn(20) del src
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			var/obj/Moves/Thunderbolt/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			density = 0
			del A
			sleep(5)

mob/Pokemon/proc/Automated_Thunderbolt(var/obj/Moves/M, var/mob/DEF)
	for(var/i=0, i<3, i++)
		if(Status == "Sleep") return //They have fallen asleep, end the assault
		if(dir == 5 || dir == 6 || dir == 9 || dir == 10)
			var/list/D = list(4,8,1,2)
			for(var/I in D)
				var/atom/A = get_step(src,I)
				if(A.x == DEF.x || A.y == DEF.y)
					step(src, I)
					sleep(2)
					dir = get_dir(src,DEF)
					break
		if(dir == 5 || dir == 6 || dir == 9 || dir == 10) dir = turn(dir,pick(45,-45))
		if(icon_state != null) return //They might be asleep or being pushed back icon_state = "Jolt"
		var/obj/Overworld/Thunderbolt/A = new(src.loc)
		A.dir = dir
		A.owner = src
		step(A,A.dir)
		sleep(1)
		var/obj/Overworld/Thunderbolt_Tail/T1 = new(get_step(A,turn(A.dir,180)))
		T1.dir = A.dir
		A.Tail += T1
		step(A,A.dir)
		sleep(1)
		var/obj/Overworld/Thunderbolt_Tail/T2 = new(get_step(T1,turn(T1.dir,180)))
		T2.dir = A.dir
		A.Tail += T2

		T1.owner = src
		T2.owner = src
		walk(A,A.dir,1)
		sleep(3)
		if(icon_state == "Jolt" && Status != "Sleep") icon_state = null
		sleep(10)
	FindTarget() //???


mob/Pokemon/proc/Thunderbolt(var/obj/Moves/M)
	for(var/i=0, i<3, i++)
		icon_state = "Jolt"
		var/obj/Overworld/Thunderbolt/A = new(src.loc)
		A.dir = dir
		A.owner = src
		step(A,A.dir)
		sleep(1)
		var/obj/Overworld/Thunderbolt_Tail/T1 = new(get_step(A,turn(A.dir,180)))
		T1.dir = A.dir
		A.Tail += T1
		step(A,A.dir)
		sleep(1)
		var/obj/Overworld/Thunderbolt_Tail/T2 = new(get_step(T1,turn(T1.dir,180)))
		T2.dir = A.dir
		A.Tail += T2

		T1.owner = src
		T2.owner = src
		walk(A,A.dir,1)
		sleep(3)
		if(icon_state == "Jolt") icon_state = null
		sleep(10)
	FindTarget() //???
//Thunder Punch!//Thunderpunch//-------------------------------------------------------------------------------------
obj/Moves/Thunder_Punch
	Type = "Electric"
	Range = "Physical"
	Power = 75
	PP = 15
	MPP = 15
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thunder_Punch(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(1,2) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()

obj/Overworld/Electricity
	icon = 'Thunder.dmi'



mob/Pokemon/proc/Thunder_Punch(var/obj/Moves/M)
	var/obj/Overworld/Scratch/O = new(get_step(src,src.dir))
	O.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(4)
		frozen = 0
		SecondaryStatus["Attacking"] = 0
	O.icon_state = "Blank"
	O.dir = dir
	flick("Physical", src)
	flick("Thunder Punch", O)
	var/list/DIR = list(1,2,4,5,6,8,9,10)
	for(var/i in DIR)
		spawn()
			var/obj/Overworld/Electricity/E = new(O.loc)
			E.dir = i
			flick("Electricity",E)
			step(E,E.dir)
			sleep(3)
			del E
	if(O.loc)
		spawn(0)
			for(var/mob/MOB in O.loc)
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					if(isPokemon(MOB))
						var/mob/Pokemon/PPP = MOB
						if(PPP.Type1 != "Ground" || PPP.Type2 != "Ground") spawn() PPP.Paralysis(src)

					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)
		spawn(0)
			for(var/mob/MOB in get_step(O.loc,O.dir))
				if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
					if(isPokemon(MOB))
						var/mob/Pokemon/PPP = MOB
						if(PPP.Type1 != "Ground" || PPP.Type2 != "Ground") spawn() PPP.Paralysis(src)

					MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
					MOB.DeathCheck(src)

//Thunder Wave//ThunderWave//----------------------------------------------------------------------------------------------------
obj/Moves/Thunder_Wave
	Type = "Electric"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thunder_Wave(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (IsBetween(ATK.x, DEF.x-1,DEF.x+1) || IsBetween(ATK.y, DEF.y-1,DEF.y+1)))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	Thunder_Wave
		icon = 'Supersonic.dmi'
		icon_state = "Thunder Wave"
		pixel_y = -32
		pixel_x = -32


mob/Pokemon/proc/Thunder_Wave(var/obj/Moves/M)
	var/obj/Overworld/Thunder_Wave/V = new(loc)
	M.Parts += V
	V.dir = dir
	V.owner = src
	frozen = 1
	SecondaryStatus["Attacking"] = 1
	spawn(13) if(V) V.loc = null
	while(V.loc)

		if(V)
			var/list/Turfs = list()

			Turfs += V.loc
			Turfs += get_step(V.loc, turn(V.dir, 90))
			Turfs += get_step(V.loc, turn(V.dir, -90))

			for(var/turf/T in Turfs)
				for(var/mob/Pokemon/P in T)
					if(P != src)
						if(P.Owner && Owner)
							if(P.Type1 == "Ground" || P.Type2 == "Ground") continue
							var/mob/Player/O1 = GetOwner(Owner)
							var/mob/Player/O2 = GetOwner(P.Owner)
							if(O1.Court != O2.Court || !O1.Court  || !O2.Court)
								continue

						spawn() P.Paralysis(src)


			sleep(1)
			step(V,V.dir)

	del V
	for(var/obj/E in M.Parts)
		del E
	frozen = 0
	SecondaryStatus["Attacking"] = 0


//Thunderbolt//
obj/Moves/Thundershock
	Type = "Electric"
	Range = "Special"
	Power = 40
	PP = 30
	MPP = 30
	Wait_Time = 40
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Thundershock(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack() //Why is this here?....


obj/Overworld/
	icon = 'Moves.dmi'
	Thundershock
		density = 1
		invisibility = 1
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Thundershock/V = new
				if(isPokemon(M)) flick("Jolt",M)
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				if(isPokemon(M))
					var/mob/Pokemon/P = M
					if(prob(20)) if(P.Type1 != "Ground" || P.Type2 != "Ground") P.Paralysis(owner)
				M.DeathCheck(owner)
			loc = null

	TSExtra
		density = 1
		icon_state = "Thundershock"
		New()
			spawn(100) del src //Incase something fucks up.


mob/Pokemon/proc/Thundershock(var/obj/Moves/M)
	var/obj/Overworld/Thundershock/V = new(loc)
	M.Parts += V
	V.dir = dir
	var/SetDir = V.dir
	V.owner = src
	icon_state = "Jolt"
	spawn(13) if(V) V.loc = null

	while(V.loc)
		step(V,SetDir)
		if(V)
			var/obj/Overworld/TSExtra/E = new(V.loc)
			E.layer = layer - 1
			E.owner = V.owner
			M.Parts += E
			E.dir = SetDir
			sleep(1)
			//if(V) if(V.loc) sleep(1)
	del V
	for(var/obj/E in M.Parts)
		del E
	if(icon_state == "Jolt") icon_state = null
//Torment//
obj/Moves/Torment
//Toxic//
obj/Moves/Toxic
	Type = "Poison"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Toxic(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else

				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'
	Toxic
		density = 1
		icon_state = "ToxicHead"
		layer = 10
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Pokemon))
				var/mob/Pokemon/P = m
				if(istype(P,/mob/Pokemon))
					P.StatusKiller = src.owner
					P.Poison(owner)
			density = 0

	TExtra
		density = 1
		icon_state = "ToxicBody"


mob/Pokemon/proc/Toxic(var/obj/Moves/M)
	set background = 1
	var/obj/Overworld/Toxic/P = new(loc)
	var/list/Parts = list()
	P.dir = dir
	var/SetDir = P.dir
	P.owner = src
	frozen = 1
	spawn(8) if(P) P.density = 0
	flick("Fire",src)
	while(P.density)

		var/obj/Overworld/TExtra/E = new(P.loc)

		step(P,SetDir)

		if(length(Parts) == 1)
			E.icon_state = "ToxicBody"
		if(!length(Parts))
			E.invisibility = 1

		E.layer = layer - 1
		E.owner = P.owner
		Parts += E
		E.dir = SetDir
		sleep(1)
	del P
	for(var/obj/E in Parts)
		spawn()
			E.density = 0
			E.icon_state = "Blank"
			del E
	frozen = 0
//Transform//------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Transform
	Type = "Normal"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Transform(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		Attack()



obj/Overworld/Absorb
	icon = 'Moves.dmi'
	layer = 100
	New()
		icon_state = "Leech[pick(1,2)]"
		pixel_y = rand(-10,10)
		pixel_x = rand(-10,10)

mob/Pokemon/proc/Transform(var/obj/Moves/M)
	FindTarget()
	var/mob/Player/POwner = GetOwner(Owner)
	var/mob/Pokemon/TransformTarget = Target
	if(Target && isPokemon(TransformTarget))
		TemporaryMoves["Type1"] = TransformTarget.Type1
		if(TransformTarget.Type2) TemporaryMoves["Type2"] = TransformTarget.Type2
		var/list/TargetMoves = list()
		for(var/obj/Moves/MM in TransformTarget.Moves)
			var/obj/Moves/M2 = new MM.type
			M2.PP = MM.PP
			M2.Owner = src
			TargetMoves += M2
		TemporaryMoves["Moves"] = TargetMoves
		flick("Transform", src)
		icon = TransformTarget.icon
		TemporaryMoves["RICON"] = TransformTarget.icon
		if(POwner) POwner.UpdateParty(1)


	else
		M.PP +=1
		M.WaitTime = 0
		return
mob/Pokemon/var
	tmp/list/TemporaryMoves = list()

//  //--------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Tri_Attack
	name = "Tri-Attack"
	Type = "Normal"
	Range = "Special"
	Power = 80
	PP = 10
	MPP = 10
	Wait_Time = 180
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.TriAttack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/TriAttack
	icon = 'SuperSonic.dmi'
	pixel_x = -32
	pixel_y = -32
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D


			var/obj/Moves/Tri_Attack/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			del A
			sleep(5)


		del src

mob/Pokemon/proc/TriAttack(var/obj/Moves/M)
	flick("Fire",src)
	var/obj/Overworld/TriAttack/A = new(src.loc)
	flick("TriAttack",A)
	A.owner = src

	A.dir = dir
	for(var/i = 1, i<= 8, i++)
		step(A,A.dir)
		for(var/mob/MOB in view(1,A.loc))
			if(M.Hit.Find(MOB)) continue //They've been hit
			if(MOB == src) continue //Don't attack the attacker
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				if(isPokemon(M))
					var/mob/Pokemon/PPP = MOB
					if(prob(6)) PPP.Burn(src)
					if(prob(6)) PPP.Paralysis(src)
					if(prob(6))
						var/mob/Player/O = GetOwner(PPP.Owner)
						var/mob/Player/O2 = GetOwner(Owner)
						if(O2) O2<<System("[PPP] is frozen solid!... or would be if Frozen Status was in.")
						if(O) O<<System("[PPP] is frozen solid!... or would be if Frozen Status was in.")
				MOB.DeathCheck(src)


		sleep(1)
	del A
	M.Hit = list()
	FindTarget()
obj/Moves
	Trick
	Triple_Kick
//Twineedle//
	Twineedle
obj/Moves/Twister
	Type = "Dragon"
	Range = "Special"
	Power = 40
	PP = 20
	MPP =20
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Twister(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		Attack()

obj/Overworld/Twister
	density = 0
	icon = 'Fireblast.dmi'
	icon_state = "Twister"
	pixel_x = -22
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)




mob/Pokemon/proc/Twister(var/obj/Moves/M)
	flick("Physical",src)
	var/obj/Overworld/Twister/G = new
	var/list/Hit = list()
	G.loc = loc
	G.owner = src
	FindTarget()
	var/atom/T
	if(Target) T = Target.loc
	if(Target)
		while(G)
			sleep(3)
			if(!G) break //In case G is deleted in that .3 seconds.
			step_towards(G,T)
			for(var/mob/MR in G.loc)
				if(Hit.Find(MR)) continue
				Hit += MR
				MR.HP = max(0,MR.HP - src.BattleDamage(MR,M))
				MR.DeathCheck(src)
				G.loc = MR.loc
				walk(G,0)
				G.density = 0
				spawn(10)
					del G
					return //If G is deleted, and for some reason the loop continues, it calls on null.loc. This should stop both loops if this happens..
			for(var/obj/Overworld/OO in range(G,2))
				if(istype(OO,/obj/Overworld/SleepPowder) || istype(OO,/obj/Overworld/PoisonPowder)|| istype(OO,/obj/Overworld/StunSpore))
					OO.owner = src
					step_away(OO,G)
	else
		var/D = src.dir
		while(G)
			sleep(3)
			step(G,D)
			for(var/obj/Overworld/OO in range(G,2))
				if(istype(OO,/obj/Overworld/SleepPowder) || istype(OO,/obj/Overworld/PoisonPowder))
					step_away(OO,G)
obj/Moves/
	Uproar
//Vicegrip//Vice Grip//ViceGrip//--------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/ViceGrip
	Type = "Normal"
	Range = "Physical"
	Power = 55
	PP = 30
	MPP = 30
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Vicegrip(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			var/dist = pick(1,2,2)
			if(get_dist(ATK, DEF) <= dist && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!

				Attack()

				break

			else
				ATK.Step_To(DEF)
			sleep(SPEED)
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUD Horn"


mob/Pokemon/proc/Vicegrip(var/obj/Moves/M)
	var/SetDir = dir
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Scratch/H = new(get_step(src, dir)) //The Horn appears in front of them.
	H.icon = icon
	flick("Physical", src)
	flick("Vicegrip",H)
	H.icon_state = "Vicegrip"
	NoRunDelay = 1
	//Tackle Part
	if(O)
		if(O.client)
			if(get_step(src,SetDir) in view(O.client))
				step(src,SetDir)
				missile(H, src, get_step(H, SetDir))
				step(H,SetDir)
		else
			step(src,SetDir)
			missile(H, src, get_step(H, SetDir))
			step(H,SetDir)
	else
		step(src,SetDir)
		missile(H, src, get_step(H, SetDir))
		step(H,SetDir)
	sleep(2)
	// Foot Part
	spawn(0)
		for(var/mob/MOB in H.loc)
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
				if(isPokemon(MOB))
					var/mob/Pokemon/p = MOB
					p.SecondaryStatus["ViceGrip"] = 1
					SecondaryStatus["ViceGrip"] = 1
					spawn(50)
						p.SecondaryStatus["ViceGrip"] = 0
						SecondaryStatus["ViceGrip"] = 0

	spawn(0)
		for(var/mob/MOB in get_step(H.loc,H.dir))
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				if(M.Hit.Find(MOB)) continue
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				MOB.DeathCheck(src)
				if(isPokemon(MOB))
					var/mob/Pokemon/p = MOB
					p.SecondaryStatus["ViceGrip"] = 1
					SecondaryStatus["ViceGrip"] = 1
					spawn(50)
						p.SecondaryStatus["ViceGrip"] = 0
						SecondaryStatus["ViceGrip"] = 0
	M.Hit = new/list

	spawn(10) del H
	NoRunDelay = 0
//Vine Whip//
obj/Moves/Vine_Whip
	Type = "Grass"
	Range = "Physical"
	Power = 45
	PP = 20
	MPP = 20
	Wait_Time = 70
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Vine_Whip(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'


	Vine_Whip
		density = 1
		invisibility = 1
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Vine_Whip/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			loc = null

	VWExtra
		density = 1
		icon_state = "Vine Whip"
		New()
			spawn(100) del src //Incase something fucks up.


mob/Pokemon/proc/Vine_Whip(var/obj/Moves/M)
	var/obj/Overworld/Vine_Whip/V = new(loc)
	M.Parts += V
	V.dir = dir
	var/SetDir = V.dir
	V.owner = src
	frozen = 1
	spawn(13) if(V) V.loc = null

	while(V.loc)
		step(V,SetDir)
		if(V)
			var/obj/Overworld/VWExtra/E = new(V.loc)
			E.layer = layer - 1
			E.owner = V.owner
			M.Parts += E
			E.dir = SetDir
			sleep(1)
			//if(V) if(V.loc) sleep(1)
	del V
	for(var/obj/E in M.Parts)
		del E
	frozen = 0

obj/Moves/Vital_Throw
obj/Moves/Volt_Tackle








//Water Gun//
obj/Moves/Water_Gun
	Type = "Water"
	Range = "Special"
	Power = 45
	PP = 20
	MPP = 20
	Wait_Time = 50
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Water_Gun(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
		for(var/obj/D in Parts)
			del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()


obj/Overworld/
	icon = 'Moves.dmi'


	Water_Gun
		density = 1
		icon_state = "WaterGun2"
		layer = 10
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Player) || istype(m,/mob/Pokemon))
				var/mob/M = m
				var/obj/Moves/Water_Gun/V = new
				M.HP = max(0,M.HP - owner.BattleDamage(M,V))
				del V
				M.DeathCheck(owner)
			density = 0

	WGExtra
		density = 1
		icon_state = "WaterGun"


mob/Pokemon/proc/Water_Gun(var/obj/Moves/M)
	var/obj/Overworld/Water_Gun/W = new(loc)
	M.Parts += W
	W.dir = dir
	var/SetDir = W.dir
	W.owner = src
	frozen = 1
	spawn(8) if(W) W.density = 0
	flick("Fire",src)
	while(W.density)

		var/obj/Overworld/WGExtra/E = new(W.loc)
		step(W,SetDir)
		if(length(M.Parts) == 1)
			E.icon_state = "WaterGun1"
		if(!length(M.Parts))
			E.invisibility = 1
		E.layer = layer - 1
		E.owner = W.owner
		M.Parts += E
		E.dir = SetDir
		sleep(1)
		if(!W) break
	del W
	for(var/obj/E in M.Parts)
		spawn()
			if(E)
				E.density = 0
				E.icon_state = "Blank"
				flick("WaterFade",E)
				sleep(6)
				del E
	frozen = 0






obj/Moves/Water_Pulse
	Type = "Water"
	Range = "Special"
	Power = 45
	PP = 20
	MPP = 20
	Wait_Time = 80
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Water_Pulse(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Water_Pulse
	icon = 'Fireblast.dmi'
	icon_state = "Water Pulse"
	pixel_x = -22
	pixel_y = -22
	layer = 100
	density = 0
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon) || istype(D,/mob/Player))

			var/mob/M = D
			if(isPokemon(M))
				var/mob/Pokemon/PPP = M
				if(prob(20)) PPP.Confuse(src)
			var/obj/Moves/Water_Pulse/A = new

			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			walk(src,0)
			del A
			sleep(5)


		del src

mob/Pokemon/proc/Water_Pulse(var/obj/Moves/M)
	flick("Fire",src)
	var/obj/Overworld/Water_Pulse/A = new(src.loc)
	A.owner = src

	A.dir = dir
	for(var/i = 1, i<= 8, i++)
		step(A,A.dir)
		for(var/obj/Overworld/SleepPowder/S in A.loc)
			del S
		for(var/mob/MOB in view(1,A.loc))
			if(M.Hit.Find(MOB)) continue //They've been hit
			if(MOB == src) continue //Don't attack the attacker
			if(istype(MOB,/mob/Player) || istype(MOB,/mob/Pokemon))
				M.Hit += MOB
				MOB.HP = max(0,MOB.HP - BattleDamage(MOB,M))
				if(!Status)
					if(prob(20))
						if(isPokemon(MOB))
							var/mob/Pokemon/PPP = MOB
							if(prob(20)) PPP.Confuse(src)
				MOB.DeathCheck(src)


		sleep(2)
	del A
	M.Hit = list()
	FindTarget()
//Water Sport//Watersport//
obj/Moves/Water_Sport
//Water Spout//
obj/Moves/Water_Spout
//Will//
obj/Moves/Will
//Willowisp//Will-o-Wisp//
obj/Moves/Will_O_Wisp
	name = "Will-O-Wisp"
	Type = "Fire"
	Range = "Status"
	PP = 15
	MPP = 15
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Will_O_Wisp(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Will_O_Wisp
	icon = 'Moves.dmi'
	icon_state = "Will-O-Wisp"
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			if(prob(90)) // 10% chance of not burning the target.
				P.Burn(owner)
			density = 0


		else del src
mob/Pokemon/proc/Will_O_Wisp(var/obj/Moves/M)
	flick("Fire",src)
	frozen = 1
	var/obj/Overworld/Will_O_Wisp/A = new(src.loc)
	A.owner = src
	A.dir = dir
	walk(A,A.dir,1)

	sleep(10)
	frozen = 0
	FindTarget()
//Wish//
obj/Moves/Wish
//Withdraw//-----------------------------------------------------------------------
obj/Moves/Withdraw
	New()
		spawn(20)
			overlays = null
			icon_state = null
			if(Owner)
				icon = Owner.icon
				icon_state = "HUD DC"
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 150
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Withdraw(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()

mob/Pokemon/proc/Withdraw(var/obj/Moves/M)
	if(TempStats["DEF"] >= 6) return
	icon_state = "Withdraw"
	GiveTempStat(src,"DEF",1)
	spawn(50) if(icon_state == "Withdraw") icon_state = null
	GiveTempStat(src,"DEF",-1,650) //Waits 1 minute before returning the stat.


//Whirlwind//
obj/Moves/Whirlwind
	Type = "Normal"
	Range = "Status"
	PP = 20
	MPP = 20
	Wait_Time = 120
	Attack()
		var/mob/Pokemon/P = Owner
		var/mob/Player/O = GetOwner(P.Owner)
		if(!isPlayer(O)) return
		if(!O.Court && !O.MasterGMCheck() && !O.Round)
			O<<System("You must be in battle to use this move.")
			return
		if(..())
			P.Whirlwind(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/Pokemon/DEF)
		Attack()


mob/Pokemon/proc/Whirlwind(var/obj/Moves/M)
	set background = 1
	icon_state = "Gust"
	var/NHP = HP //If they take damage, the attack stops.
	spawn(60) if(icon_state == "Gust") icon_state = null

	while(icon_state == "Gust")
		if(HP <= 0 || !loc) if(icon_state == "Gust")
			icon_state = null
			break
		if(HP < NHP)
			icon_state = null
			break
		for(var/mob/Pokemon/P in view(5, src))
			step_away(P,src)

		for(var/obj/Overworld/OO in range(src,4))
			if(istype(OO,/obj/Overworld/SleepPowder) || istype(OO,/obj/Overworld/PoisonPowder)|| istype(OO,/obj/Overworld/StunSpore))
				OO.owner = src
				step_away(OO,src)

		sleep(3)

	if(HP != NHP) return
	for(var/mob/Pokemon/P in view(src))
		if(P == src) continue
		if(isPokemon(P) && P.Ability == "Suction Cups") return
		if(get_dist(P,src) >= 4)
			P.NoSend = world.realtime + 600 //They can't send out for 1 minute.
			P.ReturntoBall(0)







//Wing Attack//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Moves/Wing_Attack
	Type = "Flying"
	Range = "Physical"
	Power = 50
	PP = 30
	MPP = 30
	Wait_Time = 95
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Wing_Attack(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x-1 == DEF.x || ATK.x+1 == DEF.x || ATK.y+1 == DEF.y || ATK.y-1 == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()

obj/Overworld/
	icon = 'Moves.dmi'
	Wing_Attack
		New()
			spawn(20) del src


mob/Pokemon/proc/Wing_Attack(var/obj/Moves/M)
	var/mob/Player/O = GetOwner(Owner)
	var/obj/Overworld/Wing_Attack/W = new(get_step(src,turn(dir,90)))
	var/obj/Overworld/Wing_Attack/WW = new(get_step(src,turn(dir,-90)))
	W.icon = icon
	W.icon_state = "Wing Attack"
	WW.icon = icon
	WW.icon_state = "Wing Attack2"
	icon_state = "Tackle"
	frozen = 1
	NoRunDelay = 1
	for(var/i=1, i<5, i++)
		W.dir = dir
		WW.dir = dir
		for(var/mob/Pokemon/PKMN in W.loc)
			if(PKMN == src) continue
			PKMN.overlays += image('Moves.dmi',"Aerial Ace")
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		for(var/mob/Pokemon/PKMN in WW.loc)
			if(PKMN == src) continue
			PKMN.overlays += image('Moves.dmi',"Aerial Ace")
			spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
			PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, M))
			PKMN.DeathCheck(src)
		frozen = 0
		if(src && src.icon_state == "Tackle")
			frozen = 0
			if(!O)
				step(src,src.dir)
			if(O) if(get_step(O.ControlingPokemon,src.dir) in view(O.client))
				step(src,src.dir)
			frozen = 1
			missile(W, W.loc, get_step(src,turn(src.dir,90)))
			missile(WW, WW.loc, get_step(src,turn(src.dir,-90)))
			W.loc = get_step(src,turn(src.dir,90))

			WW.loc = get_step(src,turn(src.dir,-90))
			for(var/mob/Pokemon/PKMN in W.loc)
				if(PKMN == src) continue
				PKMN.overlays += image('Moves.dmi',"Aerial Ace")
				spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
				PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, src))
				Target = PKMN
				PKMN.DeathCheck(src)
			for(var/mob/Pokemon/PKMN in WW.loc)
				if(PKMN == src) continue
				PKMN.overlays += image('Moves.dmi',"Aerial Ace")
				spawn(5) if(PKMN) PKMN.overlays -= image('Moves.dmi',"Aerial Ace")
				PKMN.HP = max(0, PKMN.HP - BattleDamage(PKMN, src))
				PKMN.DeathCheck(src)
			sleep(1)
/*		if(!O)
			step(src,dir)
		if(O) if(get_step(O.ControlingPokemon,dir) in view(O.client))
			step(src,dir)
		frozen = 1

		W.loc = get_step(src,turn(dir,90))
		WW.loc = get_step(src,turn(dir,-90))
		sleep(1)*/
	frozen = 0
	del WW
	del W
	if(icon_state == "Tackle") icon_state = null
	NoRunDelay = 0






//Wrap//-------------------------------------------------------------------------------------------------------
obj/Moves/Wrap
	Type = "Normal"
	Range = "Physical"
	Power = 15
	PP = 20
	MPP = 20
	Wait_Time = 110
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Wrap(src)
			if(P) P.UsingAttack = null
			//Just in case
			spawn(200) for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= rand(4,6) && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!


				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)
		Attack()
	New()
		overlays = null
		icon_state = null
		spawn(20)
			if(Owner)
				icon = Owner.icon
				icon_state = "HUDWrap"


obj/Overworld/
	Wrap
		density = 1
		invisibility = 1
		icon_state = "WrapProjectile"
		var/WrapHit = 0
		var/obj/Moves/Wrap = null
		New()
			..()
			spawn(200) del src //Incase something fucks up..
		Bump(m)
			if(istype(m,/obj/Overworld))
				var/obj/O = m
				O.BumpedInto(src)
			if(istype(m,/mob/Pokemon))
				var/mob/Pokemon/M = m
				WrapHit = 1
				M.SecondaryStatus["Wrap"] = 1
				M.overlays += image(owner.icon, "WrapOverlay")
				M.NoReturn = 1

				var/TimesWrapped = pick(2,5)
				var/obj/Moves/Wrap/V = new

				for(var/i = 1, i<= TimesWrapped, i++)
					if(M.HP <= 0) break
					if(!M || !owner) break


					M.HP = max(0,M.HP - owner.BattleDamage(M,V))
					M.DeathCheck(owner)
					sleep(25)

				M.overlays -= image(owner.icon, "WrapOverlay")
				M.SecondaryStatus["Wrap"] = 0
				owner.SecondaryStatus["Wrap"] = 0
				M.NoReturn = 0
				if(Wrap)
					for(var/obj/E in Wrap.Parts)
						del E
				del V
				del src

	WrapExtra
		density = 1
		icon_state = "WrapProjectile"
		New()
			..()
			spawn(200) del src //Incase something fucks up..


mob/Pokemon/proc/Wrap(var/obj/Moves/M)
	var/obj/Overworld/Wrap/V = new(loc)
	V.dir = dir
	V.Wrap = M
	var/SetDir = V.dir
	V.owner = src
	V.icon = icon

	SecondaryStatus["Wrap"] = 1
	for(var/i = 1, i <= WrapDistance, i++)
		if(V && !V.WrapHit)
			var/obj/Overworld/WrapExtra/E = new(V.loc)
			step(V, V.dir)
			E.icon = icon
			E.layer = layer - 1
			E.owner = V.owner
			E.dir = SetDir
			M.Parts += E
			sleep(1)
			//if(V) if(V.loc) sleep(1)
	if(!V.WrapHit)
		for(var/obj/E in M.Parts)
			del E

		SecondaryStatus["Wrap"] = 0

mob/Pokemon/
	var/WrapDistance = 2 //For "Wrap" attack, will declare how many steps the attack can go. Pokemon that use tails are shorter. Pokemon that use vines are longer.
	Ekans
	Arbok
		WrapDistance = 2
	Bellsprout
		WrapDistance = 4
	Weepinbell
		WrapDistance = 5
	Victreebel
		WrapDistance = 6
	Tentacool
		WrapDistance = 3
	Tentacruel
		WrapDistance = 4
	Lickitung
		WrapDistance = 4
	Dratini
		WrapDistance = 2
	Dragonair
		WrapDistance = 3
	Dragonite
		WrapDistance = 1
	Shuckle
		WrapDistance = 2
	Seviper
		WrapDistance = 3
	Milotic
		WrapDistance = 3
	Chimecho
		WrapDistance = 2
	Deoxys
		WrapDistance = 2

//Yawn//
obj/Moves/Yawn
	Type = "Normal"
	Range = "Status"
	PP = 10
	MPP = 10
	Wait_Time = 90
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Yawn(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Yawn
	icon = 'Moves.dmi'
	icon_state = "Yawn"
	layer = 100
	density = 1
	New()
		spawn(30)
			del src
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/mob/Pokemon/P = D
			sleep(100)
			P.Sleep(src)


mob/Pokemon/proc/Yawn(var/obj/Moves/M)
	flick("Fire",src)
	frozen = 1


	var/obj/Overworld/Yawn/A = new(src.loc)
	A.name = "Yawn"
	A.owner = src
	A.dir = dir
	walk(A,A.dir,1)

	sleep(10)
	frozen = 0
	FindTarget()
//Zap Cannon//
obj/Moves/Zap_Cannon
	Type = "Electric"
	Range = "Special"
	PP = 5
	MPP = 5
	Power = 120
	Wait_Time = 100
	Attack()
		var/mob/Pokemon/P = Owner
		if(..())
			P.Zap_Cannon(src)
			if(P) P.UsingAttack = null
			for(var/obj/D in Parts)	del D
	Check(var/mob/Pokemon/ATK, var/mob/DEF)
		set background = 1
		spawn(300)
			ATK = null
			DEF = null
		while(ATK && DEF && ATK.Target)
			var/SPEED = max(1,ATK.GetSpeed())
			if(ATK.StepAway) step_away(src,ATK.StepAway)
			if(!ATK.loc || !DEF.loc) break
			if(get_dist(ATK, DEF) <= 6 && (ATK.x == DEF.x || ATK.y == DEF.y))
				ATK.dir = get_dir(ATK,DEF) //Face your opponent like a Man!
				Attack()
				break
			else
				ATK.Step_To(DEF)
			sleep(SPEED)

obj/Overworld/Zap_Cannon
	icon = 'Moves.dmi'
	icon_state = "Zap Cannon"
	layer = 100
	density = 1
	New()

		spawn(25)
			del src
		..()
	Bump(D)
		if(istype(D,/obj/Overworld))
			var/obj/O = D
			O.BumpedInto(src)
		if(istype(D,/mob/Pokemon))
			var/obj/Moves/Zap_Cannon/A = new

			var/mob/M = D
			M.HP = max(0,M.HP - owner.BattleDamage(M,A))
			M.DeathCheck(owner)
			loc = M.loc
			density = 0 //Its already damaged one Pokemon, so forget doing anymore damage.



		else del src

mob/Pokemon/proc/Zap_Cannon(var/obj/Moves/M)
	flick("Fire",src)
	for(var/i=-90, i<=90, i+=90)
		spawn(0)
			var/obj/Overworld/Zap_Cannon/A = new(src.loc)
			if(!i) A.loc = src.loc
			A.owner = src
			A.dir = dir
			walk(A,A.dir,1)


//Moves - HMS//-------------------------------------------


mob/Pokemon/
	var/
		obj/HMs/HM
		obj/ControlingObject
obj/HMs/proc/
	Use(var/mob/Pokemon/P)
//Dig//
obj/HMs/Dig
obj/HMs/Fly
	Use(var/mob/Pokemon/P)
		var/mob/Player/M = GetOwner(P.Owner)
		if(!P || P.HP <= 0|| P.icon_state == "Sleep") return

		if(M.z != 5) return //They can only fly whilst on the main map layer.

		if(!length(M.FlyPoints)) return //They will be glitched. This is for Admins mostly, as everyone goes in Pokemon Centers.
		//Pick Destination//
		var/Where = input("Where do you want to go?") in M.FlyPoints
		var/turf/T = LocFromNum(M.FlyPoints[Where])

		spawn() P.ReturntoBall(0,1)

		//Create Flying Object//
		M.invisibility = 1
		M.frozen = 1
		var/obj/Overworld/FlyingPokemon/FP = new(M.loc)
		var/obj/Overlay = new
		Overlay.icon = P.icon
		Overlay.icon_state = "Fly"
		Overlay.pixel_y = 16
		Overlay.layer = 40
		FP.overlays += Overlay

		FP.name = "[M.name]'s [P.name]"

		M.AddScreenOverlay(M.Ricon,"",FP,"Fly Overlays",40)
		for(var/i in M.ClothingOverlays)
			if(i == "Hair") M.AddScreenOverlay('Hair.dmi',"[M.ClothingOverlays[i]]",FP,"Fly Overlays",40)
			else M.AddScreenOverlay('Clothing.dmi',"[M.ClothingOverlays[i]]",FP,"Fly Overlays",40)




		//Start Flying//
		FP.FlyTo(M, T)
		M.frozen = 0
		del Overlay


obj/Overworld/FlyingPokemon
	layer = 100
	New()
		spawn(1200) del src

	proc/FlyTo(var/mob/Player/P, var/turf/T)
		if(!P || !T) return
		if(P.client)
			P.client.eye = src
			P.client.perspective = EYE_PERSPECTIVE

		while(T.x != x || T.y != y)
			step_towards(src,T)
			sleep(1)
		if(P)
			if(P.client) P.client.eye = P
			P.dir = dir
			P.loc = locate(T.x,T.y,5)
			P.invisibility = 0
			P.RemovebyID("Fly Overlays")
		del src
mob/Player/var
	list/FlyPoints = list()

obj/FlyingPoint
	SteppedOn(D)
		if(isPlayer(D))
			var/mob/Player/P = D
			P.FlyPoints[name] = CoordsToNum(x,y,5)
		return ..()



//Surf//
obj/HMs/Surf
	Use(var/mob/Pokemon/P)




//Teleport//-----------------------------------------------------------------------------------------
obj/HMs/Teleport
	Use(var/mob/Pokemon/P)
		var/mob/Player/M = GetOwner(P.Owner)
		if(!P || P.HP <= 0|| P.icon_state == "Sleep") return
		if(alert(M,"Teleport to last Pokemon Center?",,"Yes","No") == "No") return
		if(!M) return
		view(M,6)<<'Teleport.wav'
		flick("TeleportOut",P)
		sleep(12)
		if(!M) return
		M.loc = LocFromNum(M.DieLoc)
		P.loc = locate(M.x + 1 ,M.y,M.z)
		flick("TeleportIn",P)
		view(M,6)<<'Teleport.wav'
		P.ReturntoBall(12)


obj/HMs/Waterfall
obj/HMs/Whirlpool


//Status - Burn//-----------------------------------------------------------------------------------------------------------
mob/Pokemon/proc
	Burn(var/mob/Pokemon/P)
		set background = 1
		if(P.Type1 == "Fire" || P.Type2 == "Fire") return //Fire types cannot be burned.
		if(Status) return //They can't be asleep or poisoned or whatever..
		AddSection("Status","Burn")
		Status = "Burn"
		StatusKiller = P
		if(icon_state == "Sleep")
			overlays -= image('Moves.dmi',"Sleep")
			icon_state = null
//Status - Confusion//------------------------------------------------------------------------------------------------------
mob/Pokemon/proc
	Confuse(var/mob/Pokemon/P)
		if(!isPokemon(P)) return
		if(SecondaryStatus["Confused"]) return
		SecondaryStatus["Confused"] = rand(2,6)
		SecondaryStatus["ConfusedTarget"] = P
		overlays += image('Moves.dmi',"Confused")
		spawn(15) P.overlays -= image('Moves.dmi',"Confused")
//Status - Paralysis//------------------------------------------------------------------------------------------------------
mob/Pokemon/proc
	Paralysis(var/mob/Pokemon/P)
		spawn()
			if(Status) return
			for(var/i = 1, i <= 10, i++)
				if(i == 1 || i == 3 || i == 5|| i == 7|| i == 9) pixel_x += 3
				else pixel_x -= 3
				sleep(1)
			Status = "Paralysis"
			flick(src, "Pushback")
			overlays += image('Moves.dmi', "Paralysed")
			spawn(10) overlays -= image('Moves.dmi', "Paralysed")
			var/R = pick(1,2,2,3,3,4) * 99
			sleep(R)
			if(Status == "Paralysis")
				Status = null



//Status - Poison//----------------------------------------
mob/Pokemon/proc
	Poison(var/mob/Pokemon/P)
		set background = 1
		spawn(1)
			if(Status || Type1 == "Poison" || Type2 == "Poison" || Type1 == "Steel" || Type2 == "Steel" ) return //They can't be asleep or poisoned or whatever..
			AddSection("Status","Poisoned")
			Status = "Poison"
			while(Status == "Poison")

				var/Damage = MHP / 8
				HP = max(0, HP - Damage)
				if(!HP) Status = null
				DamageOverlay(Damage, "Purple ")
				DeathCheck(StatusKiller)
				sleep(99)
			if(icon_state == "Sleep")
				overlays -= image('Moves.dmi',"Sleep")
				icon_state = null
//Status - Frozen//-------------------------------------------------------------
mob/Pokemon/proc/
	Frozen(var/mob/Pokemon/P)
		/*set background = 1
		if(Status) return //They can't be asleep or poisoned or whatever..
		overlays += image('Hydro Pump.dmi',"Freeze",-16,-16)
		Status = "Sleep"
		var/Freeze = 30 * pick(2,3,4,5)
		while(Status == "Frozen")
			if(loc)
				Freeze -= 10
			else
				Freeze = min( Freeze + 5,  120 )
			if(Freeze <= 0) if(Status == "Frozen")
				Status = null
				break
			sleep(10)
			overlays -= image('Hydro Pump.dmi',"Freeze")
			icon_state = null*/
//Status - Sleep//----------------------------------------
mob/Pokemon/var/tmp
	LastSlept
mob/Pokemon/proc
	Sleep(var/mob/Pokemon/P, var/SetTime)
		set background = 1
		if(Status) return //They can't be asleep or poisoned or whatever..
		icon_state = "Sleep"
		LastSlept = world.timeofday
		overlays += image('Moves.dmi',"Sleep")
		Status = "Sleep"
		var/Sleeping = 30 * pick(2,3,4,5)
		while(Status == "Sleep")
			if(loc)
				Sleeping -= 10
			else
				Sleeping = min( Sleeping + 5,  120 )
			if(Sleeping <= 0) if(Status == "Sleep")
				Status = null
				break
			sleep(10)
		if(icon_state == "Sleep")
			overlays -= image('Moves.dmi',"Sleep")
			icon_state = null

