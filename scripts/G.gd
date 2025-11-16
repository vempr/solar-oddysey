extends Node

enum PLANET { EARTH, VENUS, MERCURY }

var distance := {
	PLANET.EARTH: 40_000_000,
	PLANET.VENUS: 50_000_000,
	PLANET.MERCURY: 60_000_000,
}


func to_sci_notation(x: float, threshold := 10_000) -> String:
	if x < threshold:
		return str(int(x))
	
	var exponent = floor(log(x) / log(10))
	var base = x / pow(10, exponent)
	
	return str(snapped(base, 0.1), "e", int(exponent))
