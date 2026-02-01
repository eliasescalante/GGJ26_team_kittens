extends Node

signal lives_changed(new_lives)

enum Difficulty {
	EASY,
	NORMAL,
	HARDCORE
}

var difficulty = Difficulty.NORMAL

# ---------- BALL ----------
var ball_spawn_interval := 6.0
var ball_push_force := 180.0


# ---------- SPAWN ----------
var spawn_initial := 6.0
var spawn_min := 2.5

# ---------- CROWD ----------
var masking_time := 2.0



var masking_overlay: ColorRect = null
var master_volume := 1.0
var active_stealth_zones = 0
var player:Node = null
var player_lives: int = 4:
	set(value):
		player_lives = value
		lives_changed.emit(player_lives)
		print("Manager: Emitiendo nueva vida -> ", player_lives)

func lose_life():
	if player_lives <=0:
		print("perdi")
		return
		
	player_lives -= 1 
	print("Manager: Vida restada. Ahora tengo: ", player_lives)
	
	if player_lives >= 2:
		AudioManager.mask_1_play()
	elif player_lives == 1:
		AudioManager.mask_2_play()
	
	if player_lives <= 0:
		game_over()

func game_over():
	print("dificultad en:", Difficulty.NORMAL)
	set_difficulty(Difficulty.NORMAL)
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://src/scenes/levels/lose.tscn")

func win():
	print("dificultad en:", Difficulty.NORMAL )
	set_difficulty(Difficulty.NORMAL)
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://src/scenes/levels/curtains.tscn")
	
func restar_game():
	player_lives = 4
	AudioManager.respiracion_stop()

func show_masking():
	if not masking_overlay:
		print("Masking overlay todavía no registrado")
		return
	masking_overlay.visible = true
	var t = masking_overlay.create_tween()
	t.tween_property(masking_overlay, "modulate:a", 0.6, 0.25)

func hide_masking():
	if not masking_overlay:
		return
	var t = masking_overlay.create_tween()
	t.tween_property(masking_overlay, "modulate:a", 0.0, 0.25)
	t.finished.connect(func():
		masking_overlay.visible = false
	)


func set_difficulty(new_difficulty):
	difficulty = new_difficulty

	match difficulty:

		Difficulty.EASY:
			spawn_initial = 6.0
			spawn_min = 3
			masking_time = 1.0

			ball_spawn_interval = 7.0
			ball_push_force = 500.0

		Difficulty.NORMAL:
			spawn_initial = 5.0
			spawn_min = 2
			masking_time = 1.5

			ball_spawn_interval = 5.0
			ball_push_force = 700.0

		Difficulty.HARDCORE:
			spawn_initial = 4.0
			spawn_min = 1.2
			masking_time = 2.5

			ball_spawn_interval = 2.0
			ball_push_force = 1000.0


func set_master_volume(value):
	master_volume = value
	
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(master_volume)
	)
