extends Control


func _on_back_pressed() -> void:
	GameManager.restar_game()
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.9).timeout
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
