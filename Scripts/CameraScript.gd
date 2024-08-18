extends Camera2D

var newTargetCoords : Vector2 = Vector2(1615,931)
var newTargetZoom : Vector2 = Vector2(0.6, 0.6)

var zoomOut = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(zoomOut):
		self.position = lerp(self.position, newTargetCoords, delta * 2.0)
		self.zoom = lerp(self.zoom, newTargetZoom, delta * 2.0)
	pass

func _input(event: InputEvent) -> void:
	if(event is InputEventKey):
		if(event.physical_keycode == KEY_SPACE):
			zoomOut = true
