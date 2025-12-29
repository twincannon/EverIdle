extends Entity
class_name Slot

@export var interact_time = 1.0
signal on_slot_emptied
signal on_slot_filled

func can_interact() -> bool:
	return false

func interact(instigator:Entity):
	pass
