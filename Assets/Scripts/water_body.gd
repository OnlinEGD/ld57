extends Node2D

@export var k: float = 0.015
@export var d: float = 0.03
@export var spread: float = 0.0002

var springs: Array = []
var passes: int = 8

@export var distance_between_springs: int = 32
@export var spring_number: int = 1000

@onready var water_spring: PackedScene = preload("res://Assets/Scenes/water_spring.tscn")

@export var depth: int = 10000
var target_height = global_position.y
var bottom = target_height + depth

@onready var water_polygon: Polygon2D = $WaterPolygon

@export var particle_count = 1000
@export var fish_count = 100

@onready var bubble_particle: PackedScene = preload("res://Assets/Scenes/bubble_particle.tscn")
@onready var fish: PackedScene = preload("res://Assets/Scenes/fish.tscn")

func _ready():
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var w = water_spring.instantiate()
		add_child(w)
		springs.append(w)
		w.initialize(x_position, i)
		w.set_collision_width(distance_between_springs)
		w.connect("splash", splash)
		
	for y in range(particle_count):
		var b = bubble_particle.instantiate()
		add_child(b)
		b.global_position = Vector2(randi_range(-4000,4000), randi_range(100,10000))
	
	for i in range(fish_count):
		var f = fish.instantiate()
		var pos = Vector2(randi_range(-4000,4000), randi_range(100,1000))
		f.global_position = pos
		add_child(f)

func _physics_process(_delta):
	for i in springs:
		i.water_update(k,d)
	
	var left_deltas = []
	var right_deltas = []
	
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		
	for j in range(passes):
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = (springs[i].height - springs[i-1].height) * spread
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i] = (springs[i].height - springs[i+1].height) * spread
				springs[i+1].velocity += right_deltas[i]
				
	draw_water_body()
			
func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
		
func draw_water_body():
	var surface_points = []
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	
	var first_index = 0
	var last_index = surface_points.size() - 1

	var water_polygon_points = surface_points
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points)
	
	water_polygon.set_polygon(water_polygon_points)
