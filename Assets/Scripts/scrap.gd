extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if Equipment.items < Equipment.max_items:
			Equipment.add_item("scrap")
			queue_free() 
