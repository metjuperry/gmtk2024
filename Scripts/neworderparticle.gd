extends GPUParticles2D

func _on_button_2_pressed() -> void:
	await finished
	restart()
