extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_resource_counter_people_updated(newDemand: float, demandChange: float, newSatisfaction: float, satisfactionChange: float) -> void:
	self.value = newSatisfaction;
	
	if(newSatisfaction > 60.0):
		self.set_theme_type_variation("SatisfactionHigh")
	elif(newSatisfaction > 30.0):
		self.set_theme_type_variation("SatisfactionMid")
	else:
		self.set_theme_type_variation("SatisfactionLow")
