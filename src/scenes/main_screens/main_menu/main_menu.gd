extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/cinematic/cinematic.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main_screens/credits/credits.tscn")
