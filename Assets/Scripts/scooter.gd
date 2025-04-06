extends Area2D

@onready var crafting: Control = $Control

signal oxygenSet

func _on_body_entered(body):
	if body.name == "Player":
		crafting.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		crafting.visible = false


func _on_button_pressed():
	if Globals.scrap >= 3:
		Globals.scrap -= 3
		Globals.oxygen += 100
		emit_signal("oxygenSet")
