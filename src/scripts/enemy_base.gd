extends CharacterBody2D

@export var speed := 100
@export var damage := 1

@onready var anim := $AnimatedSprite2D
@onready var hitbox := $Hitbox

func _ready():
	anim.play("walk")
	hitbox.body_entered.connect(_on_hitbox_body_entered)

func _physics_process(delta):
	velocity.x = -speed
	move_and_slide()

	if global_position.x < get_viewport_rect().position.x - 200:
		queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("take_hit"):
		body.take_hit(damage)
		print("me hirieron")
