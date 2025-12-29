extends Entity
class_name Character

@onready var interact_timer: Timer = $InteractTimer

var drag_preview = preload("res://scenes/char_drag_preview.tscn")
var target_slot:Slot = null
var xp = 0
var res:ClassResource
var character_name:String

var skills:Dictionary

func _init(in_res:ClassResource = null):
	res = in_res

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize skills dict
	for skill in Global.Skills:
		skills[Global.Skills[skill]] = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _get_tooltip(vec:Vector2) -> String:
	return "XP: %d" % xp

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		Global.game.show_info_panel(self)
		pass #show a pop up with information about this character

func on_added_to_slot():
	interact_timer.stop()
	interact_timer.wait_time = 1.0
	if get_parent() is CharacterSlot and get_parent().target_slot:
		target_slot = get_parent().target_slot as Slot
		target_slot.on_slot_emptied.connect(_on_target_slot_emptied)
		target_slot.on_slot_filled.connect(_on_target_slot_filled)
		start_interact_timer()

func start_interact_timer():
	if target_slot:
		if target_slot is EnemySlot:
			if target_slot.get_enemy():
				interact_timer.wait_time = get_attack_time()
				interact_timer.start()
		else:
			interact_timer.wait_time = target_slot.interact_time
			interact_timer.start()

func on_removed_from_slot():
	if target_slot:
		target_slot.on_slot_emptied.disconnect(_on_target_slot_emptied)
		target_slot.on_slot_filled.disconnect(_on_target_slot_filled)
	target_slot = null
	interact_timer.stop()

func _on_target_slot_emptied():
	interact_timer.stop()
	
func _on_target_slot_filled():
	start_interact_timer()

func get_attack_time():
	return 0.5 #eventually this will be some formula based on stats, agility etc

func _get_drag_data(at_position: Vector2) -> Variant:
	var data = self
	var preview = drag_preview.instantiate()
	preview.get_child(0).texture = get_child(0).texture
	set_drag_preview(preview)
	return data

func get_character_texture():
	return get_child(0).texture


func _on_interact_timer_timeout() -> void:
	if target_slot and target_slot.can_interact():
		$AnimationPlayer.stop()
		$AnimationPlayer.play("attack")
		target_slot.interact(self)

func get_damage():
	return 1.0

func add_xp(incoming_xp):
	xp += incoming_xp
	Global.log(str("Character earned ", incoming_xp, " xp!"))
	# check level up etc
