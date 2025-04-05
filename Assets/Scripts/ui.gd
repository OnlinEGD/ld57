extends Control

@onready var oxygenBar: ProgressBar = $VBoxContainer/OxygenBar

func _ready():
	oxygenBar.max_value = Globals.oxygen

func _process(delta):
	oxygenBar.value = Globals.oxygen
