extends Node


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("exit_game"):
		exit_game()
	elif event.is_action_pressed("ui_accept"):
		for child in get_children():
			child.closing_animation()


func exit_game(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
