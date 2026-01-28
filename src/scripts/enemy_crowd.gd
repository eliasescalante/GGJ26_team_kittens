extends "res://src/scripts/enemy_base.gd"

var masking_time_required: float = 2.0 
var current_masking_time: float = 0.0
var is_player_inside: bool = false
var is_masking_complete: bool = false

func _ready() -> void:
	super._ready()
	if hitbox.body_entered.is_connected(_on_hitbox_body_entered):
		hitbox.body_entered.disconnect(_on_hitbox_body_entered)
	
	hitbox.body_entered.connect(_on_masking_started)
	hitbox.body_exited.connect(_on_masking_ended)
	
	if anim:
		anim.play("crowd")

func _process(delta: float) -> void:
	if is_player_inside and not is_masking_complete:
		current_masking_time += delta
		
		if player_ref:
			player_ref.modulate.a = 0.4
		
		if current_masking_time >= masking_time_required:
			_on_masking_success()

func _on_masking_success() -> void:
	is_masking_complete = true
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	if player_ref:
		player_ref.modulate.a = 1.0 
	
	speed = speed * 2.0
	
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.0)
	tw.finished.connect(queue_free)

func _on_masking_started(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_inside = true
		speed = speed * 0.5 
		current_masking_time = 0.0

func _on_masking_ended(body: Node2D) -> void:
	if body == player_ref:
		if not is_masking_complete:
			player_ref.take_hit(damage)
		
		is_player_inside = false
		if player_ref:
			player_ref.modulate.a = 1.0
		speed = speed / 0.5
