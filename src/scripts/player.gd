extends CharacterBody2D

@export var speed := 250.0 # Un poco más rápido para esquivar mejor

@onready var anim := $AnimatedSprite2D

func _physics_process(_delta):
	# Obtenemos entrada para ambos ejes
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input_dir * speed
	move_and_slide()

	update_animation(input_dir.x)

func update_animation(dir_x: float):
	if dir_x == 0:
		if velocity.y == 0:
			anim.play("idle")
		else:
			anim.play("walk_right") # O una animación de caminar vertical si tienes
	else:
		anim.play("walk_right")
		anim.flip_h = dir_x < 0

func take_hit(amount):
	print("¡Auch! Daño recibido: ", amount)
	# Aquí podrías restar vida o disparar una señal al HUD
