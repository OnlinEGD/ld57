extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Globals.score += 1
		$"../CanvasLayer/UI"/Objectives/RepairKit.modulate = "ffffffff"
		queue_free()
