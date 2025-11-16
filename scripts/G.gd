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


func to_money(x: float) -> String:
	var rounded = snapped(x, 0.01)
	var parts := str(rounded).split(".")
	
	var int_str := parts[0]
	var dec_str := parts[1] if parts.size() > 1 else ""

	var formatted_int := ""
	var count := 0

	for i in range(int_str.length() - 1, -1, -1):
		formatted_int = int_str[i] + formatted_int
		count += 1
		
		if count == 3 and i != 0:
			formatted_int = "," + formatted_int
			count = 0

	if dec_str.length() < 2:
		dec_str += "0".repeat(2 - dec_str.length())
	else:
		dec_str = dec_str.substr(0, 2)

	return formatted_int + "." + dec_str
