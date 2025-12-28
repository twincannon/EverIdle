extends Node
class_name Game

@onready var starting_class_container: PanelContainer = $CanvasLayer/Control/StartingClassContainer

var party:Array[Character] = []

# so we need a player party array of characters
# we need a map of locations, i guess a base 'zone' class?
# zones will have array of connections
const character_scene = preload("res://scenes/character.tscn")
@onready var party_container: GridContainer = %PartyContainer
@onready var battle_container: Control = %BattleContainer
const class_button_scene = preload("res://scenes/class_button.tscn")

signal on_zone_entered

func _init() -> void:
	Global.game = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cl in Global.classes:
		var classbutton_inst = class_button_scene.instantiate()
		%StartingClassVBox.add_child(classbutton_inst)
		classbutton_inst.init_button(cl)
		classbutton_inst.on_class_button_clicked.connect(_on_class_button_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_class_button_clicked(in_res:ClassResource):
	starting_class_container.hide() #delegate this
	#var character = Character.new(in_res)
	#party.append(character) #this sucks, just use party_container. rt click to inspect
	
	var char_scene = character_scene.instantiate()
	char_scene.res = in_res
	party_container.add_child(char_scene)

func _on_button_pressed() -> void:
	Global.current_zone = Global.zone_list["Dungeon1"]
	Global.log("Zone entered: " + Global.current_zone.zone_name)
	on_zone_entered.emit()
	pass # Replace with function body.
	
func show_info_panel(char:Character):
	%InfoPanel.init_panel(char)

func get_battle_party() -> Array[Character]:
	var members:Array[Character] = []
	for child in battle_container.get_children():
		if child is CharacterSlot:
			var child_character = child.get_character()
			if child_character:
				members.append(child_character)
	return members
