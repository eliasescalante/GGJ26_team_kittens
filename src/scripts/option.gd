extends Control

@onready var volume_slider: HSlider = $HSlider
@onready var difficulty_button: OptionButton = $OptionButton
@onready var back_button: Button = $BackButton


func _ready():
	setup_difficulty()

	# Esperar 1 frame (importante para web/mobile)
	await get_tree().process_frame

	# 🎯 valores por defecto SIEMPRE
	volume_slider.value = 0.5
	difficulty_button.select(GameManager.Difficulty.NORMAL)

	GameManager.set_difficulty(GameManager.Difficulty.NORMAL)
	GameManager.set_master_volume(0.5)

	volume_slider.grab_focus()

	volume_slider.value_changed.connect(_on_volume_changed)
	difficulty_button.item_selected.connect(_on_difficulty_selected)
	back_button.pressed.connect(_on_back_button_pressed)


func setup_difficulty():
	difficulty_button.clear()

	difficulty_button.add_item("Fácil", GameManager.Difficulty.EASY)
	difficulty_button.add_item("Normal", GameManager.Difficulty.NORMAL)
	difficulty_button.add_item("Hardcore", GameManager.Difficulty.HARDCORE)


func _on_volume_changed(value):
	GameManager.set_master_volume(value)


func _on_difficulty_selected(index):
	GameManager.set_difficulty(index)
	print("dificultad seleccionada:", index)


func _unhandled_input(event):

	if event.is_action_pressed("ui_cancel"):
		_on_back_button_pressed()

	# 🎮 control del slider con teclado / gamepad
	if volume_slider.has_focus():

		if event.is_action_pressed("ui_left"):
			volume_slider.value -= 0.05

		if event.is_action_pressed("ui_right"):
			volume_slider.value += 0.05

	# 🎮 control del OptionButton con teclado / gamepad
	if difficulty_button.has_focus():

		if event.is_action_pressed("ui_left"):
			var new_index = max(0, difficulty_button.selected - 1)
			difficulty_button.select(new_index)
			_on_difficulty_selected(new_index)

		if event.is_action_pressed("ui_right"):
			var new_index = min(difficulty_button.item_count - 1, difficulty_button.selected + 1)
			difficulty_button.select(new_index)
			_on_difficulty_selected(new_index)


func _on_back_button_pressed() -> void:
	AudioManager.boton_menu_play()
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
