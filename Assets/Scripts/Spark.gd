extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Globals.score += 1
		$"../CanvasLayer/UI"/Objectives/Spark.modulate = "ffffffff"
		Globals.show_annoucement = true
		$"../CanvasLayer/UI"/InfoLabel.text = "You found an item necessary to repair the scooter"
		queue_free()
