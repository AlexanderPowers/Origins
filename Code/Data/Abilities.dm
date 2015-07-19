//=
proc/AbilityCheck(var/mob/Pokemon/USR, var/Instance, var/atom/A1)

	switch(Instance)
		if("Attack Power Increase")
			var/obj/Moves/Attack = A1
			switch(USR.Ability)
				if("Blaze") //Overgrow: Increases attack by 1.5 if the Attackers Health is below 1/3 of Max.
					if(USR.HP <= (USR.MHP/3))
						if(Attack.Type == "Fire")
							USR.flick_overlay('Abilities.dmi', "Blaze")
							return 1.5
				if("Iron Fist") //Iron Fist causes the Base Power of affected punching moves to increase by 20%.
					if(findtext(Attack.name,"Punch"))
						USR.flick_overlay('Abilities.dmi', "Iron Fist")
						return 1.2
				if("Overgrow") //Overgrow: Increases attack by 1.5 if the Attackers Health is below 1/3 of Max.
					if(USR.HP <= (USR.MHP/3))
						if(Attack.Type == "Grass")
							USR.flick_overlay('Abilities.dmi', "Overgrow")
							return 1.5

				if("Torrent") //Overgrow: Increases attack by 1.5 if the Attackers Health is below 1/3 of Max.
					if(USR.HP <= (USR.MHP/3))
						if(Attack.Type == "Water")
							USR.flick_overlay('Abilities.dmi', "Torrent")
						return 1.5
		if("Contact")
			var/mob/Pokemon/P = A1
			var/mob/Player/O = GetOwner(P.Owner)
			switch(USR.Ability)
				if("Flame Body")
					if(prob(20))
						P.Burn(USR)
						O<<System("[P] was affected by [USR]'s Flame Body!")
				if("Static")
					if(prob(20))
						P.Paralysis(USR)
						O<<System("[P] was affected by [USR]'s Static!")


		if("Enter Battle")
			switch(USR.Ability)
				if("Intimidate")
					if(USR.SecondaryStatus["Intimidate"] >= world.realtime) return
					for(var/mob/Pokemon/P in view(10, USR))
						if(P.Owner == USR.Owner || P.TempStats["ATK"] <= -5) continue
						spawn() missile(/obj/Overworld/Growl, src, P)
						P.GiveTempStat(USR,"ATK",-1)
						P.GiveTempStat(USR,"ATK",1,600)
						USR.SecondaryStatus["Intimidate"] = world.realtime + 600
						var/mob/Player/O = GetOwner(P.Owner)
						O<<System("[P] was affected by [USR]'s Intimidation!")


//Silver Wind, Solar Power, Sheer Force, Techtitcian, Iron Fist