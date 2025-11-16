extends Node2D

signal activate_gui
signal countdown(time: float)


func _ready() -> void:
	reset_spaceship()
	%MapAnimationPlayer.play("earth")


func _process(_delta: float) -> void:
	pass


func _on_launch_button_pressed() -> void:
	launch()


func launch() -> void:
	if State.completed:
		State.reset()
		get_tree().reload_current_scene()
		return
	
	State.launched = true
	ignite()
	
	match State.planet:
		G.PLANET.EARTH:
			%MapAnimationPlayer.play("earth_venus")
		G.PLANET.VENUS:
			%MapAnimationPlayer.play("venus_mercury")
		G.PLANET.MERCURY:
			%MapAnimationPlayer.play("mercury_sun")
	
	var t0 = %MapAnimationPlayer.get_section_end_time()
	var t1 = State.get_time_upgraded(t0)
	countdown.emit(t1)
	
	%MapAnimationPlayer.speed_scale = t0 / t1
	%RocketAnimationPlayer.play("center")


func reset_spaceship() -> void:
	%Ship.visible = true
	%Ship10.visible = false
	%Ship20.visible = false
	%Ship30.visible = false
	%Ship40.visible = false
	%Ship50.visible = false
	%Ship60.visible = false
	%Ship70.visible = false
	%Ship80.visible = false
	%Ship90.visible = false
	%Ship100.visible = true
	%BlueFire.visible = false
	%OrangeFire.visible = false
	%WhiteFire.visible = false
	%Explode.visible = false


func ignite() -> void:
	%BlueFire.visible = false
	%OrangeFire.visible = false
	%WhiteFire.visible = false
	
	if State.upgrades.fuel <= 5:
		%OrangeFire.visible = true
		%OrangeFire.play("ignite")
	elif State.upgrades.fuel <= 10:
		%WhiteFire.visible = true
		%WhiteFire.play("ignite")
	else:
		%BlueFire.visible = true
		%BlueFire.play("ignite")


func extinguish() -> void:
	if State.upgrades.fuel <= 5:
		%OrangeFire.play("extinguish")
	elif State.upgrades.fuel <= 10:
		%WhiteFire.play("extinguish")
	else:
		%BlueFire.play("extinguish")


func explode() -> void:
	%Ship.visible = false
	%BlueFire.visible = false
	%OrangeFire.visible = false
	%WhiteFire.visible = false
	
	%Explode.visible = true
	%Explode.play("boom")


func win() -> void:
	State.completed = true
	explode()
	gui()


func _on_map_animation_player_animation_finished(anim_name: StringName) -> void:
	if State.planet == G.PLANET.MERCURY:
		win()
	elif anim_name == "earth_venus" || anim_name == "venus_mercury":
		land()


func land() -> void:
	match State.planet:
		G.PLANET.EARTH:
			State.planet = G.PLANET.VENUS
		G.PLANET.VENUS:
			State.planet = G.PLANET.MERCURY
	
	%RocketAnimationPlayer.play("offset")


func _on_rocket_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "offset":
		extinguish()


func gui() -> void:
	State.launched = false
	activate_gui.emit()


func _on_blue_fire_animation_finished() -> void:
	if %BlueFire.animation == "extinguish":
		gui()


func _on_orange_fire_animation_finished() -> void:
	if %OrangeFire.animation == "extinguish":
		gui()


func _on_white_fire_animation_finished() -> void:
	if %WhiteFire.animation == "extinguish":
		gui()
