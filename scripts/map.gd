extends Sprite2D

var spawn_rate: float
var spawn := false
var t := 0.0

@onready var EumoniaScene := preload("res://scenes/asteroids/eumonia.tscn")
@onready var EuropaScene := preload("res://scenes/asteroids/europa.tscn")
@onready var NormalAsteroidScene := preload("res://scenes/asteroids/normal_asteroid.tscn")
@onready var ThemisScene := preload("res://scenes/asteroids/themis.tscn")
@onready var asteroids := [EumoniaScene, EuropaScene, NormalAsteroidScene, ThemisScene]
var a := []


func _process(delta: float) -> void:
	if spawn:
		t += delta
		if t > spawn_rate:
			t = 0.0
			spawn_asteroid()
			if a.size() > 500:
				a.pop_front()


func spawn_asteroid() -> void:
	var ast = asteroids[randi_range(0, asteroids.size() - 1)].instantiate()
	
	match State.planet:
		G.PLANET.EARTH:
			%AsteroidPathFollow.progress_ratio = randf_range(0.03, 0.2)
		G.PLANET.VENUS:
			%AsteroidPathFollow.progress_ratio = randf_range(0.25, 0.54)
		G.PLANET.MERCURY:
			%AsteroidPathFollow.progress_ratio = randf_range(0.6, 0.9)
			#ast.MIN_SPEED = 100.0
			#ast.MAX_SPEED = 200.0
	
	ast.global_position.x = -600.0
	ast.global_position.y = %AsteroidPathFollow.global_position.y/8.0
	%Asteroids.add_child(ast)
	
	a.append(ast)


func _on_game_toggle_spawn(s: bool) -> void:
	spawn = s
	if s:
		match State.planet:
			G.PLANET.EARTH:
				spawn_rate = 0.2
			G.PLANET.VENUS:
				spawn_rate = 0.05
			G.PLANET.MERCURY:
				spawn_rate = 0.01
	else:
		for child in %Asteroids.get_children():
			if child is Node2D && "is_asteroid" in child:
				child.queue_free()


func _on_rocket_dead() -> void:
	%MapAnimationPlayer.stop(true)
