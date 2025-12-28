extends Entity
class_name Slot

@export var interact_time = 1.0
signal on_slot_emptied
signal on_slot_filled

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func interact(instigator:Entity):
	pass
