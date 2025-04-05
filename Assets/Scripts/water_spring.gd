extends Node2D

var velocity = 0
var force = 0
var height = 0
var target_height = 0

@onready var collision = $Area2D/CollisionShape2D

var index = 0
var motion_factor = 0.02

var collided_with = null

signal splash

func water_update(spring_constant, dampening):
	height = position.y
	var x = height - target_height
	var loss = -dampening * velocity
	force = -spring_constant * x + loss
	velocity += force
	position.y += velocity

func initialize(x_position, id):
	height = position.y
	target_height = position.y
	position.x = x_position
	velocity = 0
	index = id

func set_collision_width(value):
	var extents = collision.shape.get_size()
	var new_extents = Vector2(value/2, extents.y)
	collision.shape.set_size(new_extents)

func _on_area_2d_body_entered(body):
	if body.name == "Player" and collided_with == null:
		$CPUParticles2D.restart()
		$Timer.start()
		collided_with = body
		var speed = body.speed * motion_factor
		emit_signal("splash", index, speed)


func _on_timer_timeout():
	collided_with = null
