/obj/effect/expl_particles
	name = "explosive particles"
	icon = 'icons/effects/effects.dmi'
	icon_state = "explosion_particle"
	opacity = 1
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/expl_particles/atom_init()
	. = ..()
	QDEL_IN(src, 15)

/datum/effect/system/expl_particles
	var/number = 10
	var/turf/location
	var/total_particles = 0

/datum/effect/system/expl_particles/proc/set_up(n = 10, loca)
	number = n
	if(istype(loca, /turf)) location = loca
	else location = get_turf(loca)

/datum/effect/system/expl_particles/proc/start()
	var/i = 0
	for(i=0, i<src.number, i++)
		spawn(0)
			var/obj/effect/expl_particles/expl = new /obj/effect/expl_particles(src.location)
			var/direct = pick(alldirs)
			for(i=0, i<pick(1;25,2;50,3,4;200), i++)
				sleep(1)
				step(expl,direct)

/obj/effect/explosion
	name = "explosive particles"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "explosion"
	opacity = 1
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_x = -32
	pixel_y = -32

/obj/effect/explosion/atom_init()
	. = ..()
	QDEL_IN(src, 10)

/datum/effect/system/explosion
	var/turf/location
	var/practicles = 10

/datum/effect/system/explosion/proc/set_up(loca, practicles_number)
	if(istype(loca, /turf)) location = loca
	else location = get_turf(loca)
	if(!isnull(practicles_number))
		practicles = max(practicles_number, 10)

/datum/effect/system/explosion/proc/start()
	new/obj/effect/explosion(location)
	if(practicles)
		var/datum/effect/system/expl_particles/P = new/datum/effect/system/expl_particles()
		P.set_up(practicles,location)
		P.start()
