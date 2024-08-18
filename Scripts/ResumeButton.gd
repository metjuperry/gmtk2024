extends Button

signal continueSignal()

func _on_pressed() -> void:
	continueSignal.emit()
