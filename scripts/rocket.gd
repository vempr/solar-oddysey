extends Node2D

signal dead
@onready var BulletScene := preload("res://scenes/bullet.tscn")


func _process(_delta: float) -> void:
	%Gun.look_at(get_global_mouse_position())
	%Gun.rotation += deg_to_rad(90)
	
	if Input.is_action_pressed("shoot"):
		var b = BulletScene.instantiate()
		b.rotation = %Gun.rotation - deg_to_rad(90)
		b.global_position = %Gun.global_position
		get_parent().add_child(b)


func hide_all() -> void:
	%Ship10.visible = false
	%Ship20.visible = false
	%Ship30.visible = false
	%Ship40.visible = false
	%Ship50.visible = false
	%Ship60.visible = false
	%Ship70.visible = false
	%Ship80.visible = false
	%Ship90.visible = false
	%Ship100.visible = false


func _on_hit_area_area_entered(area: Area2D) -> void:
	State.stability -= randf_range(5.0, 8.0)
	area.get_parent().queue_free()
	
	%Ship10.visible = false
	%Ship20.visible = false
	%Ship30.visible = false
	%Ship40.visible = false
	%Ship50.visible = false
	%Ship60.visible = false
	%Ship70.visible = false
	%Ship80.visible = false
	%Ship90.visible = false
	%Ship100.visible = false
	
	var s = State.stability
	if s >= 90.0:
		%Ship100.visible = true
	elif s >= 80.0:
		%Ship90.visible = true
	elif s >= 70.0:
		%Ship80.visible = true
	elif s >= 60.0:
		%Ship70.visible = true
	elif s >= 50.0:
		%Ship60.visible = true
	elif s >= 40.0:
		%Ship50.visible = true
	elif s >= 30.0:
		%Ship40.visible = true
	elif s >= 20.0:
		%Ship30.visible = true
	elif s >= 10.0:
		%Ship20.visible = true
	elif s >= 0.0:
		%Ship10.visible = true
	else:
		State.stability = 0.0
		dead.emit()
		
		%Ship.visible = false
		%Gun.visible = false
		%HitArea.set_deferred("monitoring", false)
		%HitArea.set_deferred("monitorable", false)
		
		%BlueFire.visible = false
		%OrangeFire.visible = false
		%WhiteFire.visible = false
		
		%Explode.visible = true
		%Explode.play("boom")


func _on_explode_animation_finished() -> void:
	if State.completed:
		return
	var t = get_tree()
	await t.create_timer(1.0).timeout
	get_tree().reload_current_scene()
