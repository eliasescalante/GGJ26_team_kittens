extends Control

@onready var back_button = $MarginBack/Back

func _ready() -> void:
	back_button.grab_focus()


func _on_back_pressed() -> void:
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.6).timeout
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
	


func _on_credits_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
