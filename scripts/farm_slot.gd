extends Slot
class_name FarmSlot

@export var item_resource:Resource

@export var skill_type:Global.Skills
@export var skill_stat:Global.Stats #stat to check for skill raises

func can_interact() -> bool:
	return item_resource != null

func interact(instigator:Entity):
	if item_resource and instigator is Character:
		#Global.inventory.add_item(item_resource, 1)
		Global.inventory[item_resource.item_name] = Global.inventory.get(item_resource.item_name, 0) + 1
		Global.log(str("Item added: ", item_resource.item_name, " (",Global.inventory.get(item_resource.item_name, 0),")"))
		var skillval = instigator.skills[skill_type]
		if randf() < pow(0.99, skillval):
			instigator.skills[skill_type] += 1
			Global.log(str(instigator.character_name, " got better at ", Global.Skills.keys()[skill_type], ": ", instigator.skills[skill_type]))
			
