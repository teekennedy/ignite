extends SpringArm3D

var mouse_sensitivity = 0.02

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event.is_action_pressed("mouse_escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rotation_degrees.y = wrapf(rotation_degrees.y - event.relative.x * mouse_sensitivity, 0.0, 360.0)
		rotation_degrees.x = clamp(rotation_degrees.x - event.relative.y * mouse_sensitivity, -90.0, 0.0)
		get_viewport().set_input_as_handled()
