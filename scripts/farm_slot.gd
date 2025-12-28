extends Slot
class_name FarmSlot

@export var item_resource:Resource

func interact(instigator:Entity):
	if item_resource:
		#Global.inventory.add_item(item_resource, 1)
		Global.inventory[item_resource.item_name] = Global.inventory.get(item_resource.item_name, 0) + 1
		Global.log(str("Item added: ", item_resource.item_name, " (",Global.inventory.get(item_resource.item_name, 0),")"))
