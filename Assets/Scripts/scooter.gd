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
		$AudioStreamPlayer2D.play()
		Globals.scrap -= 3
		Globals.oxygen += 100
		Globals.show_annoucement = true
		$"../CanvasLayer/UI"/InfoLabel.text = "Oxygen tank capacity increased. You can breathe underwater longer"
		emit_signal("oxygenSet")
