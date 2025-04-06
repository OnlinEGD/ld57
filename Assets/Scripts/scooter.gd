extends Area2D

@onready var crafting: Control = $Control

func _on_body_entered(body):
	if body.name == "Player":
		crafting.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		crafting.visible = false

func _on_button_pressed():
	var recepture = get_parent()
	for item in Equipment.itemsArray:
		if item == recepture.item:
			print("item")
