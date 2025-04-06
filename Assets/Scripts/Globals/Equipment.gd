extends Control

var items = 0
var max_items = 5
var slots = []
var itemsArray = []

func add_item(item_name: String):
	var item = ItemDB.items.get(item_name)
	if item == null:
		print("Brak przedmiotu:", item_name)
		return
	
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			items += 1
			itemsArray.append(item_name)
			print(itemsArray)
			return
	print("Brak wolnych slotów!")
	
func init(slots_container):
	slots = slots_container.get_children()
