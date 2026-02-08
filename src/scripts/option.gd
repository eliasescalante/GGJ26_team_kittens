extends Control

@onready var volume_slider: HSlider = $HSlider
@onready var difficulty_button: OptionButton = $OptionButton
@onready var back_button: Button = $BackButton

func _ready():
	setup_difficulty()

	# ESPERAR 1 FRAME (clave para mobile web)
	await get_tree().process_frame

	if FileAccess.file_exists("user://settings.cfg"):
		load_settings()
	else:
		volume_slider.value = 0.5
		difficulty_button.select(1)
		GameManager.set_difficulty(GameManager.Difficulty.NORMAL)
		save_settings()

	volume_slider.grab_focus()

	volume_slider.value_changed.connect(_on_volume_changed)
	difficulty_button.item_selected.connect(_on_difficulty_selected)
	back_button.pressed.connect(_on_back_button_pressed)


func setup_difficulty():
	difficulty_button.clear()

	difficulty_button.add_item("Fácil", 0)
	difficulty_button.add_item("Normal", 1)
	difficulty_button.add_item("Hardcore", 2)

func _on_volume_changed(value):
	var db = lerp(-30.0, 6.0, value)
	AudioServer.set_bus_volume_db(0, db)
	save_settings()

func _on_difficulty_selected(index):
	GameManager.set_difficulty(index)
	print("dificultad seleccionada:", index)
	save_settings()


func _unhandled_input(event):

	if event.is_action_pressed("ui_cancel"):
		_on_back_button_pressed()

	if volume_slider.has_focus():

		if event.is_action_pressed("ui_left"):
			volume_slider.value -= 0.05

		if event.is_action_pressed("ui_right"):
			volume_slider.value += 0.05

	if difficulty_button.has_focus():

		if event.is_action_pressed("ui_left"):
			var new_index = max(0, difficulty_button.selected - 1)
			difficulty_button.select(new_index)
			_on_difficulty_selected(new_index)

		if event.is_action_pressed("ui_right"):
			var new_index = min(difficulty_button.item_count - 1, difficulty_button.selected + 1)
			difficulty_button.select(new_index)
			_on_difficulty_selected(new_index)

func save_settings():
	var config = ConfigFile.new()

	config.set_value("audio", "volume", volume_slider.value)
	config.save("user://settings.cfg")

func load_settings():
	var config = ConfigFile.new()

	if config.load("user://settings.cfg") != OK:
		return

	var vol = config.get_value("audio", "volume", 0.5)
	volume_slider.value = vol

func _on_back_button_pressed() -> void:
	AudioManager.boton_menu_play()
	get_tree().change_scene_to_file("res://src/scenes/main_screens/main_menu/main_menu.tscn")
