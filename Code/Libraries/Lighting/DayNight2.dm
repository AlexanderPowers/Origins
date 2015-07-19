mob/
	var/TimeZoneDifference = "EST +0 Hours"
	var/ChangeZoneTime
	var/tmp/obj/HUD/TimeHUD/TimeHUD
	proc/
		GetTime(var/TimeFormat, var/PlusHour) //Displays the Time, with fixed TimeZone
			if(!TimeFormat) TimeFormat = world.timeofday
			var/Hour = text2num(time2text(TimeFormat,"hh")) + TimeZones[TimeZoneDifference] + PlusHour
			var/Minute = time2text(TimeFormat,"mm")
			var/MM = "AM"

			if(Hour >= 24)
				Hour -= 24
			if(Hour >= 12)
				Hour -= 12
				MM = "PM"

			return "[Hour]:[Minute] [MM]"



		ReturnDay() //Returns 1 for Day, 0 for Day
			var/Hour = text2num(time2text(world.timeofday,"hh"))

			if(IsBetween(Hour+TimeZones[TimeZoneDifference],7,20)) return 1 //It is day
			else return 0

		UpdateDayHUD()
			if(z == 5) //They are outside
				if(ReturnDay()) //It is Day
					TimeHUD.icon_state = "[TimeHUD.WeatherEffect]Day"
				else
					TimeHUD.icon_state = "[TimeHUD.WeatherEffect]Night"
			else //They are inside
				TimeHUD.icon_state = "[TimeHUD.WeatherEffect]Day"

	Player
		verb
			TimeZoneButton()
				set hidden = 1
				if(world.realtime - Timers["ChangeZoneTime"] < 6048000)
					usr<<System("You must wait 7 days inbetween changing your Timezone. This is to prevent cheating.")
					return
				TimeZoneDifference = input("Which Timezone do you live in?", "Timezone Setting", TimeZoneDifference) in TimeZones
				Timers["ChangeZoneTime"] = world.realtime
				winset(src, "Options.TimeZoneButton", "text = 'Set Time Zone: [src.TimeZoneDifference]'")
				UpdateDayHUD()


var/list/TimeZones = list("PST -3 Hours" = -3,"MST -2 Hours" = -2, "CST -1 Hour" = -1 ,"EST +0 Hours" = 0,"AST +1 Hours" = 1 ,"BRST +2 Hours" = 2, "GMT +5 Hours" = 5,"UTC +8 Hours" = 8)




/obj/HUD/TimeHUD
	icon = 'DayNightOverlays.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	layer = 99
	name = null
	mouse_opacity=0
	var/tmp/WeatherEffect
	New(var/client/C)
		..()
		C.screen += src