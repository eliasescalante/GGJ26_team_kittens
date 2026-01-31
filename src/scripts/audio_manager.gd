extends Node

@onready var music_player = $music
@onready var menu = $MenuDemo
@onready var boton = $ButtonsMenu

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()
	
func menu_play():
	if not menu.playing:
		menu.play()

func menu_stop():
	menu.stop()

func boton_menu_play():
	if not boton.playing:
		boton.play()

func boton_menu_stop():
	boton.stop()
