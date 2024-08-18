extends Sprite2D

signal cycleComplete()


var spin : bool;
@export var rotation_speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spin = false;
	return;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!spin):
		return
	
	self.rotation += delta * rotation_speed;

	if(self.rotation_degrees > 360.0):
		self.rotation = 0;
		cycleComplete.emit()
	pass


func _on_node_2d_tutorial_over() -> void:
	spin = true;

func _on_node_2d_start_cycle() -> void:
	spin = true;


func _on_node_2d_stop_cycle() -> void:
	spin = false;
