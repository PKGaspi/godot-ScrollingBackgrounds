extends Node


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("exit_game") or event.is_action_pressed("ui_accept"):
		exit_game()


func exit_game(exit_code: int = 0) -> void:
	for child in get_children()[0].get_children():
		child.closing_animation()
	for child in get_children()[0].get_children():
		await child.closed
		child.queue_free()
	
	get_tree().quit(exit_code)


func _on_Button_pressed() -> void:
	exit_game()
