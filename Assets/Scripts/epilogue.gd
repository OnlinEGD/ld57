extends Control

@onready var slide_viewer = $SlideViewer
@onready var timer = $Timer

var slides = [
	preload("res://Assets/Cutscenes/epilog/1.png"),
	preload("res://Assets/Cutscenes/epilog/2.png")
]

var textes = ["",
	"Oh, there you are. We couldn't find you because you were diving the whole time."]

var current_slide = 0

func _ready():
	show_slide(current_slide)
	timer.start()

func _on_Timer_timeout():
	current_slide += 1
	if current_slide < slides.size():
		show_slide(current_slide)
		timer.start()
	else:
		end_cutscene()

func show_slide(index):
	slide_viewer.texture = slides[index]
	$Label.text = textes[index]

func end_cutscene():
	get_tree().change_scene_to_file("res://Assets/Scenes/credits.tscn")
