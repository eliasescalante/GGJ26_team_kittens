extends "res://src/scripts/enemy_base.gd"

@onready var animation := $AnimatedSprite2D

func _ready():
	super._ready()
	animation.play("default")
	animation.flip_h = true
	speed = 70
	damage = 2
