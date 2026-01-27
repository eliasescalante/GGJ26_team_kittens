extends Node2D

@onready var player := $Player
@onready var spawner := $SpawnArea

func _ready():
	spawner.player = player
