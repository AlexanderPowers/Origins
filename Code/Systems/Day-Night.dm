mob/Player/var
	TimeofDay ="Day"


obj/HUD/NightOverlays
	icon = 'HUD Overlays.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	icon_state = "1"
	layer = 60
	name = null
	mouse_opacity=0
	New(var/client/C)
		..()
		C.screen += src

/obj/HUD/screen_hud
	icon = 'HUD Overlays.dmi'
	screen_loc = "SOUTHWEST to NORTHEAST"
	layer = 100
	name = null
	mouse_opacity=0
	New(var/client/C)
		..()
		C.screen += src