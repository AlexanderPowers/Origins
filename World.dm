/*
------Changes---------
-Fixed the Player Gym. Entrance now matches door.

*/
#define WORLD_SAVE "World.sav"
#define WORLD_LOG "world_error_log.txt"

#define CHAT_LOG "ChatLog.txt"
#define BAN_SAVE "Bans.sav"
#define DEBUG

world
	New()									// When the world begins
		..()
		log = file(WORLD_LOG)
		LoadStats()
		spawn() Fly()
		FindPlayersinPlayers()
		AutoTournamentWait()
		AssignTradingTrainers()
		spawn(36000*6)
			if(CurrentContest) //There is a contest, wait till after the Contest to reboot.
				CurrentContest.Reboot = 1
			else
				world <<"<B><Center>The world will automatically reboot in 10 minutes."
				sleep(5900)
				world <<"<B><Center>The world will automatically reboot in 30 seconds."
				sleep(300)
				world.Reboot()


	Del()
		SaveStats()
		..()
world

	name = "Pokemon Origins"
	hub = "Alexander08.PokeOrigins"
	hub_password = "Pikachu25"
	status = "{Beta Server}"
	view="17x17"
	mob = /mob/Titlescreen/
	fps = 10 //Do not change, causes movement bug
	tick_lag = 1






client
	script = "<STYLE>BODY {background: black; color: white}</STYLE>"
	command_text = "say "

var/
	list/BannedKeys = list()
	list/AcceptedKeys = list()

	list/PlayerNames = list() //Ckey Name

	PlayerCount = 20
	PiPLog
	list/Tests = list("GiveBattleExp" = 0)



proc/FindPlayersinPlayers()

	spawn(0)
		sleep(18000)
		PiPLog += "<BR>PIP Test done at [Date(world.realtime,1,1,1,1,1)]"
		for(var/mob/Player/P in world) //It searches every Player
			var/T = P.Finds(null)
			if(T)
				PiPLog += "<BR> [T]"
		FindPlayersinPlayers()



proc/LoadStats()

	if(!fexists(WORLD_SAVE)) return
	var/savefile/F = new(WORLD_SAVE)
	if(!fexists(BAN_SAVE)) return
	var/savefile/Bans = new(BAN_SAVE)
	if(!isnull(Bans["Banned IDS"]))Bans["Banned IDS"] >> Banned_IDs
	if(!isnull(Bans["Banned CKEYS"]))Bans["Banned CKEYS"] >> Banned_Keys
	if(!isnull(F["GMS"]))F["GMS"] >> GM
	if(!isnull(F["News"]))F["News"] >> News
	if(!isnull(F["NewsAuthor"]))F["NewsAuthor"] >> NewsAuthor
	if(!isnull(F["NewsDate"]))F["NewsDate"] >> NewsDate
	if(!isnull(F["AcceptedKeys"]))F["AcceptedKeys"] >> AcceptedKeys
	if(!isnull(F["PlayerCount"]))F["PlayerCount"] >> PlayerCount
	if(!isnull(F["PlayerNames"]))F["PlayerNames"] >> PlayerNames
	if(!isnull(F["PlayerLoginTimes"]))F["PlayerLoginTimes"] >> PlayerLoginTimes
	if(!isnull(F["Tests"]))F["Tests"] >> Tests //Many tests use this...
	if(!isnull(F["ChatLog"]))F["ChatLog"] >> ChatLog
	if(!isnull(F["StaffLog"]))F["StaffLog"] >> StaffLog
	if(!isnull(F["GymLog"]))F["GymLog"] >> GymLog
	if(!isnull(F["NextTournament"]))F["NextTournament"] >>NextTournament

	if(!isnull(F["Teams"]))F["Teams"] >> Teams
	if(!isnull(F["ClaimedRoutes"]))F["ClaimedRoutes"] >> ClaimedRoutes

	if(!isnull(F["PlayerGyms"]))F["PlayerGyms"] >> PlayerGyms
	if(!isnull(F["BugLog"]))F["BugLog"] >> BugLog
	if(!isnull(F["HelpFilesHTML"]))F["HelpFilesHTML"] >> HelpFilesHTML
	//if(!isnull(F["TradingTrainers"]))F["TradingTrainers"] >> TradingTrainers
	//Create the Player Gyms//
	for(var/i in PlayerGyms)
		var/PlayerGym/PG = PlayerGyms[i]
		if(PG.GymLoc)
			var/obj/deco/Buildings/Player_Gym/PGB = new (LocFromNum(PG.GymLoc))
			PG.Building = PGB
			PGB.Construct(PG.Type)

	if(!length(Teams)) //There are no teams created, this is the first time the game has seen them.
		var/list/Types = typesof(/Team)
		for(var/i in Types)
			if(i == /Team) continue
			Teams += new i










proc/SaveStats()
	var/savefile/F = new(WORLD_SAVE)
	var/savefile/Bans = new(BAN_SAVE)

	Bans["Banned IDS"] << Banned_IDs
	Bans["Banned CKEYS"] << Banned_Keys
	F["News"] << News
	F["GMS"] << GM
	F["AcceptedKeys"] <<AcceptedKeys
	F["PlayerCount"] << PlayerCount
	F["NewsAuthor"] <<NewsAuthor
	F["NewsDate"] << NewsDate
	F["PlayerNames"] << PlayerNames
	F["PlayerLoginTimes"] << PlayerLoginTimes
	F["Tests"] << Tests
	F["ChatLog"] << ChatLog
	F["StaffLog"] << StaffLog
	F["GymLog"] << GymLog
	F["NextTournament"] << NextTournament

	F["Teams"] << Teams
	F["ClaimedRoutes"] << ClaimedRoutes

	F["PlayerGyms"] << PlayerGyms
	F["BugLog"] << BugLog
	//Find out which HelpFileHTML is Longer
	//The one already saved, or the one to be saved
	var/SavedHelp = F["HelpFilesHTML"]
	var/NewHelp = HelpFilesHTML
	var/SavedLength
	var/NewLength
	for(var/i in SavedHelp) SavedLength += length(SavedHelp[i])
	for(var/i in NewHelp) NewLength += length(NewHelp[i])
	if(NewLength >= SavedHelp) F["HelpFilesHTML"] <<HelpFilesHTML
	F["TradingTrainers"] << TradingTrainers





//The FLYING-type Pokemon flying by from Right to Left side of map//--------------------------------------------------------------------------------

proc/Fly()
	spawn()
		var/Y = 0
		while(world)
			sleep(50)
			while(!Y)
				for(var/mob/Player/P in world)
					if(prob(70))
						Y = max(1, rand(P.y +4,P.y - 4))
				if(!Y) Y = rand(1,world.maxy)
			var/obj/BirdFlock/BF = new
			BF.loc = locate(world.maxx,Y,5)
			Y = 0
			sleep(600)

obj/BirdFlock
	icon_state = "Fly"
	dir = 8
	layer = 80
	density = 0
	menu
	New()
		if(prob(50))
			pixel_x = -92
			icon = pick('333Swablu.dmi','276Taillow.dmi','021Spearow.dmi','016Pidgey.dmi','017Pidgeotto.dmi','015Beedrill.dmi','166Ledian.dmi','165Ledyba.dmi', '164Noctowl.dmi')
			var/obj/BF
			var/yyy = pick(16,20,24)
			for(var/i=1, i<4, i++)
				for(var/j=i*-1, j<i+1, j++)
					if(IsBetween(j, (i*-1)+1,i-1)) continue
					BF = new
					BF.layer = 99
					BF.pixel_y = j*yyy
					BF.pixel_x = i*32
					BF.icon = icon
					overlays += BF
			walk(src,8,2)
			spawn(1200) del src
		else
			icon = pick('334Altaria.dmi','330Flygon.dmi','284Masquerain.dmi','267Beautifly.dmi','269Dustox.dmi','277Swellow.dmi','012Butterfree.dmi','018Pidgeot.dmi','022Fearow.dmi','049Venomoth.dmi', '198Murkrow.dmi')
			walk(src,8,2)
			spawn(1200) del src


//The assigning of Trading Trainers at world start//-----------------------------------------------------------------------------------------------------------------------------------
var/list/TradingTrainers = list() //A list of trainers currently trading.

proc/Pick_Trainer()
	PickType
	var/TT = pick(typesof(/mob/NPCTrainer))
	var/mob/NPCTrainer/NPC = new TT
	if(!NPC.Tradable) spawn(1) goto PickType

	if(!length(NPC.Pokes)) return //They have no Pokemon to trade... skip them.
	var/I = pick(NPC.Pokes)
	var/mob/Pokemon/TP
	if(isnum(NPC.Pokes[I]))
		TP = new I
	else if(islist(I))
		var/list/Co = I
		var/L = Co.Copy()
		if(L["set type"])
			var/NT = L["set type"]
			TP = new NT
		else
			var/NT = L["type"]
			TP = new NT



	var/list/TTInfo = list("Score" = 0, "Pokemon" = null, "Item" = null, "Settime" = 0, "Trainer Name")
	for(var/i in TP.BaseStats) TTInfo["Score"] += TP.BaseStats[i]
	TTInfo["Score"] += length(TP.LearnMoves)
	TTInfo["Score"] += 256 - TP.CaptureRate
	TTInfo["Pokemon"] = TP.type
	TTInfo["PokemonName"] = TP.name
	TTInfo["Settime"] = world.realtime
	TTInfo["Trainer Name"] = NPC.name
	del NPC
	del TP

	TradingTrainers[TT] = TTInfo


proc/AssignTradingTrainers()
	set background = 1
	if(!length(TradingTrainers)) for(var/i = 1, i <= 6, i++) Pick_Trainer() // Don't do this if TradingTrainers is world saved.
	spawn(1)
		while(world)
			sleep(rand(5000,7000))
			if(length(TradingTrainers) >= 10) //IF there is 10 trainers already in the list, then remove.
				var/TT = 1
				while(!TT)
					TT = TradingTrainers[pick(TradingTrainers)]
					var/list/Co = TradingTrainers[TT]
					var/L = Co.Copy()
					if(L["Settime"] && world.realtime - L["Settime"] < 12000) //They cannot be replaced if they've only been in the cycle for 20 minutes.
						TT = null
						sleep(10)


			Pick_Trainer()


