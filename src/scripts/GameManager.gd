extends Node

signal lives_changed(new_lives)

var player_lives: int = 3:
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
	print("game over, f como dicen los chicos")
