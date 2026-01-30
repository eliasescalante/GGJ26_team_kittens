extends CharacterBody2D

@export var speed = 200
@export var shake_intensity = 10.0
@export var shake_duration = 0.3

@onready var anim = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
@onready var camera = $Camera2D

var shake_timer = 0.0

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * speed
	move_and_slide()

	update_animation(input_dir.x)

	if shake_timer > 0:
		shake_timer = shake_timer - delta
		var rx = randf_range(-1.0, 1.0) * shake_intensity
		var ry = randf_range(-1.0, 1.0) * shake_intensity
		camera.offset = Vector2(rx, ry)
	else:
		camera.offset = Vector2.ZERO

func update_animation(dir_x):
	if dir_x == 0:
		if velocity.y == 0:
			anim.play("idle")
		else:
			anim.play("walk_right")
	else:
		anim.play("walk_right")
		if dir_x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false

func take_hit(amount):
	GameManager.lose_life()
	
	shake_timer = shake_duration
	
	if animation:
		animation.play("hit_flash")
		await animation.animation_finished
		animation.play("RESET")
