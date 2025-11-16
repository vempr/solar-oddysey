extends Control

var s0 := 0.0
var d0 := 0.0
var t0 := 0.0
var t := 0.0


func _ready() -> void:
	%MilestoneVenus/Deactivated.visible = true
	%MilestoneMercury/Deactivated.visible = true
	%MilestoneSun/Deactivated.visible = true
	
	match State.planet:
		G.PLANET.VENUS:
			%MilestoneVenus/Deactivated.visible = false
		G.PLANET.MERCURY:
			%MilestoneVenus/Deactivated.visible = false
			%MilestoneMercury/Deactivated.visible = false
	
	update_state()
	update_launch_data()


func _process(delta: float) -> void:
	%Budget.text = "Budget: " + G.to_money(State.budget) + "$"

	if t < t0:
		t += delta
		if t > t0:
			t = t0
		
		State.distance = d0 - d0*t / t0
		State.fuel = s0 - s0*t / t0
		
		update_launch_data()


func _on_launch_button_pressed() -> void:
	%Launch/Deactivated.visible = true
	%LaunchButton.visible = false


func _on_game_activate_gui() -> void:
	%Launch/Deactivated.visible = false
	%LaunchButton.visible = true
	
	if State.completed:
		%Launch/Label.text = "Play Again"
		%MilestoneSun/Deactivated.visible = false
	
	match State.planet:
		G.PLANET.VENUS:
			%MilestoneVenus/Deactivated.visible = false
		G.PLANET.MERCURY:
			%MilestoneMercury/Deactivated.visible = false
	
	update_state()
	update_launch_data()
	if State.completed:
		%LaunchDataC/Label.text = ""


func _on_game_countdown(time: float) -> void:
	update_state()
	t0 = time
	t = 0.0


func update_state() -> void:
	State.distance = G.distance[State.planet]
	State.fuel = State.get_fuel_upgraded()
	State.upgrade_stability()
	
	d0 = State.distance
	s0 = State.fuel


func update_launch_data() -> void:
	%LaunchDataC/Label.text = "Distance: " + G.to_sci_notation(State.distance)
	%LaunchDataC/Label.text += "\nFuel: " + str(snapped(State.fuel, 0.1)) + "kL"
	%LaunchDataC/Label.text += "\nStability: " + str(snapped(State.stability, 0.01)) + "%"
	%LaunchDataC/Label.text += "\nAmmo: " + str(State.ammo)


func _on_rocket_dead() -> void:
	t = t0
