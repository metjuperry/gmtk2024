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
	var array: Array = eventData["Events"]["Workshop"]
	array.shuffle()
	for event in array.slice(0,3):
		var newButton = Button.new()
		newButton.text = event["Name"]
		newButton.alignment = HORIZONTAL_ALIGNMENT_LEFT
		newButton.pressed.connect(Callable(tryBuyUpgrade).bind(event))
		var newAcquisitionLabel = Label.new()
		newAcquisitionLabel.text = "    Aqusition Cost: " + str(event["Aquisition_Cost"])
		newAcquisitionLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		newAcquisitionLabel.add_theme_color_override("font_color",getColor(event["Aquisition_Cost"]))
		var newDailyCostLabel = Label.new()
		newDailyCostLabel.text = "    Daily Cost: " + str(event["Cost_Per_Cycle"])
		newDailyCostLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		newDailyCostLabel.add_theme_color_override("font_color",getColor(event["Cost_Per_Cycle"]))
		var newproductionChangeLabel = Label.new()
		newproductionChangeLabel.text = "    Daily Production Change: " + str(event["Cost_Per_Cycle"])
		newproductionChangeLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		newproductionChangeLabel.add_theme_color_override("font_color",getColor(event["Cost_Per_Cycle"]))
		add_child(newButton)
		add_child(newAcquisitionLabel)
		add_child(newDailyCostLabel)
		add_child(newproductionChangeLabel)
		
func tryBuyUpgrade():
	
	pass
	
func getColor(number: float) -> Color:
	if number>0:
		return Color.html("#39e75f")
	elif number<0:
		return Color.html("#ff474c")
	else:
		return Color.html("#FFFFFF")
