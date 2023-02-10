extends OmniLight3D


func scale_brightness():
	omni_range = scale.length()

# Called when the node enters the scene tree for the first time.
func _ready():
	scale_brightness()

func _on_node_3d_property_list_changed():
	scale_brightness()
