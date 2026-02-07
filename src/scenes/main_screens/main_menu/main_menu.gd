extends Control

func _ready() -> void:
	$%AnimatedSprite2D.play("default")
	AudioManager.menu_play()
	
	if OS.get_name() == "WEB" or OS.has_feature("web_android"):
		$HBoxContainer/Margin/PanelContainer/VBox/Exit.hide()
	$HBoxContainer/Margin/PanelContainer/VBox/Start.grab_focus()

func _on_start_pressed() -> void:
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.9).timeout
	get_tree().change_scene_to_file("res://src/scenes/cinematic/cinematic.tscn")


func _on_credits_pressed() -> void:
	AudioManager.boton_menu_play()
	get_tree().change_scene_to_file("res://src/scenes/main_screens/credits/credits.tscn")


func _on_exit_pressed() -> void:
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.9).timeout
	get_tree().quit()


func _on_button_pressed() -> void:
	AudioManager.boton_menu_play()
	get_tree().change_scene_to_file("res://src/scenes/ui/option.tscn")
