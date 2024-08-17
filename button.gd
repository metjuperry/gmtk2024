extends Button



func _pressed() -> void:
	pass # Replace with function body.
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogs/StartDialog.dialogue"),"StartDialog")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
