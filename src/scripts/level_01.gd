extends Node2D

@onready var player := $Player
@onready var spawner := $SpawnArea
@onready var win := $Limits/Area2D

func _ready():
	AudioManager.menu_stop()
	AudioManager.play_music()
	spawner.player = player

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.win()
