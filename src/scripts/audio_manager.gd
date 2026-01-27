extends Node

@onready var music_player = $music

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()
