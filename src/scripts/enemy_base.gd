extends CharacterBody2D

@export var speed: float = 100.0
@export var damage: int = 1

@onready var anim = $AnimatedSprite2D
@onready var hitbox = $Hitbox

var player_ref: CharacterBody2D = null

func _ready():
	player_ref = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if anim:
		anim.play("walk")

func _physics_process(_delta):
	# Movimiento: si speed es positivo va a la izquierda, si es negativo a la derecha
	velocity.x = -speed
	move_and_slide()

	# Limpieza de seguridad si se alejan mucho
	if player_ref:
		var distancia = abs(global_position.x - player_ref.global_position.x)
		if distancia > 2500:
			queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("take_hit"):
		body.take_hit(damage)
