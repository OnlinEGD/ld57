extends Control

@onready var oxygenBar: ProgressBar = $VBoxContainer/OxygenBar
@onready var healthBar: ProgressBar = $VBoxContainer/HealthBar
@onready var hungerBar: ProgressBar = $VBoxContainer/HungerBar

@onready var depthLabel: Label = $DepthLabel
@onready var scrapLabel: Label = $ScrapLabel

func _ready():
	oxygenBar.max_value = Globals.oxygen
	healthBar.max_value = Globals.health
	hungerBar.max_value = Globals.hunger
	$"../../Scooter".connect("oxygenSet", updateOxygenBar)

func _process(_delta):
	oxygenBar.value = Globals.oxygen
	healthBar.value = Globals.health
	hungerBar.value = Globals.hunger
	depthLabel.text = str(Globals.depth) + " METERS"
	scrapLabel.text = "Scrap: " + str(Globals.scrap)

func updateOxygenBar():
	oxygenBar.max_value = Globals.oxygen
