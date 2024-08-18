extends Control

func _on_button_continue_signal() -> void:
	self.visible = false;
	


func _on_node_2d_pause_game() -> void:
	self.visible = true;
