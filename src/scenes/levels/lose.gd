extends Control
@onready var anim = $Animation
@onready var retry_button = $MarginBack/Back

func _ready() -> void:
	retry_button.grab_focus()
	anim.play("idle")
	AudioManager.lose_play()
	

func _on_back_pressed() -> void:
	AudioManager.crowd_stop()
	GameManager.restar_game()
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.9).timeout
	AudioManager.lose_stop()
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
