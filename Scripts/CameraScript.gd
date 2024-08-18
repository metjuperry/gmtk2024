extends Camera2D

var newTargetCoords : Vector2 = Vector2(1615,931)
var newTargetZoom : Vector2 = Vector2(0.6, 0.6)

var zoomOut = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(zoomOut):
		self.position = lerp(self.position, newTargetCoords, delta * 2.0)
		self.zoom = lerp(self.zoom, newTargetZoom, delta * 2.0)
	pass		


func _on_node_2d_zoom_out() -> void:
	zoomOut = true
