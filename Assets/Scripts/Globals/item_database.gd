extends Node2D

class_name ItemData

class Item:
	var name: String
	var icon: Texture
	var description: String

	func _init(name: String, icon: Texture, description: String):
		self.name = name
		self.icon = icon
		self.description = description

var items: Dictionary = {}

func _ready():
	items["fish"] = Item.new("Fish", load("res://Assets/Graphics/fish.png"), "Restores 5 hunger")
	items["scrap"] = Item.new("Scrap", load("res://Assets/Graphics/scrap.png"), "Useful in crafting")
	items["welder"] = Item.new("Welder", load("res://Assets/Graphics/fish.png"), "Essential for jet skis")
	items["repair_kit"] = Item.new("Kepair kit", load("res://Assets/Graphics/fish.png"), "Essential for jet skis")
	items["battery"] = Item.new("Battery", load("res://Assets/Graphics/fish.png"), "Essential for jet skis")
