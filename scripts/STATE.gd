extends Node

var completed := false
var planet: G.PLANET = G.PLANET.EARTH
var launched := false
var upgrades := {
	"fuel": 1,
	"stability": 1,
	"ammo": 1
} # max upgrade is 15

var budget := 0.0
var crowdfunding := 10000.00

var distance := 40_000_000.0
var fuel := 10.0
var stability := 100.00
var ammo := 0


func reset() -> void:
	completed = false
	planet = G.PLANET.EARTH
	launched = false
	upgrades = {
		"fuel": 1,
		"stability": 1,
		"ammo": 1
	}
	
	budget = 0.0
	crowdfunding = 10000.00
	
	distance = 40_000_000.0
	fuel = 10.0
	stability = 100.00
	ammo = 0


func get_time_upgraded(time: float) -> float:
	var factor = 1.0 / (1.0 + (upgrades.fuel - 1) * 0.12)
	return time * factor


func get_fuel_upgraded() -> float:
	var normalized = (upgrades.fuel - 1.0) / 14.0
	return 10.0 + sqrt(normalized) * 10.0


func upgrade_stability() -> void:
	var normalized = (upgrades.stability - 1.0) / 14.0
	stability = 100.0 + sqrt(normalized) * 50.0


func get_ammo() -> float:
	return 10.0 * pow(upgrades.ammo - 1.0, 1.26)
