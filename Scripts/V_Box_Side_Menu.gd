extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	loadEvents()
	renderButtons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var eventData

func loadEvents() -> void:
	var file = FileAccess.open("res://Data/EventList.json",FileAccess.READ)
	eventData = JSON.parse_string(file.get_as_text())
	pass
	
func renderButtons() -> void:
	pass
	for event in eventData["Events"]["Workshop"]:
		var containerH = HBoxContainer.new()
		var newButton = Button.new()
		newButton.text = event["Name"]
		newButton.alignment = HORIZONTAL_ALIGNMENT_LEFT
		containerH.add_child(newButton)
		var newLabel = Label.new()
		newLabel.text = "Aqusition Cost: " + str(event["Aquisition_Cost"])
		containerH.add_child(newLabel)
		add_child(containerH)
		
		
	
