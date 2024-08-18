extends PanelContainer

var label : Label;
var initializing : bool;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializing = false;
	label = get_node("MarginContainer/VBoxContainer/Label");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	

	if(self.position.x != 1288 && initializing):
			self.position = self.position.lerp(Vector2(1288.0,self.position.y), delta * 2.0);
	pass


func _on_map_selected_building_changed(newSelectedBuilding: int) -> void:	
	if(!initializing):
		initializing = true;
	
	if(newSelectedBuilding == 1):
		label.text = "Ye Old Castle Market"
	if(newSelectedBuilding == 2):
		label.text = "Ye Old Blacksmith"
	if(newSelectedBuilding == 3):
		label.text = "Ye Old Recruiter Office"
	pass # Replace with function body.
