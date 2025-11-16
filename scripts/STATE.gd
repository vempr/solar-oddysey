extends Node

var completed := false
var planet: G.PLANET = G.PLANET.VENUS
var launched := false
var upgrades := {
	"fuel": 1,
	"stability": 1,
	"ammo": 1
} # max upgrade is 15


func reset() -> void:
	completed = false
	planet = G.PLANET.EARTH
	launched = false
	upgrades = {
		"fuel": 1,
		"stability": 1,
		"ammo": 1
	}
