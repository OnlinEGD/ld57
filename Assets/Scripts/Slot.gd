extends TextureButton


var item: ItemDB.Item = null

func set_item(new_item: ItemDB.Item):
	item = new_item
	$VBoxContainer/Icon.texture = item.icon if item != null else null
	$VBoxContainer/Label.text = item.name if item != null else ""


func _on_pressed():
	if item == ItemDB.items["fish"]:
		Globals.hunger = min(Globals.hunger + 5, 100) 
		Equipment.items -= 1
		set_item(null)
