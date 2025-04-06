extends Control

@onready var oxygenBar: ProgressBar = $VBoxContainer/OxygenBar
@onready var healthBar: ProgressBar = $VBoxContainer/HealthBar
@onready var hungerBar: ProgressBar = $VBoxContainer/HungerBar

@onready var depthLabel: Label = $DepthLabel

func _ready():
	oxygenBar.max_value = Globals.oxygen
	healthBar.max_value = Globals.health
	hungerBar.max_value = Globals.hunger
	Equipment.init($Inventory/GridContainer)

func _process(delta):
	oxygenBar.value = Globals.oxygen
	healthBar.value = Globals.health
	hungerBar.value = Globals.hunger
	depthLabel.text = str(Globals.depth) + " METERS"
