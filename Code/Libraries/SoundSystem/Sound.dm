mob/Player/
	var/
		Options = list("Sound" = 1,"Battle Settings" = 0)


mob/Player/verb/SetOption(var/INPUT as text)
	src.Options[INPUT] = !src.Options[INPUT]
	UpdateOptions()


mob/Player/proc
	UpdateOptions()
		if(BattleSettings["LevelMaximum"]) winset(usr, "CourtSettings.MaximumButton", "text='Pokemon Level Maximum: [BattleSettings["LevelMaximum"]]")
		if(BattleSettings["LevelMinimum"]) winset(usr, "CourtSettings.MinimumButton", "text='Pokemon Level Minimum: [BattleSettings["LevelMinimum"]]")
		for(var/i in Options)
			if(Options[i])
				winset(src, "Options.[i]", "is-checked=true")
			else
				winset(src, "Options.[i]", "is-checked=false")
		winset(src, "Options.TimeZoneButton", "text = 'Set Time Zone: [src.TimeZoneDifference]'")
mob/proc
	BackgroundMusic(var/S, var/Fade = 20)
	/*	var/mob/Player/P = src
		if(!isPlayer(P)) return
		if(client) //No Pokemon can do this...
			if(!P.Options["Sound"]) //They have the music turned off, it should not happen
				if(src.client.sound_system.current_music) src.client.sound_system.EndMusic()
				return
			else
				if(!S)
					var/area/A = loc.loc
					S = A.Sounds

				src.client.sound_system.AlterMusic(S, Fade)*/
	SoundEffect(var/S)
		/*var/mob/Player/P = src
		if(!isPlayer(P)) return
		if(P.Options["Sound"])

			src.client.sound_system.SetMusicVolume(1)
			src.client.sound_system.PlaySound(S, null, null)
			spawn(10)
				src.client.sound_system.SetMusicVolume(65)*/






