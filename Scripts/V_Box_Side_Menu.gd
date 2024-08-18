extends VBoxContainer

signal changeMoney(ammount: float)
signal changeWorkerWage(ammount: float)
signal changeProduction(ammount: float)
signal changeDemand(ammount: float)
signal changeIncome(ammount: float)
signal changeAreasSatisfaction(amount: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	loadEvents()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var hireArray: Array
var markerArray: Array
var workshopArray: Array
var currentBuilding: int

func loadEvents() -> void:
	var file = FileAccess.open("res://Data/EventList.json",FileAccess.READ)
	var eventData = JSON.parse_string(file.get_as_text())
	markerArray = eventData["Events"]["Market"]
	workshopArray = eventData["Events"]["Workshop"]
	hireArray = eventData["Events"]["Hiring"]
	
func _on_map_selected_building_changed(newSelectedBuilding: int) -> void:	
	renderButtons(newSelectedBuilding)

func clearChildren() -> void:
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
func renderButtons(newSelectedBuilding: int) -> void:
	if(newSelectedBuilding == 1):
		currentBuilding = 1
		clearChildren()
		for event in markerArray.slice(0,3):
			var newButton = Button.new()
			newButton.text = event["Name"]
			newButton.alignment = HORIZONTAL_ALIGNMENT_LEFT
			var newAcquisitionLabel = Label.new()
			newAcquisitionLabel.text = "    Aqusition Cost: " + str(event["PurchaseCost"])
			newAcquisitionLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newAcquisitionLabel.add_theme_color_override("font_color",getInvertedColor(event["PurchaseCost"]))
			add_child(newButton)
			add_child(newAcquisitionLabel)
			var nodes: Array = [newButton,newAcquisitionLabel]
			var competitorChange: float = 0
			var areaSatisfactionChange: float = 0
			var demandChange: float = 0
			var revenueChange: float = 0
			for effect in event["Effects"]:
				var newEfectLabel = Label.new()
				newEfectLabel.text = "    "+ str(effect["Type"]) +": " + str(effect["Change"])
				newEfectLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
				if(str(effect["Type"])=="Competitors"):
					newEfectLabel.add_theme_color_override("font_color",getInvertedColor(effect["Change"]))
					competitorChange += effect["Change"]
				elif(str(effect["Type"])=="Demand"):
					newEfectLabel.add_theme_color_override("font_color",getColor(effect["Change"]))
					competitorChange += effect["Change"]
				elif(str(effect["Type"])=="AreaSatisfaction"):
					newEfectLabel.add_theme_color_override("font_color",getColor(effect["Change"]))
					areaSatisfactionChange += effect["Change"]
				elif(str(effect["Type"])=="Revenue"):
					newEfectLabel.add_theme_color_override("font_color",getColor(effect["Change"]))
					revenueChange += effect["Change"]
				else:
					newEfectLabel.add_theme_color_override("font_color",getColor(effect["Change"]))
				add_child(newEfectLabel)
				nodes.push_back(newEfectLabel)
			newButton.pressed.connect(Callable(tryBuyMarketItem).bind(event["PurchaseCost"],nodes,competitorChange,demandChange,areaSatisfactionChange,revenueChange))

	if(newSelectedBuilding == 2):
		currentBuilding = 2
		clearChildren()
		for event in workshopArray.slice(0,3):
			var newButton = Button.new()
			newButton.text = event["Name"]
			newButton.alignment = HORIZONTAL_ALIGNMENT_LEFT
			var newAcquisitionLabel = Label.new()
			newAcquisitionLabel.text = "    Aqusition Cost: " + str(event["Aquisition_Cost"])
			newAcquisitionLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newAcquisitionLabel.add_theme_color_override("font_color",getInvertedColor(event["Aquisition_Cost"]))
			var newDailyCostLabel = Label.new()
			newDailyCostLabel.text = "    Daily Expenses: " + str(event["Cost_Per_Cycle"])
			newDailyCostLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newDailyCostLabel.add_theme_color_override("font_color",getInvertedColor(event["Cost_Per_Cycle"]))
			var newproductionChangeLabel = Label.new()
			newproductionChangeLabel.text = "    Daily Production Change: " + str(event["Cycle_Production_Change"])
			newproductionChangeLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newproductionChangeLabel.add_theme_color_override("font_color",getColor(event["Cycle_Production_Change"]))
			add_child(newButton)
			add_child(newAcquisitionLabel)
			add_child(newDailyCostLabel)
			add_child(newproductionChangeLabel)
			newButton.pressed.connect(Callable(tryBuyWorkshopItem).bind(event["Aquisition_Cost"],event["Cost_Per_Cycle"],event["Cycle_Production_Change"],newButton,newAcquisitionLabel,newDailyCostLabel,newproductionChangeLabel))
	if(newSelectedBuilding == 3):
		currentBuilding = 3
		clearChildren()
		for event in hireArray.slice(0,3):
			var newButton = Button.new()
			newButton.text = event["Name"]
			newButton.alignment = HORIZONTAL_ALIGNMENT_LEFT
			var newAcquisitionLabel = Label.new()
			newAcquisitionLabel.text = "    Aqusition Cost: " + str(event["Aquisition_Cost"])
			newAcquisitionLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newAcquisitionLabel.add_theme_color_override("font_color",getInvertedColor(event["Aquisition_Cost"]))
			var newDailyCostLabel = Label.new()
			newDailyCostLabel.text = "    Daily Expenses: " + str(event["Cost_Per_Cycle"])
			newDailyCostLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newDailyCostLabel.add_theme_color_override("font_color",getInvertedColor(event["Cost_Per_Cycle"]))
			var newproductionChangeLabel = Label.new()
			newproductionChangeLabel.text = "    Daily Production Change: " + str(event["Cycle_Production_Change"])
			newproductionChangeLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			newproductionChangeLabel.add_theme_color_override("font_color",getColor(event["Cycle_Production_Change"]))
			add_child(newButton)
			add_child(newAcquisitionLabel)
			add_child(newDailyCostLabel)
			add_child(newproductionChangeLabel)
			newButton.pressed.connect(Callable(tryBuyWorker).bind(event["Aquisition_Cost"],event["Cost_Per_Cycle"],event["Cycle_Production_Change"],newButton,newAcquisitionLabel,newDailyCostLabel,newproductionChangeLabel))
			
		
func tryBuyWorker(aquistionCost: float, workerWage: float, productionChange: float, button: Button, hidelabel1: Label, hidelabel2: Label, hidelabel3: Label):
	if(aquistionCost <= GameState.currentMoney):
		button.queue_free()
		hidelabel1.queue_free()
		hidelabel2.queue_free()
		hidelabel3.queue_free()
		changeMoney.emit(-aquistionCost)
		changeProduction.emit(productionChange)
		changeWorkerWage.emit(workerWage)
	else:
		var resource = preload("res://Dialogs/NotEnoghtMoney.dialogue")
		DialogueManager.show_example_dialogue_balloon(resource,	"NotEnoughMoney",)
	
func tryBuyWorkshopItem(aquistionCost: float, incomeChange: float, productionChange: float, button: Button, hidelabel1: Label, hidelabel2: Label, hidelabel3: Label):
	if(aquistionCost <= GameState.currentMoney):
		button.queue_free()
		hidelabel1.queue_free()
		hidelabel2.queue_free()
		hidelabel3.queue_free()
		changeMoney.emit(-aquistionCost)
		changeProduction.emit(productionChange)
		changeIncome.emit(incomeChange)
	else:
		var resource = preload("res://Dialogs/NotEnoghtMoney.dialogue")
		DialogueManager.show_example_dialogue_balloon(resource,	"NotEnoughMoney",)
		
func tryBuyMarketItem(aquistionCost: float, hideNodes: Array, compatitorChange: float, demandChange: float, areaSatisfactionChange: float, revenueChange: float):
	if(aquistionCost <= GameState.currentMoney):
		for node in hideNodes:
			node.queue_free()
		changeMoney.emit(-aquistionCost)
		changeDemand.emit(-compatitorChange)
		changeDemand.emit(demandChange)
		changeAreasSatisfaction.emit(areaSatisfactionChange)
		changeIncome.emit(revenueChange)
		
	else:
		var resource = preload("res://Dialogs/NotEnoghtMoney.dialogue")
		DialogueManager.show_example_dialogue_balloon(resource,	"NotEnoughMoney",)

func getColor(number: float) -> Color:
	if number>0:
		return Color.html("#39e75f")
	elif number<0:
		return Color.html("#ff474c")
	else:
		return Color.html("#FFFFFF")
		
func getInvertedColor(number: float) -> Color:
	if number>0:
		return Color.html("#ff474c")
	elif number<0:
		return Color.html("#39e75f")
	else:
		return Color.html("#FFFFFF")


func _on_resource_counter_people_updated(newDemand: float, demandChange: float, newSatisfaction: float, satisfactionChange: float) -> void:
	clearChildren()
	hireArray.shuffle()
	markerArray.shuffle()
	workshopArray.shuffle()
	renderButtons(currentBuilding)


func _on_resource_counter_resources_updated(newMoney: float, moneyChange: float, newProducts: float, productsChange: float, workerProductivity: float) -> void:
	pass # Replace with function body.
