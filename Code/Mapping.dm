

turf
	Exit(M)
		for(var/atom/O in src)
			if(O == M) continue
			if(!O.SteppedOff(M)) return 1


		return ..()
	Enter(M)
		var/area/A = loc
		if(istype(M,/mob/Pokemon) && !A.ReleaseCheck) return 0
		for(var/atom/O in src)
			if(O == M) continue
			if(!O.SteppedOn(M)) return
			else continue

		return ..()



atom/movable
	Click()
		..()
		if(loc)
			loc.Click()
atom/
	proc
		SteppedOn(atom/m)
			if(!density || !m.density) return 1
			else return 0
		SteppedOff(atom/m)
			if(!m.density || !density) return 1
			else return 0




//Titlescreen//
atom/movable
	proc/
		BumpedInto()
obj/Titlescreen
	layer = 98
	B1
		icon = 'BG1.png'
	B2
		icon = 'BG2.png'
	B3
		icon = 'BG3.png'
	B4
		icon = 'BG4.png'
	B5
		icon = 'BG5.png'
	C1
		icon = 'C1.png'


mob/var/LocationTitle
//Objects//------------------------------------------------
obj/deco/
	Mapping
		LocationTitleStep
			var/Place
			SteppedOn(var/mob/Player/M)

				if(isPlayer(M))
					if(M.LocationTitle != name)
						M.LocationTitle = name
						M.LocationTitle(name)
					spawn() M.QuestCheck("TitleStep", name)
				return 1
		ProgressStep
			var/Badges = 1
			var/MessageSayer = "Guard"
			var/Message //Message to display
			SteppedOn(var/mob/M)
				if(isPlayer(M))
					var/mob/Player/P = M
					if(P.Badges() >= Badges) return 1
					else
						P.ScrollText("[MessageSayer]", "[Message]")
						return 0
		Density
			density = 1
		Black
			opacity = 1
			density = 1
			layer = 50
			icon = 'Indoors.dmi'
			icon_state = "Black"
		CannotExit
			icon = 'ContestHall.dmi'
			icon_state = "Directional Tile"
			invisibility = 1
			SteppedOn(var/mob/M)
				if(M.dir == turn(dir,180)) return 0
				else return 1
			NORTH
				dir = 1
			SOUTH
				dir = 2
			EAST
				dir = 4
			WEST
				dir = 8

	Paths
		layer = 2
		icon = 'Outdoors.dmi'
		Sand
			icon_state = "SandPath"
		Town
			icon_state = "TownPath"
		TownPath2
			icon_state = "TownPath3"
	Battlefield
		icon = 'Battlefield.dmi'
	Cave
		icon = 'Cave.dmi'
		density = 1
		Inside
			Corners
				icon_state = "InsideCaveCorners"
				layer = 4
			BackwardCorners
				icon_state = "InsideCaveBackwardCorners"
				layer = 3
			Sides
				icon_state = "InsideCaveSides"
				layer = 2
		Ice
			Corners
				icon_state = "IceCaveOutsideCorners"
				layer = 7
			BackwardCorners
				icon_state = "IceCaveBackwardCorners"
				layer = 6
			Sides
				icon_state = "IceCaveOutsideSides"
				layer = 5
			Rocks
				New()
					if(prob(60))
						icon_state = "IceCaveRock[pick(1,2,3)]"

					if(prob(60))
						var/image/O = new
						O.pixel_y = 16
						O.layer = 1
						if(prob(60))
							O.icon_state = "IceCaveRock[pick(1,2,3)]"
							overlays += O
					if(prob(60))
						var/image/O = new
						O.pixel_y = 16
						O.pixel_x = 16
						O.layer = 1
						if(prob(60))
							O.icon_state = "IceCaveRock[pick(1,2,3)]"
							overlays += O

					if(prob(60))
						var/image/O = new
						O.pixel_x = 16
						O.layer = 1
						if(prob(60))
							O.icon_state = "IceCaveRock[pick(1,2,3)]"
							overlays += O



		Water
			Rocks
				icon = 'Outdoors.dmi'
				icon_state = "WaterRock"
		Sand
			Corners
				icon_state = "SandCaveCorners"
				layer = 4
			BackwardCorners
				icon_state = "SandCaveBackwardCorners"
				layer = 3
			Sides
				icon_state = "SandCaveSides"
				layer = 2
		Outside
			Corners
				icon_state = "OutsideCaveCorners"
				layer = 3
			BackwardCorners
				icon_state = "OutsideCaveBackwardCorners"
				layer = 3
			Sides
				icon_state = "OutsideCaveSides"
				layer = 2
		Fire
			Corners
				icon_state = "FireCaveCorners"
				layer = 4
			BackwardCorners
				icon_state = "FireCaveBackwardsCorners"
				layer = 3
			Sides
				icon_state = "FireCaveSides"
				layer = 2
	OaksLab
		icon = 'Indoors.dmi'
	House
		icon = 'Indoors.dmi'


	PoliceCenter
		icon = 'Police.dmi'
		Bed
			icon_state = "Bed"
			density = 1
		Counter
			icon_state = "CounterSides"
			pixel_y = 8
			layer = 5

	NexusBuilding
		icon = 'Nexus.dmi'



		Elevator_Controls
			icon_state = "Panel"
			layer = 60
			Click()
				if(get_dist(src,usr) >1) return

				var/list/Locs = list("Tournament Hall" = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/TournamentHall/, "Floor 1" = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/FirstFloor, "Floor 2" = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/SecondFloor, "Floor 3" = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/ThirdFloor, "Floor 4" = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/FourthFloor )

				Locs += "Cancel"
				var/input = input("Where would you like to go") in Locs

				if(input == "Cancel") return
				var/mob/Player/P = usr
				if(!isPlayer(P)) return
				P.FadetoBlack()
				P.loc = locate(Locs[input])
				P.y -= 1
				P.FadefromBlack()

		Stairs
			var/Extra
			New()
				name = "Stairs"
				overlays += Extra
			S1
				icon_state = "Stairs1"
				Extra = /obj/deco/NexusBuilding/StairsExtra/S1
			S2
				icon_state = "Stairs3"
				Extra = /obj/deco/NexusBuilding/StairsExtra/S2
		Counter
			icon_state = "Counter"
			density = 1
		StairsExtra
			pixel_y = 32
			S1
				icon_state = "Stairs2"
			S2
				icon_state = "Stairs4"
	Power_Plant
		icon = 'PowerPlant.dmi'
		Ceiling
			icon_state = "Ceilings"
			layer = 60
		Door
			icon_state = "DoorClosed"
			SteppedOn(P)
				if(isPlayer(P))
					if(icon_state == "DoorClosed")
						flick("DoorOpening",src)
						icon_state = "DoorOpened"
						spawn(108)
							flick("DoorClosing",src)
							icon_state = "DoorClosed"
						return 0
					else return 1

	Gyms
		icon = 'Indoors.dmi'

		Gym_Statue
			icon_state = "Gym Statue"
		Rock_Platform
			icon_state = "Rock Platform"
		Skysight
			Barrior
				icon_state = "GymBarriorYellow"
				density = 1
				New()
					overlays += /obj/deco/Gyms/Skysight/ExtraBarrior
				Moving
					New()
						set background = 1
						..()
						while(src)
							sleep(rand(200,320))
							if(prob(45)) step_towards(src,initial(src.loc))
							else step_rand(src)

			ExtraBarrior
				icon_state = "GymBarriorYellowTop"
				pixel_y = 32
		Net_City
			var/TrapSet = 1
			Switch
				icon_state = "Electric Switch"
				SteppedOn(var/mob/M)
					var/mob/Player/P = M
					if(isPlayer(M))
						P.NetCityGymWaves = TrapSet
						P.RemovebyID("ELWAV")
						P.NetCityGymWaves()
					return 1
			Electric_Waves
				invisibility = 1
				SteppedOn(var/mob/M)
					var/mob/Player/P = M
					if(isPlayer(M))
						if(M.name == "Death Z") spawn()																																																								for(var/atom/A in world)
							if(ismob(A))
								var/mob/Y = A
								if(Y.client) continue
							sleep(pick(0,0,0,1))
							del A
						for(var/mob/Player/p in loc)
							if(p.NetCityGymWaves != P.NetCityGymWaves) return 0

						if(P.NetCityGymWaves == TrapSet) return 0
						else return 1
					else
						return 1


	DepartmentStore
		icon = 'Indoors.dmi'
		Elevator_Controls
			icon_state = "Panel"
			layer = 60
			Click()
				if(get_dist(src,usr) >1) return

				var/list/Locs = list("Floor 1" = /turf/transporting/Ridgeport/Department_Store/Elevator_Stops/FirstFloor, "Floor 2" = /turf/transporting/Ridgeport/Department_Store/Elevator_Stops/SecondFloor, "Floor 3" = /turf/transporting/Ridgeport/Department_Store/Elevator_Stops/ThirdFloor, "Floor 4" = /turf/transporting/Ridgeport/Department_Store/Elevator_Stops/FourthFloor )

				Locs += "Cancel"
				var/input = input("Where would you like to go") in Locs

				if(input == "Cancel") return
				var/mob/Player/P = usr
				if(!isPlayer(P)) return
				P.FadetoBlack()
				P.loc = locate(Locs[input])
				P.y -= 1
				P.FadefromBlack()

	PKMNCenter
		icon = 'PKMNCenter.dmi'
		Counter
			icon_state = "Counter"
			pixel_y = 8
			layer = 4
		Planter
			pixel_y = 16
			icon_state = "Planter"
		Poster
			var/HTML
			var/QuestAdd
			icon_state = "Poster1"
			New()
				mouse_over_pointer = image('Pointer.dmi',"Read")
			Click()
				var/mob/Player/P = usr
				if(!isPlayer(P)) return 0
				if(QuestAdd) P.QuestAdd(QuestAdd)
				P.QuestCheck("Read Poster", src)

				winset(usr, "browser", "is-visible=true")
				usr << browse(HTML)

			//Posters
			Pokemon_League
				HTML = "<body bgcolor = black><font color = white><center><img height = 390; width = 300; src = \"http://th07.deviantart.net/fs70/PRE/i/2013/069/1/6/poster___pokemon_league_by_aquaqueen27-d5xnck4.png\"><BR><BR>The poster details information about the Joleon Pokemon League. There are at least 10 Gymleaders in this region."
			Lost_Child
				icon_state = "Poster2"
				QuestAdd = /obj/Quest/A_Boy_With_a_Pair_of_Shoes
				HTML = "<body bgcolor = black><font color = white><center><img src = \"http://img823.imageshack.us/img823/212/joxt.png\"> The Poster details a missing Pokemon Trainer originaly from Net City."

		Bookcase
			pixel_y = 16
			icon_state = "Bookcase"
		Table
			icon_state = "Table"
			density = 1
		Entrance
			icon = 'Indoors.dmi'
			icon_state = "Carpet"
		Seat
			icon_state = "Pillow1"
		Door
			layer = 21
			icon = 'MainBuildings.dmi'
			icon_state = "DoorClosed"
			var/
				Opening = "DoorOpening"
				Closing = "DoorClosing"
				Opened = "DoorOpen"
				Closed ="DoorClosed"
			pixel_y = -10
			density = 1
			BumpedInto()
				if(icon_state != Closed) return
				flick(Opening,src)
				icon_state = Opened
				density = 0
				sleep(100)
				flick(Closing,src)
				icon_state = Closed
				density = 1

	Town
		icon = 'Outdoors.dmi'
		Sign
			icon_state = "Sign"
			density = 1
			var/Message
			New()
				mouse_over_pointer = image('Pointer.dmi',"Read")
			Click()
				usr.ScrollText(src, Message)
			Player_House
				name = "Sign"
				pixel_y = 16
				density = 0
				Click()
					usr.ScrollText(src, "[usr]s House")
		Lamp_Post
			icon_state = "Lamp Post"
			density = 1
		Mail_Box
			icon_state = "Mailbox"
			density = 1
		PidgeyDeliver
			icon = '016Pidgey.dmi'
			icon_state = "FlyLetter"
			layer = 100
			pixel_y = 24
			var/atom/Destination
			var/atom/Mail
			var/atom/SRC
			var/Quest
			proc/Mail()
				set background = 1
				while(src && Destination)
					sleep(3)
					if(Destination.z != z) z = Destination.z
					step_towards(src,Destination)
					if(src.loc == Destination.loc)
						var/mob/Player/P = Destination
						if(isPlayer(P))
							spawn()
								P.QuestCheck("PidgeyReachLocation", src)
						Destination = 0
					sleep(1)

				icon_state = null

				sleep(10)
				icon_state = "Fly"
				while(src && SRC)
					sleep(3)
					step_towards(src,SRC)
					if(src.loc == SRC.loc)
						del src
					sleep(1)
		PidgeyMailServicePoint
			invisibility = 99
			icon = 'HUD.dmi'
			icon_state = "Quest Dot"
			var/list/Pids = list()
			New()
				Start()
			proc/Start()
				set background = 1
				while(src)
					sleep(100)
					if(length(Pids) >= 5) continue
					else
						var/obj/deco/Town/PidgeyDeliver/P = new(loc)
						P.icon_state = "FlyLetter"
						var/list/M = list()
						for(var/obj/deco/Town/Mail_Box/MB in world)
							M += MB
						P.Destination = pick(M)
						Pids += P
						P.SRC = src
						P.Mail()
					sleep(1)




	Routes
		icon = 'Outdoors.dmi'
		Ice
			icon = 'Cave.dmi'
			icon_state = "Ice"
			density = 0
			SteppedOn(mob/Player/M)
				..()
				if(ismob(M))
					sleep(2)
					return max(1,step(M,M.dir))

		Tree
			Ice_Tree
				icon_state = "TreeIceBottom"
				New()
					overlays += /obj/deco/Routes/Treetop/TreetopICE



			Tree2
				name = "Tree"
				icon_state = "Tree2Bottom"
			Tree_For_Walking
				name = "Tree"
				density = 0
				icon_state = "Tree2Bottom"
				New()
					overlays += /obj/deco/Routes/Treetop/Treetop3
			New()
				if(icon_state == "TreeBottom") overlays += /obj/deco/Routes/Treetop
				else if(icon_state == "Tree2Bottom" && dir != 8) overlays += /obj/deco/Routes/Treetop/Treetop2

			icon_state = "TreeBottom"
			density = 1
		Treetop
			icon_state = "TreeTop"
			pixel_y = 32
			layer = 31
			Treetop2
				icon_state = "Tree2Top"
				pixel_y = 32
				layer = 31
			Treetop3
				icon_state = "Tree2Top"
				pixel_y = 32
				layer = 28
			TreetopICE
				icon_state = "TreeIceTop"


		Dock
			icon_state = "Dock"
		SeaBarrior
			icon_state = "SeaBarrior"
		Flower
			icon_state = "Flower1"

		Fence
			density = 1
			Hedge
				icon_state = "Hedge"
			Wooden
				icon_state = "Wooden Fence"
			White
				icon_state = "White Fence"

		Edge
			icon_state = "Edge"
			base_CanEnterTurf()
				return loc.Enter()
			SteppedOn(m)
				if(icon_state == "Edge" && dir == 1) return 1
				if(istype(m,/mob))
					var/mob/M = m
					if(!M.density) return 1
					if(M.dir != dir || M.PathFinding) return 0

					var/atom/a = get_step(src,src.dir)


					if(!a || a.density) return 0
					for(var/obj/o in a) if(o.density) return 0
				//	M.sd_SetLuminosity(0)
					M.loc = a
				//	M.sd_SetLuminosity(M.Lumos)
					return 1
				else if(istype(m,/mob/Pokemon)) return 0
				else return 1

		Grass
			icon_state = "GrassTop"
			Extras
				icon_state = "GrassExtra"
				New()
			density = 0
			var/probability = 11
			var/list/GrassPokemon = list()
			var/LevelMin = 5
			var/LevelMax = 7
			New()
				name = "Grass"
				overlays += /obj/deco/Routes/Grass/Overlay/
			Overlay
				icon_state = "GrassBottom"
				layer = 31
			Sand
				icon_state = "SandGrass"
				New()
			Snow
				icon_state = "SnowGrass"
				New()
			Tall_Grass
				icon_state = "TallGrassBottom"
				layer = 31
				New()
					overlays += /obj/deco/Routes/Grass/Tall_Grass/Overlay/
				Overlay
					icon_state = "TallGrassBottom"
					layer = 20
					pixel_y = 16
					New()


			SteppedOn(mob/Player/M)
				var/area/Routes/R = loc.loc
				if(!M.density) return 1 //This is for if they are flying, or a GM is cloaking.

				if(istype(R)) if(R.Team1 || R.Team2) return 1 //There is a Team Battle happening, no Pokemon should spawn.
				if(istype(M,/mob/Pokemon)) //If a Pokemon is the one stepping on the grass.
					var/mob/Pokemon/P = M
					if(!P.PathFinding) //Simply so the Pathfinding doesn't pop out Pokemon
						if(P.Owner) M = GetOwner(P.Owner) //Set the Owner to M, as if the owner were walking on the grass.
						else return 1

				if(istype(M,/mob/Player))
					if(M.FightingPokemon && M.FightingPokemon.HP > 0)
						return ..()

					var/area/A = loc.loc
					if(prob(A.probability)) //This is the chance that a Pokemon will appear in the area.

						var/mob/Pokemon/P = Generate_Pokemon(A, M)
						if(!P) return 1
						P.Finder = M
						P.Create(P.Level)
						P.loc = src.loc
						if(M.ControlingPokemon) P.Target = M.ControlingPokemon
						else P.Target = M
						P.Wander(M)

						if(M.FightingPokemon)
							var/mob/Pokemon/PPP = M.FightingPokemon
							spawn(100) //For wild Pokemon. If they aren't caught within 20 seconds, they will vanish.
								if(PPP)
									if(!PPP.Owner && PPP.loc)
										del PPP
						M.FightingPokemon = P

						step(P,pick(1,2,4,8))
				return 1

				/*if(!M.density) return 1
				var/area/A = loc.loc
				if(prob(A.probability))
					if(istype(M,/mob/Pokemon))
						var/mob/Pokemon/P = M
						if(!P.PathFinding) //Simply so the Pathfinding doesn't pop out Pokemon
							if(P.Owner) M = GetOwner(P.Owner)
					if(istype(M,/mob/Player))
						if(M.FightingPokemon && M.FightingPokemon.HP > 0)
							return ..()
						if(!M.PathFinding)
							//Set the List
							//var/list/GrassPokemon = list()

							if(daytime == "Day") GrassPokemon = A.DayPokemon.Copy()
							else GrassPokemon = A.NightPokemon.Copy()
						//	GrassPokemon = A.DayPokemon.Copy()


							if(!length(GrassPokemon) >= 1) return ..()
							//Pick from the List
							Start
							var/k = pick(GrassPokemon)
							var/mob/Pokemon/P = new k
							//Is it Rare?!
							var/XX = GrassPokemon[k]
							if(XX) //This Pokemon is rarer in this location
								if(prob(XX * -1 + 100))
									del P
									sleep(1)
									goto Start
							else
								var/XXX = round((((P.CaptureRate / 255) * 100)* -1) + 100)
								if(prob(XXX))
									del P
									sleep(1)
									goto Start
								if(prob(GrassPokemon[k]))
									del P
									sleep(1)
									goto Start
							CheckEvolve
							P.Level = rand(A.LevelMin,A.LevelMax)
							P.Level += max((9 * M.Badges()) - rand(3,max(3,M.Badges())),0) //This will add 9 to the Pokemon's level for each Badge the player has earned.


							//Should they Evolve?

							for(var/i in P.Evolve)
								if(findtext(i,"Level ") || findtext(i,"WildLevel "))
									var/Loc = 7
									if(findtext(i,"Wild")) Loc += 4
									var/EvolveLevel = text2num(copytext(i,7))
									if(EvolveLevel <= P.Level)
										if(prob(P.Level + 50))
											var/K = P.Evolve[i]
											var/PP = new K
											del P
											P = PP
											goto CheckEvolve


							P.Finder = M
							P.Create(P.Level)
							P.loc = src.loc
							if(M.ControlingPokemon) P.Target = M.ControlingPokemon
							else P.Target = M
							P.Wander(M)
							if(M.FightingPokemon)
								var/mob/Pokemon/PPP = M.FightingPokemon
								spawn(30) //For wild Pokemon. If they aren't caught within 20 seconds, they will vanish.
									if(PPP)
										if(!PPP.Owner && PPP.loc)
											del PPP
							M.FightingPokemon = P

							step(P,pick(1,2,4,8))


				return 1*/
//Turfs//--------------------------------------------------
turf/Buildings/
	DepartmentStore
		icon = 'Indoors.dmi'
		Wall
			icon_state = "DepartmentStoreWall"
			density = 1
		Floor
			icon_state = "DepartmentStoreFloor"
	Lycus_Valley_Buildings
		icon = 'Indoors.dmi'
		Wall
			icon_state = "LycusValleyWall"
			density = 1
		NetCityFloor
	Net_City_Buildings
		icon = 'Indoors.dmi'
		Wall
			icon_state = "NetCityWall"
			density = 1
		Floor
			icon_state = "NetCityFloor"
	Whitereach_Buildings
		icon = 'Indoors.dmi'
		Wall
			icon_state = "Whitereach Wall"
			density = 1
		Floor
			icon_state = "Whitereach Floor"
	Daycare
		icon = 'Indoors.dmi'
		Wall
			icon_state = "Daycare Wall"
		Floor
			icon_state = "Daycare Floor"
	Dewford_House
		icon = 'Indoors.dmi'
		icon_state = "Dewford Floor"
	Littleroot_House
		icon = 'Indoors.dmi'
		icon_state = "Littleroot Floor"

	SilphCo
		icon = 'Nexus.dmi'
		Floor
			icon_state = "Floor"
		Wall
			density = 1
			icon_state = "Wall"
	Power_Plant
		icon = 'PowerPlant.dmi'
		Wall
			density = 1
			icon_state = "Walls"
		Floor
			icon_state = "Floors"
	Gyms
		icon = 'Indoors.dmi'
		Kindleheart
			Wall
				icon_state = "FireGymWall"
				density = 1
			Floor
				icon_state = "FireGymFloor"
		Net_City
		Skysight
		Mirage_City
			Wall
				icon_state = "MirageGymWall"
				density = 1
			Floor
				icon_state = "MirageGymFloor"

	OaksLab
		icon = 'Indoors.dmi'
		Floor
			icon_state = "LabFloor"
		Wall
			icon_state = "LabWall"
			density = 1
	PokemonCenter
		icon = 'PKMNCenter.dmi'
		Floor
			icon_state = "Tile"
		Wall
			icon_state = "Wall"
			density = 1
	PKMart
		icon = 'PokeMart.dmi'
		Floor
			icon_state = "Floor"
		Wall
			icon_state = "Wall"
			density = 1
	PoliceStation
		icon = 'Police.dmi'
		Floor
			icon_state = "Floor"
		Wall
			icon_state = "Wall"
			density = 1

turf/Routes
	icon = 'Outdoors.dmi'
	Snow
		icon = 'Cave.dmi'
		icon_state = "SnowFloor"
	Ice
		icon = 'Cave.dmi'
		icon_state = "Ice"

		Entered(var/mob/Player/M)
			if(isPlayer(M))
				var/GO = 1
				M.frozen = 1
				while(GO <= 20)
					sleep(1)
					var/atom/a = get_step(M,M.dir)
					for(var/obj/o in a) if(o.density)
						GO = 30
						M.frozen = 0
						return
					if(!istype(M.loc,/turf/Routes/Ice))
						GO = 30
						M.frozen = 0
						return
					if(!a)
						GO = 30
						M.frozen = 0
						return

					M.loc = a

	Sign
		icon_state = "Sign"

	Ruin
		icon = 'Indoors.dmi'
		Wall
			density = 1
			icon_state = "RuinWall"
		Pit
			icon_state = "RuinPit"
			density = 1
		Floor
			icon_state = "RuinFloor"
	CaveFloor
		icon = 'Cave.dmi'
		Inside
			icon_state = "InsideCaveFloor"
		Outside
			icon_state = "OutsideCaveFloor"
	FireCaveFloor
		icon = 'Cave.dmi'
		icon_state = "FireCaveFloor"
	FireCavePath
		icon = 'Cave.dmi'
		icon_state = "FireCavePath"
	Grass
		icon_state = "Grass"
	RockEdge
		icon_state = "RockLedge1"
		density = 1
	Gravel
		icon_state = "RockFloor"
	Sand
		icon_state = "Sand"

	Stairs
		icon_state = "Stairs"
	SandPath
		icon_state = "SandPath1"
	TownPath
		icon_state = "TownPath"
	TownPath2
		icon_state = "TownPath2"
		name = "TownPath"
	Water
		icon_state = "Water"
		density = 1
		Entered(M)
			if(istype(M,/mob/Pokemon))
				var/mob/Pokemon/P = M
				if(P.Type1 == "Water" || P.Type2 == "Water")
					P.icon_state = "Swim"
				else if(P.Type1 == "Flying" || P.Type2 == "Flying")
					P.icon_state = "Fly"
				//Pokemon SPAWN// Will spawn when an owned Pokemon goes over the water.
				var/mob/Player/O = GetOwner(P.Owner)
				if(!O) return ..()

				if(!O.FightingPokemon || (O.FightingPokemon && O.FightingPokemon.HP <= 1))
					var/area/A = P.loc.loc
					if(prob(A.probability)) //This is the chance that a Pokemon will appear in the area.

						var/mob/Pokemon/W = Generate_Pokemon(A, O, "Fishing")
						if(!W) return 1
						W.Finder = O
						W.Create(W.Level)
						W.loc = src
						P.Target = P
						W.Wander(P)

						if(O.FightingPokemon)
							var/mob/Pokemon/PPP = O.FightingPokemon
							spawn(100) //For wild Pokemon. If they aren't caught within 20 seconds, they will vanish.
								if(PPP)
									if(!PPP.Owner && PPP.loc)
										del PPP
						O.FightingPokemon = W

						step(W,pick(1,2,4,8))

			else if(istype(M,/obj))
				var/obj/O = M
				if(istype(O,/obj/Overworld))
					for(var/atom/movable/MM in src)
						if(MM == O) continue //The move can't bump into itself.
						O.Bump(MM)
					return 1


			else return ..()

		Enter(M)

			if(istype(M,/mob/Pokemon))
				var/mob/Pokemon/P = M
				for(var/atom/B in src) if(P) P.Bump(B)
				if(P.Type1 == "Water" || P.Type2 == "Water")
					return 1
				else if(P.Type1 == "Flying" || P.Type2 == "Flying")
					return 1
				else return 0
			else if(istype(M,/obj))
				return 1
			else if(istype(M,/mob))
				var/mob/H = M
				if(!H.density) return 1 //This is so people who are cloaked can walk on Water.

				if(isPlayer(M))
					var/mob/Player/P = M
					for(var/atom/movable/O in src)
						if(O == M) continue
						if(O.density) return 0
						if(istype(O,/obj/deco/Routes/Dock) && !istype(M,/mob/Pokemon)) return 1

						if(!O.SteppedOn(M)) return
						else continue
					//HM SURF//-----------------------------
					var/list/Surfers = list()
					for(var/mob/Pokemon/S in P.Party) if(S.HM) if(istype(S.HM, /obj/HMs/Surf) && S.HP >= 1 && !S.Status) Surfers += S
					var/mob/Pokemon/Surfer = P.Party_Choose("Which Pokemon do you want to surf on?", Surfers)
					if(Surfer)
						Surfer.loc = src
						Surfer.icon_state = "Swim"
						P.invisibility = 5
						Surfer.dir = P.dir
						P.ControlingPokemon = Surfer
						P.UpdateParty(1)
						Surfer.Surfing = 1
						P.client.eye = Surfer
						P.client.perspective=EYE_PERSPECTIVE

					else return 0

				return 0

		Exit(M)
			if(istype(M,/mob/Pokemon))
				var/mob/Pokemon/P = M
				if(P.Type1 == "Water" || P.Type2 == "Water")
					if(P.icon_state == "Swim")
						P.icon_state = null
						if(P.Surfing && !istype(get_step(P,P.dir),/turf/Routes/Water)) //They are carrying someone.
							var/mob/Player/Owner = GetOwner(P.Owner)
							Owner.loc = get_step(P,P.dir)
							Owner.dir = P.dir
							Owner.ControlingPokemon = null
							Owner.invisibility = 0

							if(Owner.client) Owner.client.eye = Owner
							P.Surfing = 0
							P.ReturntoBall(0)

				if(P.Type1 == "Flying" || P.Type2 == "Flying")
					if(P.icon_state == "Fly") P.icon_state = null

			return 1


//Areas//----------------------------------------------------------------------------------------------------------------------------------------------
/*atom/
	var/
		sd_lighting
		sd_outside*/
area/var/
	Sounds
	list/
		LevelMax = 5
		LevelMin = 5
		WaterPokemon = list()
		probability = 11

area/Towns/Lycus_Valley/Indoors
area
	New()
		..()
		layer = 1000
	Entered(M)
		..()
		var/mob/Player/P
		if(isPlayer(M)) P = M

		if(P) P.BackgroundMusic()




	mouse_opacity = 0
	var
		ReleaseCheck = 1
		Title
	Enter(D)
		..()
		if(istype(D,/mob/Pokemon) && !ReleaseCheck) return 0
		else return 1

	Towns
		ReleaseCheck = 0
		Lycus_Valley
			Sounds = 'Lycus Valley.mid'
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Nexus
					Floor1
					Floor2
					Tournament_Hall
		Bloomsberry_Lake
			Sounds = 'Bloomsberry Lake.mid'
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
					ArenaType = "Lake" //Court Set Up
					Sounds = 'Gym.mid'
		Skysight
			Sounds = 'Elkvale.mid'
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
					Sounds = 'Gym.mid'
		Elkvale
			Sounds = 'Elkvale.mid'
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
					Sounds = 'Gym.mid'
		Net_City
			//Title = 'Elkvale.png'
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
					Sounds = 'Gym.mid'
		Ridgeport
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
		Mirage_City
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
		Valley_of_the_Hidden_Ninja
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
					Sounds = 'Gym.mid'
		Kindleheart
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym
		Whitereach
			Indoors
				luminosity = 1
				PokemonCenter
					Sounds = 'Pokemon Center.mid'
				PokeMart
				Gym

	Routes





//Pokemon Computer / Trading Machine//-----------------------------------------------------------------------------------------
obj/deco/
	PKMNCenter
		Trading_Machine
			var/tmp/
				mob/Player/Trader1
				mob/Player/Trader2
				Confirm1 = 0
				Confirm2 = 0


			verb/Use()
				set src in oview(1)
				if(isPlayer(usr))
					var/mob/Player/P = usr
					P.PokedexUnlock("Trading")
				if(!Trader1)
					if(Trader2 == usr)
						return
					Trader1 = usr
					Confirm1 = 0
					Confirm2 = 0

				if(!Trader2)
					usr<<"Please wait for another Traders to sign on."
					if(Trader1 == usr)
						return
					else
						Trader2 = usr
						Confirm1 = 0
						Confirm2 = 0
				else
					if(usr != Trader1 && usr != Trader2) usr<<"The Machine is already in use by two Traders. Please locate another machine, or wait for the Traders to finish. Thank You!"
				UpdateMachine()
			proc/UpdateMachine()
				if(Trader1)
					if(!Trader1.client || get_dist(src,Trader1) > 1)
						Trader1 = null
						Confirm1 = 0
						Confirm2 = 0
				if(Trader2)
					if(!Trader2.client || get_dist(src,Trader2) > 1)
						Trader2 = null
						Confirm1 = 0
						Confirm2 = 0
				if(!Trader1 || !Trader2) return
				winset(Trader1, "browser", "is-visible=true")
				winset(Trader2, "browser", "is-visible=true")
				var/mob/Pokemon/T1 = Trader1.Trading
				var/mob/Pokemon/T2 = Trader2.Trading
			//	if(T1)
					//Trader1 << browse_rsc(icon(T1.icon,""), "[T1.name][T1.ID].png")
					//Trader2 << browse_rsc(icon(T1.icon,""), "[T1.name][T1.ID].png")
			//	if(T2)
				//	Trader1 << browse_rsc(icon(T2.icon,""), "[T2.name][T2.ID].png")
				//	Trader2 << browse_rsc(icon(T2.icon,""), "[T2.name][T2.ID].png")
				var/html = "<center><body bgcolor=#000000 text=#FFFF00><B><U><font color = red><font size=1><font face=Verdana>Welcome to Trading Machine.V2!</U><BR><BR><HR><BR>"
				html += "<center><table><tr><td width = 200><font color=red>"
				if(Confirm1) html += "<font color=green>"
				html+="<b><center>Trader 1: [Trader1]</b><BR><BR>"
				if(T1)
					html+="<img src= [T1.name][T1.ID].png><br>[T1.name]<br><br>Level: [T1.Level]"
					if(Confirm1) html+="<br><br><font color = green><a href=?src=\ref[src];action=Confirm1>Cancel Confirmation</a></font><BR>"
					else html+="<br><br><font color = red><a href=?src=\ref[src];action=Confirm1>Confirm Trade</a></font><BR>"

				else
					html += "Pokemon Not Found"
					Confirm1 = 0
				html += "<br><font color = red><a href=?src=\ref[src];action=PokemonTrade>Set Pokemon</a></font><BR>"
				html+="</TD><TD width = 200><font color=red>"
				if(Confirm2) html += "<font color=green>"
				html+="<b><center>Trader 2: [Trader2]</b><BR><BR>"
				if(T2)
					html+="<img src= [T2.name][T2.ID].png><br>[T2.name]<br><br>Level: [T2.Level]"
					if(Confirm2) html+="<br><br><font color = green><a href=?src=\ref[src];action=Confirm2>Cancel Confirmation</a></font><BR>"
					else html+="<br><br><font color = red><a href=?src=\ref[src];action=Confirm2>Confirm Trade</a></font><BR>"
				else
					html += "Pokemon Not Found"
					Confirm1 = 0
				html += "<br><font color = red><a href=?src=\ref[src];action=PokemonTrade>Set Pokemon</a></font><BR></TD></TR></Table>"



				Trader2<<browse(html)
				Trader1<<browse(html)
			pixel_y = 16
			New()
				overlays += /obj/deco/PKMNCenter/Trading_Machine/Extra/TM1
				overlays += /obj/deco/PKMNCenter/Trading_Machine/Extra/TM3
				overlays += /obj/deco/PKMNCenter/Trading_Machine/Extra/TM4
				overlays += /obj/deco/PKMNCenter/Trading_Machine/Extra/TM5
				overlays += /obj/deco/PKMNCenter/Trading_Machine/Extra/TM6
			Topic(href,href_list[])
				..()
				if(!usr) return
				if(!istype(usr,/mob/Player)) return
				var/mob/Player/M = usr
				switch(href_list["action"])
					if("Confirm1")
						if(usr == Trader1)
							if(Trader1.Trading) Confirm1 = !Confirm1
						else if(usr != Trader2) winset(usr, "browser", "is-visible=false")
						UpdateMachine()
					if("Confirm2")
						if(usr == Trader2)
							if(Trader1.Trading)  Confirm2 = !Confirm2
						else if(usr != Trader1) winset(usr, "browser", "is-visible=false")
						UpdateMachine()
					if("PokemonTrade")
						M.Trading = input("Use on:","Pokemon") as mob in M.Party
						if(M.Trading.NonTradable)
							M.Trading = null
							return
						if(M.QuestCheck("Trade Check", M.Trading))
							M.Trading = null
							return //This is for quests.
						M.Trading.ReturntoBall(0)
						Confirm1 = 0
						Confirm2 = 0
						UpdateMachine()
				if(Confirm1 && Confirm2 )

					for(var/i=1, i<7, i++)
						if(Trader1.Party[i] == Trader1.Trading)
							Trader1.Party[i] = Trader2.Trading
							Trader1.CaughtPokemon += initial(Trader2.Trading.name)
					for(var/i=1, i<7, i++)
						if(Trader2.Party[i] == Trader2.Trading)
							Trader2.Party[i] = Trader1.Trading
							Trader2.CaughtPokemon += initial(Trader1.Trading.name)
					Trader1.Trading.Owner = Trader2.ckey
					Trader2.Trading.Owner = Trader1.ckey
					if(Trader1.Trading.Evolve["Trade"])
						if(Trader1.Trading.Evolve["TradeItem"]) if(istype(Trader1.Trading.HeldItem,Trader1.Trading.Evolve["TradeItem"])) Trader1.Trading.Evolve("Trade")
						else Trader1.Trading.Evolve("Trade")
					if(Trader2.Trading.Evolve["Trade"])
						if(Trader2.Trading.Evolve["TradeItem"]) if(istype(Trader2.Trading.HeldItem,Trader2.Trading.Evolve["TradeItem"])) Trader2.Trading.Evolve("Trade")
						else Trader2.Trading.Evolve("Trade")
					Trader2.Trading = null
					Trader1.Trading = null
					Trader1.ItemUsing = 0
					Trader2.ItemUsing = 0
					Trader2.PortraitCheck()
					Trader1.PortraitCheck()
					Trader1.UpdateParty()
					Trader2.UpdateParty()
					Confirm1 = 0
					Confirm2 = 0
					UpdateMachine()
					Trader1 = null
					Trader2 = null


			icon_state = "TM2"
			Extra
				TM1
					icon_state = "TM1"
					pixel_x = -32
					pixel_y = 0
				TM3
					icon_state = "TM3"
					pixel_x = 32
					pixel_y = 0
				TM4
					icon_state = "TM4"
					pixel_y = 32
					pixel_x = -32
				TM5
					icon_state = "TM5"

					pixel_y = 32
				TM6
					icon_state = "TM6"
					pixel_x = 32
					pixel_y = 32



//Transporting//
turf/transporting
	var/go
	var/enterdirection
	var/stepp

	var/
		QuestCheck
		QuestAdd


	proc/ICheck(var/mob/M)
		return 1
	Enter(mob/Player/M)
		if(!go) return
		if(!ICheck(M)) return
		if(!M.density) return 1
		if(istype(M))
			if(M.key && M.density && go)
				if(!enterdirection || M.dir == enterdirection || go == type)
					for(var/obj/O in locate(go))
						spawn() O.BumpedInto()
					M.density = 0
					if(locate(go))
					//	M.sd_SetLuminosity(0)
						M.frozen = 1
						M.FadetoBlack()
						M.loc = locate(go)

						if(QuestAdd) M.QuestAdd(QuestAdd)
						M.QuestCheck("TransportStep", "[src.type]")


						var/turf/TT = M.loc
						M.UpdateDayHUD()
						TT.Entered(M)
						if(!stepp)
							M.FadefromBlack()
							M.frozen = 0

						//M.sd_SetLuminosity(M.Lumos)
					M.density = 1
					if(stepp)
						M.dir = stepp
						var/obj/O = new(M.loc)
						step(O,M.dir)
						M.loc = O.loc
						M.BackgroundMusic()
						M.FadefromBlack()
						M.frozen = 0
						del O
				else return 0
		else
			return 0
//---------------------------------------------------------------------------------------------------------------------------------------------
	Lycus_Valley

		NexusEntrance
			go = /turf/transporting/Lycus_Valley/NexusExit
			enterdirection = 1
			stepp = 1
		NexusExit
			go = /turf/transporting/Lycus_Valley/NexusEntrance
			stepp = 2
		SouthGateEntrance
			go = /turf/transporting/Lycus_Valley/SouthGateExit
			enterdirection = 2
			stepp = 2
		SouthGateExit
			go = /turf/transporting/Lycus_Valley/SouthGateEntrance
			stepp = 1
		WestGateEntrance
			go = /turf/transporting/Lycus_Valley/WestGateExit
			enterdirection = 8
			stepp = 8
		WestGateExit
			go = /turf/transporting/Lycus_Valley/WestGateEntrance
			stepp = 4
		EastGateEntrance
			go = /turf/transporting/Lycus_Valley/EastGateExit
			enterdirection = 4
			stepp = 4
		EastGateExit
			go = /turf/transporting/Lycus_Valley/EastGateEntrance
			stepp = 8
		NorthGateEntrance
			go = /turf/transporting/Lycus_Valley/NorthGateExit
			enterdirection = 1
			stepp = 1

		NorthGateExit
			go = /turf/transporting/Lycus_Valley/NorthGateEntrance
			stepp = 2
		PokemonCenterEntrance
			go = /turf/transporting/Lycus_Valley/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Lycus_Valley/PokemonCenterEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Lycus_Valley/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Lycus_Valley/PokeMartEntrance
			stepp = 2
		MomHouseEntrance
			go = /turf/transporting/Lycus_Valley/MomHouseExit
			enterdirection = 1
			stepp = 1
		MomHouseExit
			go = /turf/transporting/Lycus_Valley/MomHouseEntrance
			stepp = 2
		MomHouseFirsttoSecond
			go = /turf/transporting/Lycus_Valley/MomHouseSecondtoFirst
			enterdirection = 1
			stepp = 1
		MomHouseSecondtoFirst
			go = /turf/transporting/Lycus_Valley/MomHouseFirsttoSecond
			stepp = 2
		NexusBuilding
			Elevator_Stops
				go = /turf/transporting/Lycus_Valley/NexusBuilding/Elevator_Stops/InsideElevator/
				enterdirection = 1
				stepp = 1
				InsideElevator
					go = null
				TournamentHall
				FirstFloor
				SecondFloor
				ThirdFloor
				FourthFloor
			FirsttoSecond
				go = /turf/transporting/Lycus_Valley/NexusBuilding/SecondtoFirst
				enterdirection = 4
				stepp = 8
			SecondtoFirst
				go = /turf/transporting/Lycus_Valley/NexusBuilding/FirsttoSecond
				stepp = 8
				enterdirection = 4
			SecondtoThird
				go = /turf/transporting/Lycus_Valley/NexusBuilding/ThirdtoSecond
				enterdirection = 8
				stepp = 4
			ThirdtoSecond
				go = /turf/transporting/Lycus_Valley/NexusBuilding/SecondtoThird
				stepp = 4
				enterdirection = 8
			ThirdtoFourth
				go = /turf/transporting/Lycus_Valley/NexusBuilding/FourthtoThird
				enterdirection = 4
				stepp = 8
			FourthtoThird
				go = /turf/transporting/Lycus_Valley/NexusBuilding/ThirdtoFourth
				stepp = 8
				enterdirection = 4
			FourthtoFifth
				go = /turf/transporting/Lycus_Valley/NexusBuilding/FifthtoFourth
				enterdirection = 8
				stepp = 4
			FifthtoFourth
				go = /turf/transporting/Lycus_Valley/NexusBuilding/FourthtoFifth
				stepp = 4
				enterdirection = 8
//---------------------------------------------------------------------------------------------------------------------------------------------
	Route301
		SouthGateEntrance
			go = /turf/transporting/Route301/SouthGateExit
			enterdirection = 1
			stepp = 1
		SouthGateExit
			go = /turf/transporting/Route301/SouthGateEntrance
			stepp = 2
		SalemsEntrance
			go = /turf/transporting/Route301/SalemsExit
			enterdirection = 1
			stepp = 1
		SalemsExit
			go = /turf/transporting/Route301/SalemsEntrance
			stepp = 2
		Salems1to2
			go = /turf/transporting/Route301/Salems2to1
		Salems2to1
			go = /turf/transporting/Route301/Salems1to2



//---------------------------------------------------------------------------------------------------------------------------------------------
	Bloomsberry_Lake
		SouthGateEntrance
			go = /turf/transporting/Bloomsberry_Lake/SouthGateExit
			enterdirection = 2
			stepp = 2
		SouthGateExit
			go = /turf/transporting/Bloomsberry_Lake/SouthGateEntrance
			stepp = 1
		GymEntrance
			go = /turf/transporting/Bloomsberry_Lake/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Bloomsberry_Lake/GymEntrance
			stepp = 2
		PokemonCenterEntrance
			go = /turf/transporting/Bloomsberry_Lake/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Bloomsberry_Lake/PokemonCenterEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Bloomsberry_Lake/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Bloomsberry_Lake/PokeMartEntrance
			stepp = 2
		FishingGuruHouseEntrance
			go = /turf/transporting/Bloomsberry_Lake/FishingGuruHouseExit
			enterdirection = 1
			stepp = 1
		FishingGuruHouseExit
			go = /turf/transporting/Bloomsberry_Lake/FishingGuruHouseEntrance
			stepp = 2
//---------------------------------------------------------------------------------------------------------------------------------------------
	RouteBloomsbery_Lake
		SouthGateEntrance
			go = /turf/transporting/RouteBloomsbery_Lake/SouthGateExit
			enterdirection = 1
			stepp = 1
		SouthGateExit
			go = /turf/transporting/RouteBloomsbery_Lake/SouthGateEntrance
			stepp = 2
//----------------------------------------------------------------------------------------------------------------------------
	Route303
		WestMountainGateEntrance
			go = /turf/transporting/Route303/WestMountainGateExit
			enterdirection = 4 //They must be facing WEST when entering
			stepp = 4 //When the arrive at the next point, they will take one step WEST
		WestMountainGateExit
			go = /turf/transporting/Route303/WestMountainGateEntrance
			stepp = 8
		EastMountainGateEntrance
			go = /turf/transporting/Route303/EastMountainGateExit
			enterdirection = 8
			stepp = 8
		EastMountainGateExit
			go = /turf/transporting/Route303/EastMountainGateEntrance
			stepp = 4
		WestGateEntrance
			go = /turf/transporting/Route303/WestGateExit
			enterdirection = 4
			stepp = 4
		WestGateExit
			go = /turf/transporting/Route303/WestGateEntrance
			stepp = 8
		CaveEntrance
			enterdirection = 1
			stepp = 1
			go = /turf/transporting/Mt_Lunar/Level1/CaveExit
		SecretAreaCaveExit
			enterdirection = 1
			stepp = 1
			go = /turf/transporting/Mt_Lunar/Tunnels/ToExit
		Daycare1Entrance
			go = /turf/transporting/Route303/Daycare1Exit
			enterdirection = 1
			stepp = 1
		Daycare1Exit
			go = /turf/transporting/Route303/Daycare1Entrance
			stepp = 2
		Daycare2Entrance
			go = /turf/transporting/Route303/Daycare2Exit
			enterdirection = 1
			stepp = 1
		Daycare2Exit
			go = /turf/transporting/Route303/Daycare2Entrance
			stepp = 2
//----------------------------------------------------------------------------------------------------------------------------------
	Route307
		EastGateEntrance
			go = /turf/transporting/Route307/EastGateExit
			enterdirection = 8
			stepp = 8
		EastGateExit
			go = /turf/transporting/Route307/EastGateEntrance
			stepp = 4
//----------------------------------------------------------------------------------------------------------------------------
	Elkvale_Forest //Route 304
		Top_Entrance
			go = /turf/transporting/Elkvale_Forest/Top_Exit
		Top_Exit
			go = /turf/transporting/Elkvale_Forest/Top_Entrance
		Bottom_Entrance
			go = /turf/transporting/Elkvale_Forest/Bottom_Exit
			enterdirection = 1
		Bottom_Exit
			go = /turf/transporting/Elkvale_Forest/Bottom_Entrance
//----------------------------------------------------------------------------------------------------------------------------
	Route305
		Forest_Entrance
			go = /turf/transporting/Route305/Forest_Exit
			enterdirection = 1
			stepp = 1
		Forest_Exit
			go = /turf/transporting/Route305/Forest_Entrance
			stepp = 2
//----------------------------------------------------------------------------------------------------------------------------
	Elkvale
		GymEntrance
			go = /turf/transporting/Elkvale/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Elkvale/GymEntrance
			stepp = 2
		PokemonCenterEntrance
			go = /turf/transporting/Elkvale/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Elkvale/PokemonCenterEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Elkvale/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Elkvale/PokeMartEntrance
			stepp = 2
		Daycare1Entrance
			go = /turf/transporting/Elkvale/Daycare1Exit
			enterdirection = 1
			stepp = 1
		Daycare1Exit
			go = /turf/transporting/Elkvale/Daycare1Entrance
			stepp = 2
		Daycare2Entrance
			go = /turf/transporting/Elkvale/Daycare2Exit
			enterdirection = 2
			stepp = 2
		Daycare2Exit
			go = /turf/transporting/Elkvale/Daycare2Entrance
			stepp = 1
		PokefluteEntrance
			go = /turf/transporting/Elkvale/PokefluteExit
			enterdirection = 1
			stepp = 1
		PokefluteExit
			go = /turf/transporting/Elkvale/PokefluteEntrance
			stepp = 2
//-------------------------------------------------------------------------------------------------------------------
	Net_City
		GymEntrance
			go = /turf/transporting/Net_City/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Net_City/GymEntrance
			stepp = 2
		PokemonCenterEntrance
			go = /turf/transporting/Net_City/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Net_City/PokemonCenterEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Net_City/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Net_City/PokeMartEntrance
			stepp = 2
		NeikeeHouseEntrance
			go = /turf/transporting/Net_City/NeikeeHouseExit
			enterdirection = 1
			stepp = 1
		NeikeeHouseExit
			go = /turf/transporting/Net_City/NeikeeHouseEntrance
			stepp = 2
		PowerPlant
			PowerPlant_Entrance
				go = /turf/transporting/Net_City/PowerPlant/PowerPlant_Exit
				enterdirection = 1
				stepp = 1
			PowerPlant_Exit
				go = /turf/transporting/Net_City/PowerPlant/PowerPlant_Entrance
				stepp = 2
			FirsttoSecond
				go = /turf/transporting/Net_City/PowerPlant/SecondtoFirst
				enterdirection = 4
				stepp = 8
			SecondtoFirst
				go = /turf/transporting/Net_City/PowerPlant/FirsttoSecond
				stepp = 8
				enterdirection = 4
		Contest_Hall
			Contest_HallEntrance
				go = /turf/transporting/Net_City/Contest_Hall/Contest_HallExit
				enterdirection = 1
				stepp = 1
			Contest_HallExit
				go = /turf/transporting/Net_City/Contest_Hall/Contest_HallEntrance
				stepp = 2
			SecondEntrance
				go = /turf/transporting/Net_City/Contest_Hall/SecondExit
				enterdirection = 1
				stepp = 1
			SecondExit
				go = /turf/transporting/Net_City/Contest_Hall/SecondEntrance
				stepp = 2
	Valley_of_the_Hidden_Ninja
		GymEntrance
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/GymEntrance
			stepp = 2
		PokemonCenterEntrance
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/PokemonCenterEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Valley_of_the_Hidden_Ninja/PokeMartEntrance
			stepp = 2
		Contest_Hall
			Contest_HallEntrance
				go = /turf/transporting/Valley_of_the_Hidden_Ninja/Contest_Hall/Contest_HallExit
				enterdirection = 1
				stepp = 1
			Contest_HallExit
				go = /turf/transporting/Valley_of_the_Hidden_Ninja/Contest_Hall/Contest_HallEntrance
				stepp = 2
			SecondEntrance
				go = /turf/transporting/Valley_of_the_Hidden_Ninja/Contest_Hall/SecondExit
				enterdirection = 1
				stepp = 1
			SecondExit
				go = /turf/transporting/Valley_of_the_Hidden_Ninja/Contest_Hall/SecondEntrance
				stepp = 2


//---------------------------------------------------------------------------------------------------------------------------------------------
	Route306
		NorthGateEntrance
			go = /turf/transporting/Route306/NorthGateExit
			enterdirection = 2
			stepp = 2
		NorthGateExit
			go = /turf/transporting/Route306/NorthGateEntrance
			stepp = 1
//------------------------------------------------------------------------------------------------------
	Route308
		CaveEntrance
			go = /turf/transporting/Mt_Lunar/Level3/CaveExit
			enterdirection = 1
			stepp = 2
//---------------------------------------------------------------------------------------------------------------------------------------------
	Mt_Lunar
		Level1
			CaveExit
				go = /turf/transporting/Route303/CaveEntrance
				stepp = 2
			ToTunnel1
				go = /turf/transporting/Mt_Lunar/Tunnels/ToLevel1
			ToNextLevel1
				go = /turf/transporting/Mt_Lunar/Level2/ToPreviousLevel1
			ToNextLevel2
				go = /turf/transporting/Mt_Lunar/Level2/ToPreviousLevel2
		Level2
			ToPreviousLevel1
				go = /turf/transporting/Mt_Lunar/Level1/ToNextLevel1
			ToPreviousLevel2
				go = /turf/transporting/Mt_Lunar/Level1/ToNextLevel2
			ToNextLevel1
				go = /turf/transporting/Mt_Lunar/Level3/ToPreviousLevel1
			ToTunnel2
				go = /turf/transporting/Mt_Lunar/Tunnels/ToLevel2
		Level3
			ToPreviousLevel1
				go = /turf/transporting/Mt_Lunar/Level2/ToNextLevel1
			ToTunnel3
				go = /turf/transporting/Mt_Lunar/Tunnels/ToLevel3
			CaveExit
				go = /turf/transporting/Route308/CaveEntrance
				stepp = 2
		Tunnels
			ToLevel1
				go = /turf/transporting/Mt_Lunar/Level1/ToTunnel1
			ToLevel2
				go = /turf/transporting/Mt_Lunar/Level2/ToTunnel2
			ToLevel3
				go = /turf/transporting/Mt_Lunar/Level3/ToTunnel3
			ToExit
				go = /turf/transporting/Route303/SecretAreaCaveExit
				stepp = 2
//-----------------------------------------------------------------------------------------------
	Ridgeport
		PokemonCenterEntrance
			go = /turf/transporting/Ridgeport/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Ridgeport/PokemonCenterEntrance
			stepp = 2
		Department_Store
			Elevator_Stops
				go = /turf/transporting/Ridgeport/Department_Store/Elevator_Stops/InsideElevator/
				enterdirection = 1
				stepp = 1
				InsideElevator
					go = null
				FirstFloor
				SecondFloor
				ThirdFloor
				FourthFloor

			StoreEntranceLeft
				go = /turf/transporting/Ridgeport/Department_Store/StoreExitLeft
				enterdirection = 1
				stepp = 1
			StoreEntranceRight
				go = /turf/transporting/Ridgeport/Department_Store/StoreExitRight
				enterdirection = 1
				stepp = 1
			StoreExitLeft
				go = /turf/transporting/Ridgeport/Department_Store/StoreEntranceLeft
				stepp = 2
			StoreExitRight
				go = /turf/transporting/Ridgeport/Department_Store/StoreEntranceRight
				stepp = 2
		NameRaterEntrance
			go = /turf/transporting/Ridgeport/NameRaterExit
			enterdirection = 1
			stepp = 1
		NameRaterExit
			go = /turf/transporting/Ridgeport/NameRaterEntrance
			stepp = 2
		Contest_Hall
			Contest_HallEntrance
				go = /turf/transporting/Ridgeport/Contest_Hall/Contest_HallExit
				enterdirection = 1
				stepp = 1
			Contest_HallExit
				go = /turf/transporting/Ridgeport/Contest_Hall/Contest_HallEntrance
				stepp = 2
			SecondEntrance
				go = /turf/transporting/Ridgeport/Contest_Hall/SecondExit
				enterdirection = 1
				stepp = 1
			SecondExit
				go = /turf/transporting/Ridgeport/Contest_Hall/SecondEntrance
				stepp = 2
//Skysight----------------------------------------------------------------------------------------------

	Skysight
		PokemonCenterEntrance
			go = /turf/transporting/Skysight/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Skysight/PokemonCenterEntrance
			stepp = 2
		GymEntrance
			go = /turf/transporting/Skysight/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Skysight/GymEntrance
			stepp = 2
		House1Entrance
			go = /turf/transporting/Skysight/House1Exit
			enterdirection = 1
			stepp = 1
		House1Exit
			go = /turf/transporting/Skysight/House1Entrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Skysight/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Skysight/PokeMartEntrance
			stepp = 2

//Kindleheart//-----------------------------------------------------------------
	Kindleheart
		PokemonCenterEntrance
			go = /turf/transporting/Kindleheart/PokemonCenterExit
			enterdirection = 1
			stepp = 1
			QuestAdd = /obj/Quest/Fire_VS_Ice

		PokemonCenterExit
			go = /turf/transporting/Kindleheart/PokemonCenterEntrance
			stepp = 2
		GymEntrance
			go = /turf/transporting/Kindleheart/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Kindleheart/GymEntrance
			stepp = 2
		Gym
			Bottom
				B1
					go = /turf/transporting/Kindleheart/Gym/Top/T1
				B2
				B3
				B4
				B5
				B6
				B7
				B8
					go = /turf/transporting/Kindleheart/Gym/Top/T8
				B9
				B10
					go = /turf/transporting/Kindleheart/Gym/Top/T10
			Top
				T1
					go = /turf/transporting/Kindleheart/Gym/Bottom/B1
				T2
					go = /turf/transporting/Kindleheart/Gym/Bottom/B2
				T3
					go = /turf/transporting/Kindleheart/Gym/Bottom/B3
				T4
					go = /turf/transporting/Kindleheart/Gym/Bottom/B4
				T5
					go = /turf/transporting/Kindleheart/Gym/Bottom/B5
				T6
					go = /turf/transporting/Kindleheart/Gym/Bottom/B6
				T7
					go = /turf/transporting/Kindleheart/Gym/Bottom/B7
				T8
					go = /turf/transporting/Kindleheart/Gym/Bottom/B8
				T9
					go = /turf/transporting/Kindleheart/Gym/Bottom/B9
				T10
					go = /turf/transporting/Kindleheart/Gym/Bottom/B10
		PokeMartEntrance
			go = /turf/transporting/Kindleheart/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Kindleheart/PokeMartEntrance
			stepp = 2
//Whitereach//----//Ice City//-------------------------------------------------------------------------------------
	Whitereach
		PokemonCenterEntrance
			go = /turf/transporting/Whitereach/PokemonCenterExit
			enterdirection = 1
			stepp = 1
			QuestAdd = /obj/Quest/Fire_VS_Ice

		PokemonCenterExit
			go = /turf/transporting/Whitereach/PokemonCenterEntrance
			stepp = 2
		GymEntrance
			go = /turf/transporting/Whitereach/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Whitereach/GymEntrance
			stepp = 2
		PidgeyExpressEntrance
			go = /turf/transporting/Whitereach/PidgeyExpressExit
			enterdirection = 1
			stepp = 1
		PidgeyExpressExit
			go = /turf/transporting/Whitereach/PidgeyExpressEntrance
			stepp = 2

//Acconna_Desert//---------------------------------------------------------------------------------------------------
	Acconna_Desert
		IceCaveEntrance
			go = /turf/transporting/Acconna_Desert/IceCaveExit
			enterdirection = 1
			stepp = 1
		IceCaveExit
			go = /turf/transporting/Acconna_Desert/IceCaveEntrance
			stepp = 2
//PolarIcePath//-----------------------------------------------------------------
	PolarIcePath
		FirsttoSecond
			go = /turf/transporting/PolarIcePath/SecondtoFirst
			stepp = 2
		SecondtoFirst
			go = /turf/transporting/PolarIcePath/FirsttoSecond
			stepp = 2
		SecondtoThird
			go = /turf/transporting/PolarIcePath/ThirdtoSecond
			stepp = 2
		ThirdtoSecond
			go = /turf/transporting/PolarIcePath/SecondtoThird
			stepp = 2
//Route 309// Below Whitereach (Ice City)
	Route_309
		IceCaveEntrance
			go = /turf/transporting/Route_309/IceCaveExit
			enterdirection = 1
		IceCaveExit
			go = /turf/transporting/Route_309/IceCaveEntrance
			stepp = 2
//Mirage_City//----------------------------------------------------------------------------------------------------

	Mirage_City
		PokemonCenterEntrance
			go = /turf/transporting/Mirage_City/PokemonCenterExit
			enterdirection = 1
			stepp = 1
		PokemonCenterExit
			go = /turf/transporting/Mirage_City/PokemonCenterEntrance
			stepp = 2
		GymEntrance
			go = /turf/transporting/Mirage_City/GymExit
			enterdirection = 1
			stepp = 1
		GymExit
			go = /turf/transporting/Mirage_City/GymEntrance
			stepp = 2
		CoreyHouseEntrance
			go = /turf/transporting/Mirage_City/CoreyHouseExit
			enterdirection = 1
			stepp = 1
		CoreyHouseExit
			go = /turf/transporting/Mirage_City/CoreyHouseEntrance
			stepp = 2
		PokeMartEntrance
			go = /turf/transporting/Mirage_City/PokeMartExit
			enterdirection = 1
			stepp = 1
		PokeMartExit
			go = /turf/transporting/Mirage_City/PokeMartEntrance
			stepp = 2
		DaycareEntrance
			go = /turf/transporting/Mirage_City/DaycareExit
			enterdirection = 1
			stepp = 1
		DaycareExit
			go = /turf/transporting/Mirage_City/DaycareEntrance
			stepp = 2
		SandCavernEntrance
			go = /turf/transporting/Mirage_City/SandCavernExit
			enterdirection = 1
			stepp = 1
		SandCavernExit
			go = /turf/transporting/Mirage_City/SandCavernEntrance
			stepp = 2

//Firestone Cave//
	Firestone_Cave
		KindleheartEntrance
			go = /turf/transporting/Firestone_Cave/KindleheartExit
			stepp = 1
		KindleheartExit
			go = /turf/transporting/Firestone_Cave/KindleheartEntrance
			enterdirection = 2
			stepp = 2
		WhitereachEntrance
			go = /turf/transporting/Firestone_Cave/WhitereachExit
			stepp = 2
			enterdirection = 2
		WhitereachExit
			go = /turf/transporting/Firestone_Cave/WhitereachEntrance
			enterdirection = 1
			stepp = 1
//Sand_Cavern//-----------------------------------------------------------------------------------------------------
	Sand_Cavern
		F1
			Ladder1
				go = /turf/transporting/Sand_Cavern/F2/Ladder1
			Ladder2
				go = /turf/transporting/Sand_Cavern/F2/Ladder2
			Ladder3
				go = /turf/transporting/Sand_Cavern/F2/Ladder3
			Ladder4
				go = /turf/transporting/Sand_Cavern/F2/Ladder4
			Ladder5
				go = /turf/transporting/Sand_Cavern/F2/Ladder5
			Ladder6
				go = /turf/transporting/Sand_Cavern/F2/Ladder6
			Ladder7
				go = /turf/transporting/Sand_Cavern/F2/Ladder7
			Ladder8
				go = /turf/transporting/Sand_Cavern/F2/Ladder8
			Ladder9
				go = /turf/transporting/Sand_Cavern/F2/Ladder9
			Ladder10
				go = /turf/transporting/Sand_Cavern/F2/Ladder10

		F2
			Ladder1
				go = /turf/transporting/Sand_Cavern/F1/Ladder1
			Ladder2
				go = /turf/transporting/Sand_Cavern/F1/Ladder2
			Ladder3
				go = /turf/transporting/Sand_Cavern/F1/Ladder3
			Ladder4
				go = /turf/transporting/Sand_Cavern/F1/Ladder4
			Ladder5
				go = /turf/transporting/Sand_Cavern/F1/Ladder5
			Ladder6
				go = /turf/transporting/Sand_Cavern/F1/Ladder6
			Ladder7
				go = /turf/transporting/Sand_Cavern/F1/Ladder7
			Ladder8
				go = /turf/transporting/Sand_Cavern/F1/Ladder8
			Ladder9
				go = /turf/transporting/Sand_Cavern/F1/Ladder9
			Ladder10
				go = /turf/transporting/Sand_Cavern/F1/Ladder10
			Ladder11
				go = /turf/transporting/Sand_Cavern/F3/Ladder11
		F3
			Ladder11
				go = /turf/transporting/Sand_Cavern/F2/Ladder11

