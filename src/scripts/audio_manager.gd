extends Node

@onready var music_player = $music
@onready var menu = $MenuDemo
@onready var boton = $SFX/ButtonsMenu
@onready var end = $EndGameDemo
@onready var charco = $SFX/Charco
@onready var mask_1 = $SFX/MaskCrack1
@onready var mask_2 = $SFX/MaskCrack2
@onready var crowd = $SFX/NpcCrownd
@onready var respiracion = $SFX/Respiracion
@onready var mate = $SFX/MateEnCasa
@onready var lose = $LoseGameOver

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

func charco_play():
	if not charco.playing:
		charco.play()

func charco_stop():
	charco.stop()

func mask_1_play():
	if not mask_1.playing:
		mask_1.play()

func mask_2_play():
	if not mask_2.playing:
		mask_2.play()

func crowd_play():
	if not crowd.playing:
		crowd.play()

func mask_1_stop():
	mask_1.stop()

func mask_2_stop():
	mask_2.stop()

func crowd_stop():
	crowd.stop()
	
func respiracion_play():
	if not respiracion.playing:
		respiracion.play()

func respiracion_stop():
	respiracion.stop()

func mate_play():
	if not mate.playing:
		mate.play()

func mate_stop():
	mate.stop()
	

func lose_play():
	if not lose.playing:
		lose.play()

func lose_stop():
	lose.stop()
