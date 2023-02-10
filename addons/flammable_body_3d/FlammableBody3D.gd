@tool
extends StaticBody3D

const BASE_TEMP = 69.0 # nice
const IGNITION_TEMP = 451.0

var temp = BASE_TEMP
var last_temp = BASE_TEMP
var on_fire = false
var cool_rate = 1.0
var base_heat_rate = (IGNITION_TEMP - BASE_TEMP) / 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("flammable", true)

func in_contact(power, delta):
	var temp_delta = base_heat_rate * power * delta
	temp += temp_delta
	if temp >= IGNITION_TEMP:
		print("WE ON FIRE")
		on_fire = true
	return temp_delta

func _process_physics(delta):
	if not on_fire:
		if temp == last_temp:
			temp -= cool_rate * delta
			temp = clampf(temp, BASE_TEMP, IGNITION_TEMP)
