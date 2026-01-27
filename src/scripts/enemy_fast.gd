extends "res://src/scripts/enemy_base.gd"

@onready var animation := $AnimatedSprite2D

func _ready():
	super._ready()
	animation.play("walk_right")
	animation.flip_h = true
	speed = 220
	damage = 1
