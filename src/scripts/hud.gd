extends Control

@onready var life_label = $LifeContainer/LifeCountLabel
@onready var sprite = $LifeContainer/AnimatedSprite2D
@onready var overlay := $ColorRect2

var vidas_actuales = GameManager.player_lives

func _ready():
	overlay.visible = false
	overlay.modulate.a = 0.0
	GameManager.masking_overlay = overlay
	# Nos conectamos a la señal del GameManager
	GameManager.lives_changed.connect(_on_lives_changed)
	_on_lives_changed(vidas_actuales)
	# Ponemos el valor inicial
	

func _on_lives_changed(valor):
	if valor == 4:
		sprite.play("sano")
	if valor == 3:
		sprite.play("medio")
	if valor == 2:
		sprite.play("casi_muerto")
	if valor == 1:
		sprite.play("muerto")
