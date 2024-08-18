extends Node2D

signal toggleArrow(show: bool)
signal tutorialOver()
signal stopCycle()
signal startCycle()
signal enableCouriers()
signal productNamechanged(newName: String);
signal zoomOut()
signal pauseGame()

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
	productNamechanged.emit(GameState.sold_goods)
	name_input_dialog.queue_free()

func _input(event: InputEvent) -> void:
	if(event is InputEventKey):
		if(event.physical_keycode == KEY_ESCAPE):
			stop_cycle()
			pauseGame.emit()

func zoom_out() -> void:
	zoomOut.emit()

func start_cycle() -> void:
	startCycle.emit()
	
func stop_cycle() -> void:
	stopCycle.emit()

func show_couriers() -> void:
	enableCouriers.emit()

func show_tutorial_arrow_backsmith() -> void:
	get_node("CanvasLayer/Down-arrow").visible = true
func show_tutorial_arrow_market() -> void:
	get_node("CanvasLayer/Down-arrow2").visible = true
func show_tutorial_arrow_recruiter() -> void:
	get_node("CanvasLayer/Down-arrow3").visible = true
func tutorial_over() -> void:
	tutorialOver.emit()

func _on_resource_counter_move_next_phase() -> void:
	stop_cycle()
	var resource = preload("res://Dialogs/Expansion.dialogue")
	DialogueManager.show_example_dialogue_balloon(resource,	"Expansion")
