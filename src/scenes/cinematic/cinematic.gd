extends Control

var frames := 0


func _on_timer_timeout() -> void:
	if ($Image.texture as AnimatedTexture).current_frame == 2:
		get_tree().change_scene_to_file("res://src/scenes/levels/level_01.tscn")
