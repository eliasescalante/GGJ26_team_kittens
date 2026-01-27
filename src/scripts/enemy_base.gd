extends CharacterBody2D

@export var speed = 100
@export var damage = 1

@onready var anim = $AnimatedSprite2D
@onready var hitbox = $Hitbox

func _ready():
	if anim:
		anim.play("walk")
	if hitbox:
		hitbox.body_entered.connect(_on_hitbox_body_entered)

func _physics_process(_delta):
	velocity.x = -speed
	move_and_slide()

	if global_position.x < -200:
		queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("take_hit"):
		body.take_hit(damage)
