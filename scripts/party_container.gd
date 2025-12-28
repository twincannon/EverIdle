extends GridContainer
class_name PartyContainer

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Character:
		return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.on_removed_from_slot()
	data.get_parent().remove_child(data)
	add_child(data)
