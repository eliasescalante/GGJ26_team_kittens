extends Node

signal lives_changed(new_lives)

var player_lives: int = 4:
	set(value):
		player_lives = value
		lives_changed.emit(player_lives)
		print("Manager: Emitiendo nueva vida -> ", player_lives)

func lose_life():
	if player_lives <=0:
		print("perdi")
		return
	self.player_lives -= 1 
	print("Manager: Vida restada. Ahora tengo: ", player_lives)
	
	if player_lives <= 0:
		game_over()

func game_over():
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://src/scenes/levels/lose.tscn")
	print("game over, f")

func win():
	AudioManager.stop_music()
	get_tree().change_scene_to_file("res://src/scenes/levels/win.tscn")
	
func restar_game():
	player_lives = 4
