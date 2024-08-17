extends Node2D

var selectedBuilding : int = 0;

signal selected_building_changed(newSelectedBuilding: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_clicked_tile_power():
	
	var tile_map_layer = get_node("BuildingsTileMap");
	
	var currentBuilding = selectedBuilding;
	
	var clicked_cell = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	var data = tile_map_layer.get_cell_tile_data(clicked_cell)
	if data:
		selectedBuilding = data.get_custom_data("BuildingType");
	else:
		selectedBuilding = 0
	
	if(currentBuilding != selectedBuilding):
		selected_building_changed.emit(selectedBuilding);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		get_clicked_tile_power();
	pass
