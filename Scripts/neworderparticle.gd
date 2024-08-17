extends GPUParticles2D

func _on_button_2_pressed() -> void:
	await finished
	restart()


func _on_orloj_cycle_complete() -> void:
	restart()
