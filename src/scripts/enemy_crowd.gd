extends "res://src/scripts/enemy_base.gd"

var speed_normal = 150.0
var speed_slow = 70.0
var masking_time_required = 2.0 

var current_masking_time = 0.0
var is_player_inside = false
var player_ref = null
var is_masking_complete = false

func _ready():
	super._ready()
	if hitbox.body_entered.is_connected(_on_hitbox_body_entered):
		hitbox.body_entered.disconnect(_on_hitbox_body_entered)
	
	hitbox.body_entered.connect(_on_masking_started)
	hitbox.body_exited.connect(_on_masking_ended)
	
	speed = speed_normal
	if anim:
		anim.play("crowd")

func _process(delta):
	velocity.x = -speed
	move_and_slide()

	if is_player_inside and not is_masking_complete:
		current_masking_time += delta
		
		if player_ref:
			player_ref.modulate.a = 0.4
		
		if current_masking_time >= masking_time_required:
			_on_masking_success()

func _on_masking_success():
	is_masking_complete = true
	print(">>> 2 SEGUNDOS CUMPLIDOS: Mimetización exitosa")
	
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	if player_ref:
		player_ref.modulate.a = 1.0 
	
	speed = speed_normal + 100
	
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.0)
	tw.finished.connect(queue_free)

func _on_masking_started(body):
	if body.name == "Player" or body.is_in_group("player"):
		is_player_inside = true
		player_ref = body
		speed = speed_slow 
		current_masking_time = 0.0
		print(">>> ENTRÉ EN LA ZONA: Iniciando conteo de 2 segundos")

func _on_masking_ended(body):
	if body == player_ref:
		if not is_masking_complete:
			print("DAÑO: Saliste del área antes de tiempo")
			player_ref.take_hit(damage)
		
		is_player_inside = false
		if player_ref:
			player_ref.modulate.a = 1.0
		speed = speed_normal
