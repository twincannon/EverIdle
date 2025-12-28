extends Button
class_name ClassButton

var res:ClassResource

signal on_class_button_clicked(out_res:ClassResource)

func init_button(in_res:ClassResource):
	text = in_res.classname
	res = in_res

func _on_pressed() -> void:
	on_class_button_clicked.emit(res)
