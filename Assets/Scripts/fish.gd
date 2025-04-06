extends CharacterBody2D

var speed = randf_range(50, 200)  # Zmiennoprzecinkowa prędkość
var direction = Vector2()

@onready var sprite: Sprite2D = $Sprite2D
@onready var changeDirectionTimer: Timer = $ChangeDirectionTimer

func _ready():
	modulate = Color(randf_range(0.2, 1), randf_range(0.2, 1), randf_range(0.2, 1), 1)
	changeDirectionTimer.wait_time = randf_range(1,5)
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _on_body_entered(body):
	if body.name == "Player":
		Globals.hunger = min(Globals.hunger + 5, 100) 
		Globals.fish_count
		queue_free() 

func _process(delta):
	var motion = direction * speed * delta
	motion = move_and_collide(motion) 
	
	if position.y <= 20:
		direction.y = -direction.y
		
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

func _on_change_direction_timer_timeout():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
