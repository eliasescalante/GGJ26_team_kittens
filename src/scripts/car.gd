extends Node2D

@export var velocidad = 350.0
@onready var sprite = $AnimatedSprite2D # Asegúrate de que se llame así

func _ready() -> void:
	sprite.play("default") # Inicia la animación de las rueditas o luces
	AudioManager.autito_play()

func _process(delta: float) -> void:
	# Movimiento constante hacia la izquierda (ajusta a += si va a la derecha)
	position.x -= velocidad * delta
	
	# Si se aleja mucho del centro de la pantalla, se elimina para no gastar recursos
	# (Usamos 1200 como margen de seguridad)
	var player = get_tree().get_first_node_in_group("player")
	if GameManager.player and global_position.x < GameManager.player.global_position.x - 1000:
		AudioManager.autito_stop()
		queue_free()
