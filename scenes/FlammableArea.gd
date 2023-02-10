extends Area3D

const BASE_TEMP = 69.0 # nice
const IGNITION_TEMP = 451.0

var temp = BASE_TEMP
var last_temp = BASE_TEMP
var on_fire = false
var cool_rate = 1.0
var contact_body = null
var fire_bonus = cool_rate * 10
var base_heat_rate = (IGNITION_TEMP - BASE_TEMP) / 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("flammable", true)

func in_contact(power, delta):
	print("Contact!", power, delta)
	var temp_delta = base_heat_rate * power * delta
	temp += temp_delta
	if temp >= IGNITION_TEMP:
		print("WE ON FIRE")
		temp += fire_bonus
	return temp_delta

func _process(delta):
	if contact_body != null:
		in_contact(contact_body.power, delta)
	temp -= cool_rate * delta
	temp = clampf(temp, BASE_TEMP, IGNITION_TEMP)
	if temp <= BASE_TEMP:
		print("cooled off")
		set_process(false)


func _on_body_entered(body):
	print("on body entered: ", body)
	contact_body = body
	set_process(true)


func _on_body_exited(_body):
	print("on body exited")
	contact_body = null
