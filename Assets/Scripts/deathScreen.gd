extends Control



func _on_button_pressed():
	Globals.oxygen = 100
	Globals.health = 100
	Globals.hunger = 100
	Globals.fish_count = 50
	Globals.depth = 0
	Globals.scrap = 0
	Globals.score = 0
	get_tree().change_scene_to_file("res://Assets/Scenes/world.tscn")
