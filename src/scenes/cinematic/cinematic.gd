extends Control

var count_pressed := 0

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		next_step()
		
	elif event.is_action_pressed("ui_accept"):
		next_step()


func next_step():
	if count_pressed == 0:
		count_pressed += 1
		$Text.text = tr("TEXT_INTRO_2")
	else:
		get_tree().change_scene_to_file("res://src/scenes/levels/level_01.tscn")
