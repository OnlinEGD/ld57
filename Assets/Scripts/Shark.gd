extends CharacterBody2D

var speed = 200
var direction = Vector2()

@onready var sprite: Sprite2D = $Sprite2D
@onready var changeDirectionTimer: Timer = $ChangeDirectionTimer

var chasing = false
@onready var raycast: RayCast2D = $Sprite2D/RayCast2D

func _ready():
	changeDirectionTimer.wait_time = randf_range(1,5)
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _on_body_entered(body):
	if body.name == "Player":
		Globals.health -= 10

func _process(delta):
	var motion = direction * speed * delta
	motion = move_and_collide(motion) 
	
	if chasing:
		var directionR = ($"../../Player".global_position - raycast.global_position).normalized()
		raycast.target_position = directionR * 75
		if raycast.is_colliding():
			if raycast.get_collider() == $"../../Player":
				direction = ($"../../Player".global_position - global_position).normalized()
				$Label.visible = true
			else:
				changeDirectionTimer.paused = false
				$Label.visible = false
	
	if position.y <= 20:
		chasing = false
		direction.y = -direction.y
		
		
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

func _on_change_direction_timer_timeout():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _on_player_detector_body_entered(body):
	if body.name == "Player":
		changeDirectionTimer.paused = true
		chasing = true
	if body.name == "TileMap":
		direction = -direction

func _on_player_detector_body_exited(body):
	if body.name == "Player":
		chasing = false
		changeDirectionTimer.paused = false
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		$Label.visible = false
