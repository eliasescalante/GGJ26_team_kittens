extends CharacterBody2D

# -------------------------
# MOVIMIENTO
# -------------------------
@export var speed: float = 200.0

# -------------------------
# CAMERA SHAKE
# -------------------------
@export var shake_intensity: float = 10.0
@export var shake_duration: float = 0.3

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D

var shake_timer: float = 0.0

var hit_impulse: Vector2 = Vector2.ZERO
var hit_timer: float = 0.0
const HIT_DURATION := 0.12

func _ready():
	GameManager.player = self
	add_to_group("player")

func _physics_process(delta: float) -> void:

	var input_dir := Vector2.ZERO

	if hit_timer > 0.0:
		hit_timer -= delta
		velocity = hit_impulse
	else:
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_dir * speed

	move_and_slide()
	update_animation(input_dir.x)


func _process(delta: float) -> void:
	if shake_timer > 0.0:
		shake_timer -= delta
		var rx := randf_range(-1.0, 1.0) * shake_intensity
		var ry := randf_range(-1.0, 1.0) * shake_intensity
		camera.offset = Vector2(rx, ry)
	else:
		camera.offset = Vector2.ZERO

func apply_hit_impulse(impulse: Vector2) -> void:
	hit_impulse = impulse
	hit_timer = HIT_DURATION
	shake_timer = shake_duration

func take_hit(amount):
	GameManager.lose_life()

	shake_timer = shake_duration

	if animation:
		animation.play("hit_flash")
		await animation.animation_finished
		animation.play("RESET")


func update_animation(dir_x):
	var vida = GameManager.player_lives
	var current_anim = ""

	# idle
	if dir_x == 0 and velocity.y == 0:
		if vida == 4:
			current_anim = "idle"
		elif vida == 3:
			current_anim = "idle_1"
		elif vida == 2:
			current_anim = "idle_2"
		elif vida == 1:
			current_anim = "idle_3"
	else:
		if vida == 4:
			current_anim = "walk_right"
		elif vida == 3:
			current_anim = "walk_right_d_1"
		elif vida == 2:
			current_anim = "walk_right_d_2"
		elif vida == 1:
			current_anim = "walk_right_d_3"

	if current_anim != "":
		anim.play(current_anim)

	if dir_x < 0:
		anim.flip_h = true
	elif dir_x > 0:
		anim.flip_h = false

func play_hit_feedback():
	shake_timer = shake_duration

	if animation:
		animation.play("hit_flash")
		await animation.animation_finished
		animation.play("RESET")
