extends PanelContainer
class_name InfoPanel

func init_panel(character:Character):
	%IconTexture.texture = character.get_character_texture()
	%InfoLabel.text = "Name: " + character.character_name + "\n" \
	+ "STR: " + str(character.res.stat_str)
	visible = true

func _on_x_button_pressed() -> void:
	visible = false
