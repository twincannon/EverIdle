extends Slot
class_name CharacterSlot

@export var target_slot:Slot

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Character:
		return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.on_removed_from_slot()
	data.get_parent().remove_child(data)
	add_child(data)
	data.on_added_to_slot()
	pass

func get_character() -> Character:
	# We should only ever have one character
	for child in get_children():
		if child is Character:
			return child
	return null
