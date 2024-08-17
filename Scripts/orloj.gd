extends Sprite2D

signal cycleComplete()

@export var rotation_speed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	self.rotation += delta * rotation_speed;

	if(self.rotation_degrees > 360.0):
		self.rotation = 0;
		cycleComplete.emit()
	pass
