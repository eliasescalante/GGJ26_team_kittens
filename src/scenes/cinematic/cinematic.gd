extends Control

var count_pressed := 0

func _on_next_pressed() -> void:
	if count_pressed == 0:
		count_pressed += 1
		$Text.text = tr("TEXT_INTRO_2")
	elif count_pressed > 0:
		get_tree().change_scene_to_file("res://src/scenes/levels/level_01.tscn")
