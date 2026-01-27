extends CharacterBody2D

@export var speed := 250.0

@onready var anim := $AnimatedSprite2D
@onready var animation := $AnimationPlayer


func _ready() -> void:
	add_to_group("player")
	AudioManager.play_music()

func _physics_process(_delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input_dir * speed
	move_and_slide()

	update_animation(input_dir.x)

func update_animation(dir_x: float):
	if dir_x == 0:
		if velocity.y == 0:
			anim.play("idle")
		else:
			anim.play("walk_right")
	else:
		anim.play("walk_right")
		anim.flip_h = dir_x < 0

func take_hit(amount):
	print("¡Auch! Daño recibido: ", amount)
	GameManager.lose_life()
	animation.play("hit_flash")
	await animation.animation_finished
	animation.play("RESET")
	
