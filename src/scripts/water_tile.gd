extends Area2D

@onready var anim := $AnimatedSprite2D
@export var slow_factor: float = 0.5

const BODY_SPEED := 200.0

var normal_speed: float = 0.0


func _ready():
	anim.play("idle")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		normal_speed = body.speed
		body.speed = normal_speed * slow_factor
		body.modulate = Color(0.7, 0.8, 1.0)
		anim.play("splash")
		AudioManager.charco_play()

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.speed = BODY_SPEED
		body.modulate = Color(1, 1, 1)
		anim.play("idle")
		AudioManager.charco_stop()
