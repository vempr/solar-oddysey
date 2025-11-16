extends Area2D


func _process(delta: float) -> void:
	position += delta * 800.0 * Vector2.RIGHT.rotated(rotation)
	if abs(position.x) > 10000.0 || abs(position.y) > 10000.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "CollideArea":
		area.get_parent().queue_free()
		State.budget += randf_range(1000, 1500)
		queue_free()
