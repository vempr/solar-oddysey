extends Control

var MIN_SPEED := 300.0
var MAX_SPEED := 400.0

var is_asteroid := true
var velocity: Vector2
var rot_dir: int
var rot_deg: float
var can_collect := false


func _ready() -> void:
	rotation = deg_to_rad(randf_range(0.0, 360.0))
	var direction = Vector2(1.0, randf_range(-0.5, 0.5)).normalized()
	var speed = randf_range(MIN_SPEED, MAX_SPEED)
	velocity = direction * speed
	
	if randi_range(0, 1):
		rot_dir = 1
	else:
		rot_dir = -1
	rot_deg = randf_range(0.01, 0.3)


func _process(delta: float) -> void:
	position += velocity * delta
	rotation += rot_deg * rot_dir


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot") || event.is_action_pressed("collect")) && can_collect:
		State.budget += randf_range(10000, 15000)
		queue_free()


func _on_mouse_entered() -> void:
	can_collect = true


func _on_mouse_exited() -> void:
	can_collect = false
