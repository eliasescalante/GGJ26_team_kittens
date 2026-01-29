extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
	


func _on_credits_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
