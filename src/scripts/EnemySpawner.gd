extends Node2D

@export var enemy_crowd: PackedScene
@export var enemy_ball: PackedScene
@export var marker_top: Marker2D
@export var marker_bottom: Marker2D

@export var enemy_auto: PackedScene
@export var marker_calle: Marker2D
@export var auto_spawn_interval := 7.0

@export var ball_spawn_interval := 5.0

@export var initial_spawn_interval: float = 6.0 
@export var min_spawn_interval: float = 2.5      
@export var difficulty_step: float = 0.5         

var spawn_lock := false
var spawn_lock_timer := 0.0

var auto_timer := 0.0

var ball_timer := 0.0
var current_spawn_interval: float = 6.0
var timer_crowd: float = 0.0
var cycle: int = 0 
var player: CharacterBody2D = null

func _ready():
	initial_spawn_interval = GameManager.spawn_initial
	min_spawn_interval = GameManager.spawn_min
	current_spawn_interval = initial_spawn_interval
	ball_spawn_interval = GameManager.ball_spawn_interval

func _process(delta):
	if spawn_lock:
		spawn_lock_timer -= delta
		if spawn_lock_timer <= 0:
			spawn_lock = false
	
	if player == null:
		player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		return
	
	# SPAWN CROWD
	timer_crowd += delta
	if timer_crowd >= current_spawn_interval and not spawn_lock:
		timer_crowd = 0.0
		spawn_horde()
		lock_spawns(get_crowd_lock_time())

		if current_spawn_interval > min_spawn_interval:
			current_spawn_interval = max(
				min_spawn_interval,
				current_spawn_interval - difficulty_step
			)

	# SPAWN BALL
	ball_timer += delta
	if ball_timer >= ball_spawn_interval and not spawn_lock:
		ball_timer = 0.0
		spawn_ball()
		lock_spawns(get_ball_lock_time())
	
	# SPAWN AUTITO (Decorativo)
	auto_timer += delta
	if auto_timer >= auto_spawn_interval:
		auto_timer = 0.0
		spawn_auto_decorativo()

func spawn_auto_decorativo():
	if not enemy_auto or player == null or not marker_calle:
		return
	var instance = enemy_auto.instantiate()
	var offset = (get_viewport_rect().size.x / 2.0) + 350 
	# X: Posición del player + offset | Y: La posición global de tu Marker2D
	instance.global_position = Vector2( player.global_position.x + offset, marker_calle.global_position.y)
	# Lo agregas a la escena actual para que no se mueva pegado al spawner
	get_tree().current_scene.add_child(instance)

func spawn_ball():
	if not enemy_ball or player == null:
		return

	var instance = enemy_ball.instantiate()

	var offset = (get_viewport_rect().size.x / 2.0) + 200
	instance.global_position = Vector2(
		player.global_position.x + offset,
		get_ball_spawn_y()
	)
	
	instance.speed = 220.0
	get_tree().current_scene.add_child(instance)


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

func lock_spawns(time: float):
	spawn_lock = true
	spawn_lock_timer = time

func get_crowd_lock_time() -> float:
	match GameManager.difficulty:
		GameManager.Difficulty.EASY:
			return 1.5
		GameManager.Difficulty.NORMAL:
			return 1.1
		GameManager.Difficulty.HARDCORE:
			return 0.6
	return 1.0

func get_ball_lock_time() -> float:
	match GameManager.difficulty:
		GameManager.Difficulty.EASY:
			return 2.0
		GameManager.Difficulty.NORMAL:
			return 1.3
		GameManager.Difficulty.HARDCORE:
			return 0.7
	return 1.5

func get_ball_spawn_y() -> float:
	if not marker_top or not marker_bottom or player == null:
		return player.global_position.y

	var center_y = (marker_top.global_position.y + marker_bottom.global_position.y) * 0.5

	var extra_range := 90.0

	var min_y = center_y - extra_range
	var max_y = center_y + extra_range

	var lanes := [
		min_y,
		center_y,
		max_y
	]

	if GameManager.difficulty == GameManager.Difficulty.HARDCORE:
		return randf_range(min_y, max_y)

	return lanes.pick_random()
