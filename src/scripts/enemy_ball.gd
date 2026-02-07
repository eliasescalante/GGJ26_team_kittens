extends "res://src/scripts/enemy_base.gd"

@export var push_force: float = 700
@export var destroy_on_hit := false

var has_hit := false


func _ready():
	player_ref = get_tree().get_first_node_in_group("player")

	if anim:
		anim.play("ball")

	if hitbox.body_entered.is_connected(_on_hitbox_body_entered):
		hitbox.body_entered.disconnect(_on_hitbox_body_entered)

	hitbox.body_entered.connect(_on_ball_hit)


func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta


func _on_ball_hit(body: Node) -> void:
	if has_hit:
		return

	if not body.is_in_group("player"):
		return

	has_hit = true

	var dir: Vector2 = (body.global_position - global_position).normalized()

	# Golpe corto (impulso)
	if body.has_method("apply_hit_impulse"):
		body.apply_hit_impulse(dir * push_force)

	# Feedback visual SIN daño
	if body.has_method("play_hit_feedback"):
		body.play_hit_feedback()

	hitbox.monitoring = false
	hitbox.monitorable = false

	# Desaparece SIEMPRE después de golpear
	queue_free()
