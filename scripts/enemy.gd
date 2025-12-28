extends Entity
class_name Enemy

var enemy_resource:EnemyResource = null
var health = 5
var damage = 1
var xp = 10

signal on_death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_enemy(enemy_res:EnemyResource):
	health = enemy_res.health
	damage = enemy_res.damage
	xp = enemy_res.xp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(amount:float):
	health -= amount
	Global.log(str("Enemy damaged for ", amount))
	if health <= 0:
		Global.add_xp_to_party(xp)
		on_death.emit()
		Global.log("Enemy slain!")
		queue_free()
	
