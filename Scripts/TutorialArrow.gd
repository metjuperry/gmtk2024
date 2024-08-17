extends Sprite2D

var time: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time += delta;
	
	self.position.y = self.position.y + sin(time * 8)
	pass


func _on_map_selected_building_changed(newSelectedBuilding: int) -> void:
	self.visible = false
	pass # Replace with function body.
