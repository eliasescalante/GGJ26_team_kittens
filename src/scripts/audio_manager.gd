extends Node

@onready var music_player = $music
@onready var menu = $MenuDemo
@onready var boton = $ButtonsMenu
@onready var end = $EndGameDemo

#para la musica del nivel
func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()

#para la musica del menu
func menu_play():
	if not menu.playing:
		menu.play()

func menu_stop():
	menu.stop()

# para la musica del lose
func end_game_play():
	if not end.playing:
		end.play()
	
func end_game_stop():
	end.stop()


#SFX
func boton_menu_play():
	if not boton.playing:
		boton.play()

func boton_menu_stop():
	boton.stop()
