extends Control

@onready var life_label = $LifeContainer/LifeCountLabel

func _ready():
	# Nos conectamos a la señal del GameManager
	GameManager.lives_changed.connect(_on_lives_changed)
	# Ponemos el valor inicial
	life_label.text = "Vidas: " + str(GameManager.player_lives)

func _on_lives_changed(new_lives):
	life_label.text = "Vidas: " + str(new_lives)
