extends Control


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_launch_button_pressed() -> void:
	%Launch/Deactivated.visible = true
	%LaunchButton.visible = false


func _on_game_activate_gui() -> void:
	%Launch/Deactivated.visible = false
	%LaunchButton.visible = true
	
	if State.completed:
		%Launch/Label.text = "Play Again"
