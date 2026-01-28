extends Node2D

@onready var player := $Player
@onready var spawner := $SpawnArea

func _ready():
	AudioManager.play_music()
	spawner.player = player
