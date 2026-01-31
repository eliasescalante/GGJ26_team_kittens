extends "res://src/scripts/enemy_base.gd"

var masking_time_required = 2.0
var current_masking_time = 0.0
var is_player_inside = false
var is_masking_complete = false

func _ready():
	# Buscamos al jugador manualmente para asegurar la referencia
	player_ref = get_tree().get_first_node_in_group("player")
	
	# Sonido inicial con el AudioManager
	AudioManager.crowd_play()
	# Usamos un timer para detenerlo a los 2 segundos
	#get_tree().create_timer(2.0).timeout.connect(func(): AudioManager.crowd_stop())
	
	# para que la multitud NO te mate al solo tocarla, sino por el masking
	if hitbox.body_entered.is_connected(_on_hitbox_body_entered):
		hitbox.body_entered.disconnect(_on_hitbox_body_entered)
	
	# Conectamos las señales propias de esta horda
	hitbox.body_entered.connect(_on_masking_started)
	hitbox.body_exited.connect(_on_masking_ended)
	
	if anim:
		anim.play("crowd")

func _process(delta):
	# Si el jugador está dentro y aún no terminó el proceso
	if is_player_inside and not is_masking_complete:
		# Forzamos la visibilidad de la barra
		if not $SaturationBar.visible:
			$SaturationBar.max_value = masking_time_required
			$SaturationBar.show()
		
		# Sumamos tiempo
		current_masking_time = current_masking_time + delta
		$SaturationBar.value = current_masking_time
		
		# Efecto visual de "camuflaje"
		if player_ref:
			player_ref.modulate.a = 0.4
		
		# Si completamos el tiempo requerido
		if current_masking_time >= masking_time_required:
			_on_masking_success()
			AudioManager.crowd_stop()

func _on_masking_success():
	is_masking_complete = true
	# Desactivamos colisiones para que no cuente más
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	if player_ref:
		player_ref.modulate.a = 1.0 
	
	# La horda acelera al irse
	speed = speed * 2.0
	
	# Desvanecimiento y borrado
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.0)
	tw.finished.connect(queue_free)

func _on_masking_started(body):
	if body.is_in_group("player"):
		is_player_inside = true
		current_masking_time = 0.0

func _on_masking_ended(body):
	if body.is_in_group("player"):
		# Si sale antes de tiempo, ¡DAÑO!
		if not is_masking_complete:
			if body.has_method("take_hit"):
				body.take_hit(damage)
		
		is_player_inside = false
		$SaturationBar.hide()
		
		if player_ref:
			player_ref.modulate.a = 1.0
