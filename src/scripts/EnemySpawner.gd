extends Node2D

@export var enemy_crowd: PackedScene
@export var spawn_offset_x: float = 800.0 

var player: Node2D = null

@onready var top = $Top 
@onready var bottom = $Bottom 

var timer_crowd: float = 0.0

func _process(delta: float) -> void:
	if player == null:
		player = get_tree().current_scene.find_child("Player", true, false)
		if player == null:
			return

	timer_crowd += delta
	if timer_crowd >= 5.0:
		spawn_horde()
		timer_crowd = 0.0

func spawn_horde() -> void:
	if enemy_crowd == null: 
		print("DEBUG: Falta asignar la escena en el inspector")
		return
	
	var crowd = enemy_crowd.instantiate()
	
	var spawn_x = player.global_position.x + spawn_offset_x
	var mid_y = (top.global_position.y + bottom.global_position.y) / 2.0
	
	crowd.global_position = Vector2(spawn_x, mid_y)
	
	get_tree().current_scene.add_child(crowd)
	print("DEBUG: Horda spawneada en X:", spawn_x, " Y:", mid_y)
