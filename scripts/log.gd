extends RichTextLabel
class_name Log

func _ready() -> void:
	Global.message_log = self
	pass # Replace with function body.

var messages = []
var max_messages = 100

func add_message(in_text : String):
	messages.append(in_text)
	if messages.size() > max_messages:
		messages.remove_at(0)
	
	set_text(arr_join( messages, "\n" ))
	scroll_to_line( get_line_count() - 1 )

func arr_join(arr, separator = ""):
	var output = "";
	for s in arr:
		output += str(s) + separator
	output = output.left( output.length() - separator.length() )
	return output 
