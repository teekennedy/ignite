@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("FlammableBody3D", "StaticBody3D", preload("FlammableBody3D.gd"), preload("icon.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("FlammableBody3D")
