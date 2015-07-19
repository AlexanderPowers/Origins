var/DayLightsSaving = 0
proc
	Area(var/A)
		for(var/area/a in world)
			if(istype(a, A))
				return a
	ObjectView(var/Dist, var/atom/Center) //Like view, returns a list of things but from objects.
		var/list/Stuff = list()
		for(var/i = Center.x-Dist, i<=Center.x+Dist,i++)
			for(var/j = Center.y-Dist, j<=Center.y+Dist,j++)
				var/turf/T = locate(i,j,Center.z)
				Stuff += T
				Stuff += T.contents
		return Stuff
	Generate_Pokemon(var/area/A, var/mob/Player/M, var/Extra)

		if(!isarea(A) || !isPlayer(M)) return 0
		var/list/GrassPokemon
		var/list/PossibleTypes = list()
		if(!length(A.DayPokemon) || !length(A.NightPokemon)) if(!length(A.WaterPokemon))return 0
		if(M.ReturnDay()) GrassPokemon = A.DayPokemon.Copy()
		else GrassPokemon = A.NightPokemon.Copy()
		if(Extra == "Fishing")
			if(!length(A.WaterPokemon)) return 0
			GrassPokemon = A.WaterPokemon.Copy()
			PossibleTypes = A.WaterPokemon.Copy()
		else
			var/Badges = max(1,M.Badges())
			for(var/i = 1, i <= Badges, i++)
				if(i > length(GrassPokemon)) break //There are no more Pokemon Lists, so stop the loop
				var/list/L = GrassPokemon[i]
				if(L)
					for(var/j in L)
						PossibleTypes += j
		if(!length(PossibleTypes))  return 0
		PickPokemon
		var/p = pick(PossibleTypes)

		var/Rare = PossibleTypes[p]
		if(prob(Rare))
			PossibleTypes -= p
			goto PickPokemon


		var/mob/Pokemon/P = new p

		var/Ratio = round((max(1,P.CaptureRate)/255)*100) //How rare is the Pokemon?
		if(prob(Ratio)) P<<1
		else
			PossibleTypes -= P.type
			if(length(PossibleTypes))
				p = pick(PossibleTypes)
				P = new p
			else return 0

		var/TotalPartyPokemon //This is the Pokemon in your party
		var/TotalPartyLevels //This is the Total Levels of the Pokemon in your party
		for(var/mob/Pokemon/Poke in M.Party)
			TotalPartyLevels += Poke.Level
			TotalPartyPokemon += 1

		CheckEvolve

		///Determine the Level////
		if(TotalPartyPokemon) //This means they have at least 1 Pokemon
			P.Level = (TotalPartyLevels / TotalPartyPokemon)
			var/r = round(P.Level / 6)
			P.Level += rand(r, r *-1)
		else return 0 //Do not spawn Pokemon if they do not have Pokemon to defend themselves
		var/MaxLevel = M.Badges() * 5 + M.Badges() //The Pokemons level can never exceed this number. It will raise with the number of badges
		//For if they haven't earned a badge yet.
		if(!M.Badges()) P.Level = min(MaxLevel, P.Level)
		P.Level = min(MaxLevel, P.Level)


		var/MaxAreaLevel = GrassPokemon[P.type] //This should return the max level the Pokemon should be, if it has one. This is for Pokemon like Magikarp.
		if(MaxAreaLevel) P.Level = min(MaxAreaLevel, P.Level)

		P.Level += max(5,rand(-2,TotalPartyPokemon - 4)) //This decreases the level of the Pokemon if there is less Pokemon in the Players Party.
		P.Level = round(P.Level) //Just to make sure the Level is a whole



		for(var/i in P.Evolve) //Is there a chance they can evolve?
			if(findtext(i,"Level ") || findtext(i,"WildLevel "))
				var/Loc = 7
				if(findtext(i,"Wild")) Loc += 4
				var/EvolveLevel = text2num(copytext(i,7))
				if(EvolveLevel <= P.Level)
					if(prob(P.Level + 25))
						var/K = P.Evolve[i]
						var/PP = new K
						Proliferate(P)
						P = PP
						goto CheckEvolve

		P.Level = max(2,P.Level) //It should never be above 2 now..

		return P

	ClearPokemon(var/Key, var/BeforeSave)
		set background = 1
		spawn()
			if(!BeforeSave)
				for(var/obj/Overworld/O in world)
					var/mob/Pokemon/P = O.owner
					if(!P) continue //Fixed for runtime error, if the Move does not have an Owner, then it will crash the proc.
					if(P.Owner == Key) Proliferate(O)
				for(var/mob/Pokemon/P in world)
					if(P.Owner == Key)
						Proliferate(P)
			else
				for(var/mob/Pokemon/P in world)
					if(P.Owner == Key)
						for(var/obj/Moves/M in P.Moves)
							M.Hit = list()



	Hour()
		var/RT = Date(world.realtime,1,1,0,0,0)
		var/hour = text2num(copytext(RT,1,findtext(RT,":")))
		if(findtext(RT,"PM")) hour += 12
		return hour



	Proliferate(var/datum/D) //Some atoms cannot be deleted with del unless defined as a datum, so to save the trouble I simply made a proc to do this.
		del D
	isatom(var/atom/s)   return istype(s)
	isimage(var/image/s) return istype(s)
	issound(var/sound/s) return istype(s)
	islist(var/list/s)   return istype(s)
	isPlayer(var/mob/Player/m) return istype(m)
	isPokemon(var/mob/Pokemon/m) return istype(m)

	uppercase(var/string, var/pos=1)
		if(!string || !pos) return
		return uppertext(copytext(string, pos, pos+1))+copytext(string, pos+1)
	hasSavefile(var/ckey)
		var/letter = copytext(ckey,1,2)
		return fexists("Players/[letter]/[ckey].sav")
	percent_of(var/amount,var/percent)
		return (amount * percent) / 100

	Get_Steps(var/atom/A, var/Dir, var/Step)
		for(var/i = 1, i <= Step, i++)
			A = get_step(A,Dir)
		return A

//Chat Filters//-----------------------------------------------------------------------
	symbol(length as num)
		var/T
		for(var/i = 0,i < length,i++)
			T += "*"
			//T += pick("!","@","#","$","%","^","&","*")
		return T

	filter(msg as text)
		var/txt = html_encode(lowertext(msg)) // the whole string
		var/a                   // naughty word to be filtered
		var/out                 // outputs the whole string + the filtered word
		for(var/cuss in Badwords)           // loops through the Badwords list
			if(findtext(txt,"[cuss]"))		// if it finds a naughty word in the string
				for(var/i = 1, i <= length(txt))        //loop through looking for the cuss word
					a = copytext(msg, i , i+length(cuss))   // sets variable a to copy the cuss word
					if(lowertext(a) == "[cuss]")			// passes it to lowertext and checks it's a cuss word
						a = symbol(length(cuss))			// turns it to stars or symbols
						i+= length(cuss)					// directs length of loop
						out += "[a]"						// final filtered cussword added back to original string

					else
						out += copytext(msg, i, i+1)		// copies original message if there's no cuss word
						i ++								// iterates
				msg = out									//
				txt = lowertext(msg)						//{ resetting vars
				out = ""									//
		return msg
//List Procs//

	FindType(var/list/L, var/FindType)
		if(!islist(L)) return 0
		for(var/atom/A in L)
			if(A.type == FindType)
				return A

//Custom Alert System//------------------------------------------------------------------------------------

mob/var
	list/Alerts = list()
	tmp/Alert/CurrentAlert


mob/proc/ViewAlerts()
	set background = 1
	if(CurrentAlert) return //There is already an alert.
	winset(src, "Alert", "is-visible=false")
	if(!length(Alerts)) return //There is nothing to cycle through, so we're done.
	for(var/Alert/A in Alerts)
		CurrentAlert = A
		winset(src, "Alert", "is-visible=true")
		winset(src, "AlertText", "text='[A.Message]'")
		winset(src, "AlertOption1", "text='[A.Option1]'")
		winset(src, "AlertOption2", "text='[A.Option2]'")

mob/proc/Alert(var/Message = "What is your answer?", var/Option1 = "Yes", var/Option2 = "No")
	var/Alert/A = new
	A.Message = Message
	A.Option2 = Option2
	A.Option1 = Option1
	Alerts += A
	usr.ViewAlerts()
	spawn(600) if(A) A.Answer = Option1
	while(!A.Answer)
		sleep(5)
	var/R = A.Answer
	Proliferate(A)
	return R
Alert
	var/
		Message
		Option1
		Option2
		Answer

//---------------------------------------------------------------------------------------------------------
proc
	CoordsToNum(a as num, b as num, c as num)
		var/final = "X[a]Y[b]Z[c]"
		return final
	LocFromNum(final as text)

		var/a = text2num(copytext(final,2,findtext(final,"Y")))
		var/b = text2num(copytext(final,findtext(final,"Y")+1,findtext(final,"Z")))
		var/c = text2num(copytext(final,findtext(final,"Z")+1))
		return locate(a,b,c)

	TempStatReturn(var/K)
		switch(K)
			if(1) return 1.5
			if(2) return 2
			if(3) return 2.5
			if(4) return 3
			if(5) return 3.5
			if(6) return 4
			if(-1) return 0.66
			if(-2) return 0.50
			if(-3) return 0.40
			if(-4) return 0.33
			if(-5) return 0.28
			if(-6) return 0.25
		return 1
	Date(timestamp=world.realtime,format="d/m/y g:i.s A",offset=0)
		//A numerical offset has some of the flexibility of text -- decimals can be provided to \
		offset generated timestamps, though the final multiplication result is floored.
		if(isnum(offset)) offset = round(offset*36000)
		else if(istext(offset))
			//If the text offset format is selected, there must be two integers separated by a non-\
			numeric character.
			var/d = 0
			for(var/i=1;i<=length(offset);i++)
				var/t = text2ascii(offset,i)
				if(t == 47 || t < 45 || t > 57)
					d = i
					break
			if(d) offset = (round(text2num(copytext(offset,1,d)))*36000)+(round(text2num(copytext(offset,d+1)))*600)
			//If there is no delimiter, we assume only an hour offset was provided
			else offset = (round(text2num(offset))*36000)
		if(isnum(offset)) //The offset value should be an integer if all is well
			 //Apply the given offset to the timestamp
			timestamp += offset
			. = ""
			for(var/i=1;i<=length(format);i++)
				var/t = text2ascii(format,i)
				switch(t)
					//Quick and easy
					if(68) . += time2text(timestamp,"DD") //D
					if(72) . += time2text(timestamp,"hh") //H
					if(89) . += time2text(timestamp,"YYYY") //Y
					if(100)
						var/v = time2text(timestamp,"DD")
						. += (text2num(v) < 10 ? copytext(v,2) : v) //d
					if(103) . += num2text(round((text2num(time2text(timestamp,"hh"))+11)%12+1)) //g
					if(105) . += time2text(timestamp,"mm") //i
					if(109) . += time2text(timestamp,"MM") //m
					if(115) . += time2text(timestamp,"ss") //s
					if(116) . += time2text(timestamp,"DDD") //t
					if(117) . += time2text(timestamp,"MMM") //u
					if(121) . += time2text(timestamp,"YY") //y
					//...and not so lucky
					if(71,77,104)
						//These are tokens that need a zero prepended if their values are \
						less than ten
						var/v = 0
						if(t == 71) v = round((text2num(time2text(timestamp,"hh"))+11)%12+1) //G
						else if(t == 77) v = text2num(time2text(timestamp,"MM")) //M
						else v = text2num(time2text(timestamp,"hh")) //h
						. += (v < 10 ? "0[v]" : "[v]")
					//meridiem
					if(65,97)
						var/h = text2num(time2text(timestamp,"hh"))
						. += ((h >= 0 && h < 12) ? (t == 65 ? "AM" : "am") : (t == 65 ? "PM" : "pm"))
					if(111)
						if(i > 1)
							var
								l = text2ascii(format,i-1)
								d = text2num(time2text(timestamp,"DD"))
							if(l == 68 || l == 100)
								if(d == 1 || d == 21 || d == 31) . += "st"
								else if(d == 2 || d == 22) . += "nd"
								else if(d == 3 || d == 23) . += "rd"
								else . += "th"
					else . += ascii2text(t)
		else return null
	TimeMuch(var/I)
		if(!isnum(I)) return "????"
		var/Hours = round(I / 36000)
		var/Minutes = round(I / 600) - (Hours * 60)
		var/Seconds = round(I / 10) -  (Minutes * 60)
		var/Total
		if(Hours)
			if(Hours == 1) Total += "1 Hour, "
			else Total += "[Hours] Hours, "
		if(Minutes)
			if(Minutes == 1) Total += "1 Minute, "
			else Total += "[Minutes] Minutes, "
		if(Seconds)
			if(Seconds == 1) Total += "1 Second, "
			else Total += "[Seconds] Seconds, "
	IsOdd(var/num)
		if(!IsEven(num))
			return 1
		return 0
	IsEven(var/num)
		if(num%2 == 0)
			return 1
		return 0
	Replace_Character(var/message, var/c1, var/c2)
		var/newM
		for(var/i = 1, i<= length(message), i++)
			var/Letter = copytext(message, i, i+1)
			if(Letter == c1) newM += c2
			else newM += Letter
		return newM
	IsBetween(var/num, var/minvalue,var/maxvalue)
		if(num >= minvalue && num <= maxvalue)
			return 1
		return 0
	GetPlayer(message = "Use this on who?",list/List= world,var/mob/Player/Default)
		var/list/options = list()
		for(var/mob/Player/m in List)

			if(!m.client || m.name == "????" || !m.name) continue
			var/info = "[m.name]/([m.key])[m.AFK ? "     AFK" : ""]"   //[Statment ? "If True" : "If False"]
			if(m == Default) Default = info
			options[info] = m
		var/mob/M = input("[message] ([length(options)] Players)",,Default) as null|anything in options
		if(!M) return 0
		M = options[M]
		options = list()
		return M
	GetOwner(var/key)
		if(!key) return 0
		for(var/mob/P in world)
			if(P.ckey == key)
				return P




	Dialog(var/mob/Player/Speaker, var/Dialog)
		if(ismob(Speaker) && Speaker.client) Speaker = "<a href=?src=\ref[Speaker];action=Stats style=text-decoration:none>[Speaker.name]</a>"
		return "<font color = blue><b>[Speaker]</b> says, <font color = white>''[Dialog]''</font>"
	System(var/Message,var/font = "<font color = red>")
		return "[font](System) [Message]</font>"
	Quest(var/Message,var/font = "<font color = green>")
		return "[font](Quest) [Message]</font>"

atom/movable
	var
		tmp/obj/flick_overlay
	proc
		adjusttrans(var/trans, var/I)
			if(!I) I = initial(icon)
			src.icon = I
			src.icon = rgb(0,0,0,trans)

		flick_overlay(var/iconz, var/icon_statez,var/pixelX, var/pixelY)
			if(flick_overlay) Proliferate(flick_overlay)
			flick_overlay = new/obj
			flick_overlay.loc = loc
			flick_overlay.pixel_x = pixelX
			flick_overlay.pixel_y = pixelY
			flick_overlay.layer = 99
			flick_overlay.icon = iconz
			flick(icon_statez,flick_overlay)
			spawn(50) del flick_overlay


	Move()
		..()
		if(flick_overlay)
			flick_overlay.loc = loc

