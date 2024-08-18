extends Label


func _on_node_2d_product_namechanged(newName: String) -> void:
	self.text = newName + " in stock"
