extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	loadFirstDialog()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func loadFirstDialog() -> void:
	var resource = preload("res://Dialogs/StartDialog.dialogue")
	DialogueManager.show_example_dialogue_balloon(resource,	"StartDialog",)
	

func ask_for_name() -> void:
	var name_input_dialog = load("res://Scenes/NameInputDialog.tscn").instantiate()
	get_tree().current_scene.add_child(name_input_dialog)
	name_input_dialog.popup_centered()
	await name_input_dialog.confirmed
	GameState.player_name = name_input_dialog.name_edit.text
	name_input_dialog.queue_free()
	
func ask_for_sold_goods() -> void:
	var name_input_dialog = load("res://Scenes/TextInputDialog.tscn").instantiate()
	get_tree().current_scene.add_child(name_input_dialog)
	name_input_dialog.popup_centered()
	await name_input_dialog.confirmed
	GameState.sold_goods = name_input_dialog.name_edit.text
	name_input_dialog.queue_free()
