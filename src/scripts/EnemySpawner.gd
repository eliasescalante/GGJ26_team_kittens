extends Node2D

@export var enemy_crowd: PackedScene

# --- CONFIGURACIÓN DE DIFICULTAD ---
@export var initial_spawn_interval: float = 8.0 
@export var min_spawn_interval: float = 2      
@export var difficulty_step: float = 0.5         

var current_spawn_interval: float
var timer_crowd: float = 0.0
var cycle: int = 0 
var player: CharacterBody2D = null

@onready var top = $Top 
@onready var bottom = $Bottom 

func _ready():
	# Inicializamos el tiempo actual con el tiempo base
	current_spawn_interval = initial_spawn_interval
	print("Dificultad Inicial: ", current_spawn_interval, "s")

func _process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player") as CharacterBody2D
		return

	timer_crowd += delta
	
	if timer_crowd >= current_spawn_interval:
		spawn_horde()
		timer_crowd = 0.0
		# Aumentar dificultad
		increase_difficulty()

func increase_difficulty():
	if current_spawn_interval > min_spawn_interval:
		current_spawn_interval -= difficulty_step
		# Aseguramos no bajar del mínimo
		current_spawn_interval = max(current_spawn_interval, min_spawn_interval)
		print("¡Dificultad aumentada! Nuevo intervalo: ", current_spawn_interval, "s")

func spawn_horde():
	if not enemy_crowd: return
	
	var instance = enemy_crowd.instantiate()
	var screen_offset = (get_viewport_rect().size.x / 2.0) + 150.0
	
	var spawn_pos = Vector2.ZERO
	var current_speed = 0.0
	
	# Lógica coordinada de posiciones (Derecha/Izquierda + Arriba/Abajo)
	match cycle:
		0: # Derecha - Abajo
			spawn_pos = Vector2(player.global_position.x + screen_offset, bottom.global_position.y)
			current_speed = 150.0
		1: # Izquierda - Arriba
			spawn_pos = Vector2(player.global_position.x - screen_offset, top.global_position.y)
			current_speed = -150.0
		2: # Derecha - Arriba
			spawn_pos = Vector2(player.global_position.x + screen_offset, top.global_position.y)
			current_speed = 150.0
		3: # Izquierda - Abajo
			spawn_pos = Vector2(player.global_position.x - screen_offset, bottom.global_position.y)
			current_speed = -150.0

	instance.global_position = spawn_pos
	instance.speed = current_speed
	
	cycle = (cycle + 1) % 4
	get_tree().current_scene.add_child(instance)
	
	# Voltear sprite si viene de atrás
	if instance.speed < 0:
		await get_tree().process_frame
		var anim_sprite = instance.get_node_or_null("AnimatedSprite2D")
		if anim_sprite:
			anim_sprite.flip_h = true
