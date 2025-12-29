extends Slot
class_name EnemySlot

@onready var respawn_timer: Timer = $RespawnTimer
const enemy_scene = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_enemy_slot_filled()
	on_slot_filled.connect(_on_enemy_slot_filled)
	Global.game.on_zone_entered.connect(_on_zone_entered)
	pass # Replace with function body.

func _on_zone_entered():
	respawn_timer.start()
	
func get_enemy() -> Enemy:
	# We should only ever have one enemy (for now at least)
	for child in get_children():
		if child is Enemy:
			return child
	return null

func _on_enemy_slot_filled():
	var enemy = get_enemy()
	if enemy:
		enemy.on_death.connect(_on_enemy_died)

func _on_enemy_died():
	get_enemy().on_death.disconnect(_on_enemy_died) #is this necessary? because i dont do it when the enemy is cleared via zoning
	on_slot_emptied.emit()
	respawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func can_interact() -> bool:
	var enemy = get_enemy()
	return enemy != null

func interact(instigator:Entity):
	var enemy = get_enemy()
	if enemy:
		var damage = instigator.get_damage()
		enemy.take_damage(damage)
	pass

func _on_respawn_timer_timeout() -> void:
	var enemy = get_enemy()
	if !enemy:
		# get enemy scene and instantiate it, then populate it's data with a resource from current zone
		if Global.current_zone and Global.current_zone.enemy_list.size() > 0:
			var enemy_res = Global.current_zone.enemy_list.pick_random()
			var new_enemy = enemy_scene.instantiate()
			new_enemy.init_enemy(enemy_res)
			add_child(new_enemy)
			Global.log(str("An enemy appears! health: ", new_enemy.health))
		pass # Replace with function body.


func _on_child_entered_tree(node: Node) -> void:
	if node is Enemy:
		on_slot_filled.emit()
