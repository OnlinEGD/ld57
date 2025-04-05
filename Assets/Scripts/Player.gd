extends CharacterBody2D

@export var speed = 500.0
@export var swim_speed = 200.0
@export var swim_gravity = 50.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

var in_water = false

@onready var oxygenTimer: Timer = $OxygenTimer

func _process(delta):
	
	if Globals.oxygen <= 0:
		queue_free()
		
	if global_position.y > 0:
		in_water = true
	else:
		in_water = false
		

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
		if not is_on_floor():
			velocity.y += gravity * delta

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

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
	if in_water == true:
		Globals.oxygen -= 1
		oxygenTimer.start()
	elif in_water == false and Globals.oxygen < 100:
		Globals.oxygen += 10
