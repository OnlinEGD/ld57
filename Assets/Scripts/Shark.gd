extends CharacterBody2D

var speed = randf_range(50, 200)
var direction = Vector2()

@onready var sprite: Sprite2D = $Sprite2D
@onready var changeDirectionTimer: Timer = $ChangeDirectionTimer

var chasing = false

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
		direction = ($"../../Player".global_position - global_position).normalized()
	
	if position.y <= 20:
		chasing = false
		direction.y = -direction.y
	else:
		chasing = true
		
		
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

func _on_change_direction_timer_timeout():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _on_player_detector_body_entered(body):
	if body.name == "Player":
		changeDirectionTimer.stop()
		chasing = true
		$Label.visible = true
	if body.name == "Tilemap":
		direction.y = -direction.y

func _on_player_detector_body_exited(body):
	if body.name == "Player":
		chasing = false
		changeDirectionTimer.start()
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		$Label.visible = false
