extends Node

var classes = [
	preload("res://res/class_warrior.tres"),
	preload("res://res/class_cleric.tres"),
	preload("res://res/class_deacon.tres")
]

enum Skills {
	Lumbering
}

var message_log:Log = null

var current_enemy:Enemy = null
var current_zone:Zone = null

var game:Game = null

var zone_list = {
	"Dungeon1" : preload("res://res/zone_dungeon.tres")
}

var inventory:Dictionary = { }

func log(text):
	if message_log:
		message_log.add_message(text)

func add_xp_to_party(xp):
	if game:
		for member in game.get_battle_party():
			member.add_xp(xp)
