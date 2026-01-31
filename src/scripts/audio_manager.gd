extends Node

@onready var music_player = $music
@onready var menu = $MenuDemo
@onready var boton = $SFX/ButtonsMenu
@onready var end = $EndGameDemo
@onready var charco = $SFX/Charco
@onready var mask_1 = $SFX/MaskCrack1
@onready var mask_2 = $SFX/MaskCrack2
@onready var crowd = $SFX/NpcCrownd

#-----------------------------------------------------------------------------
#MUSICA DEL JUEGO
#-----------------------------------------------------------------------------
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

func end_game_play():
	if not end.playing:
		end.play()
	
func end_game_stop():
	end.stop()

#-----------------------------------------------------------------------------
#SFX
#-----------------------------------------------------------------------------
func boton_menu_play():
	if not boton.playing:
		boton.play()

func boton_menu_stop():
	boton.stop()
