extends Control

@onready var anim = $AnimatedSprite2D
@onready var retry_button = $MarginBack/Back
func _ready() -> void:
	visible = true

	if not is_node_ready():
		await ready

	anim.play("idle")

	retry_button.grab_focus()
	AudioManager.lose_play()
	

func _on_back_pressed() -> void:
	AudioManager.crowd_stop()
	GameManager.restar_game()
	AudioManager.boton_menu_play()
	await get_tree().create_timer(0.9).timeout
	AudioManager.lose_stop()
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
