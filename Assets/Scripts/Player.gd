extends CharacterBody2D

@export var speed = 500.0
@export var swim_speed = 200.0
@export var swim_gravity = 50.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

var in_water = false

var on_wall = false
var climbing = false
@export var climb_speed = 100.0

@onready var oxygenTimer: Timer = $OxygenTimer

func _process(_delta):
	
	if Globals.score == 3 and $"../CanvasLayer/UI".visible == true:
		print("koniec gry")
	
	if Globals.health <= 0:
		queue_free()
		
	if global_position.y > -20:
		in_water = true
	else:
		in_water = false
		
	if in_water:
		Globals.depth = int(position.y / 100)
		

func _physics_process(delta):
	if in_water:
		velocity.y = 0
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * swim_speed
		else:
			velocity.x = move_toward(velocity.x, 0, swim_speed)

		if Input.is_action_pressed("ui_accept"):
			velocity.y = -swim_speed

		if Input.is_action_pressed("ui_down"):
			velocity.y = swim_speed
	else:
		on_wall = is_on_wall()

		if not is_on_floor() and not climbing:
			velocity.y += gravity * delta

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Wall climbing
		if on_wall and Input.is_action_pressed("ui_accept"):
			climbing = true
			velocity.y = -climb_speed
		elif on_wall and climbing and not Input.is_action_pressed("ui_accept"):
			velocity.y = 0
		else:
			climbing = false

	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

	move_and_slide()
	update_animation_parameters()



func update_animation_parameters():
	if velocity.x == 0 and in_water == false:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
		animation_tree["parameters/conditions/is_swimming_V"] = false
		animation_tree["parameters/conditions/is_swimming"] = false
	elif velocity.x != 0 and in_water == false:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
		animation_tree["parameters/conditions/is_swimming_V"] = false
		animation_tree["parameters/conditions/is_swimming"] = false
	elif in_water == true:
		animation_tree["parameters/conditions/is_swimming"] = true
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = false
		animation_tree["parameters/conditions/is_swimming_V"] = false
		
		if velocity.y < 0 and in_water == true:
			animation_tree["parameters/conditions/is_swimming"] = false
			animation_tree["parameters/conditions/is_swimming_V"] = true



func _on_oxygen_timer_timeout():
	if in_water == true and Globals.oxygen > 0:
		Globals.oxygen -= 1
		oxygenTimer.start()
	elif in_water == false and Globals.oxygen < $"../CanvasLayer/UI"/VBoxContainer/OxygenBar.max_value:
		Globals.oxygen += 10
	elif Globals.oxygen <= 0 or Globals.hunger <= 0:
		Globals.health -= 1
		oxygenTimer.start()


func _on_hunger_timer_timeout():
	if Globals.hunger > 0:
		Globals.hunger -= 5
