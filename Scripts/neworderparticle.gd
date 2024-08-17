extends GPUParticles2D


func _on_resource_counter_people_updated(newDemand: float, demandChange: float, newSatisfaction: float, satisfactionChange: float) -> void:
	self.amount = newDemand
	restart()
