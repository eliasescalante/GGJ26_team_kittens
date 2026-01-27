extends Node2D

# cargas de escenas
@export var enemy_normal: PackedScene
@export var enemy_fast: PackedScene
@export var enemy_heavy: PackedScene
@export var enemy_crowd: PackedScene

@export var spawn_offset_x := 600.0

var player: Node2D
@onready var top := $Top 
@onready var bottom := $Bottom 

# Tiempos de spawn independientes
var timer_normal := 0.0
var timer_crowd := 0.0

func _process(delta):
	if player == null:
		return
	
	# Manejo de enemigos comunes (Normal, Fast, Heavy) cada 1.5 - 2 segundos
	timer_normal += delta
	if timer_normal >= 0.5:
		spawn_specific_enemy(choose_random_basic())
		timer_normal = 0.0
		
	# Manejo del Crowd (cada 10 segundos)
	timer_crowd += delta
	if timer_crowd >= 15.0:
		spawn_specific_enemy(enemy_crowd)
		timer_crowd = 0.0

func choose_random_basic() -> PackedScene:
	# Elige aleatoriamente entre los 3 básicos
	var basic_enemies = [enemy_normal, enemy_fast, enemy_heavy]
	return basic_enemies.pick_random()

func spawn_specific_enemy(enemy_scene: PackedScene):
	if enemy_scene == null: return
	
	var enemy = enemy_scene.instantiate()
	var spawn_x := player.global_position.x + spawn_offset_x 
	var spawn_y := randf_range(top.global_position.y, bottom.global_position.y) 
	
	enemy.global_position = Vector2(spawn_x, spawn_y)
	get_tree().current_scene.add_child(enemy)
