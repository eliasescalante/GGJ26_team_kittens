extends Node2D

@export var enemy_crowd: PackedScene
@export var marker_top: Marker2D
@export var marker_bottom: Marker2D

@export var initial_spawn_interval: float = 6.0 
@export var min_spawn_interval: float = 2.5      
@export var difficulty_step: float = 0.5         

var current_spawn_interval: float = 6.0
var timer_crowd: float = 0.0
var cycle: int = 0 
var player: CharacterBody2D = null

func _ready():
	current_spawn_interval = initial_spawn_interval

func _process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		return

	timer_crowd += delta
	if timer_crowd >= current_spawn_interval:
		timer_crowd = 0.0
		spawn_horde()
		if current_spawn_interval > min_spawn_interval:
			current_spawn_interval = current_spawn_interval - difficulty_step
			if current_spawn_interval < min_spawn_interval:
				current_spawn_interval = min_spawn_interval

func spawn_horde():
	if not enemy_crowd or not marker_top or not marker_bottom:
		return
		
	var instance = enemy_crowd.instantiate()
	var offset = (get_viewport_rect().size.x / 2.0) + 150.0
	var p_pos = player.global_position
	
	if cycle == 0:
		instance.global_position = Vector2(p_pos.x + offset, marker_bottom.global_position.y)
		instance.speed = 150.0
	
	if cycle == 1:
		instance.global_position = Vector2(p_pos.x - offset, marker_top.global_position.y)
		instance.speed = -150.0
		
	if cycle == 2:
		instance.global_position = Vector2(p_pos.x + offset, marker_top.global_position.y)
		instance.speed = 150.0
		
	if cycle == 3:
		instance.global_position = Vector2(p_pos.x - offset, marker_bottom.global_position.y)
		instance.speed = -150.0

	cycle = cycle + 1
	if cycle > 3:
		cycle = 0
		
	get_tree().current_scene.add_child(instance)
	
	if instance.speed < 0:
		_flip_sprite(instance)

func _flip_sprite(node):
	await get_tree().process_frame
	var s = node.get_node_or_null("AnimatedSprite2D")
	if s:
		s.flip_h = true
