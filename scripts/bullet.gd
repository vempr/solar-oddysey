extends Area2D


func _process(delta: float) -> void:
	position += delta * 800.0 * Vector2.RIGHT.rotated(rotation)
	if abs(position.x) > 1000.0 || abs(position.y) > 1000.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "CollideArea":
		G.kaboom()
		area.get_parent().queue_free()
		State.budget += randf_range(7000, 10000)
		queue_free()
