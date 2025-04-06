extends Control

@onready var oxygenBar: ProgressBar = $VBoxContainer/OxygenBar
@onready var healthBar: ProgressBar = $VBoxContainer/HealthBar
@onready var hungerBar: ProgressBar = $VBoxContainer/HungerBar

@onready var depthLabel: Label = $DepthLabel
@onready var scrapLabel: Label = $ScrapLabel

@onready var infoLabel: Label = $InfoLabel

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
	
	if infoLabel.text != "" and Globals.show_annoucement:
		$Timer.start()
		Globals.show_annoucement = false
		
	if Globals.oxygen == 49:
		Globals.show_annoucement = true
		infoLabel.text = "Oxygen level is below 50. You should swim to the surface"
		
	if Globals.hunger == 49:
		Globals.show_annoucement = true
		infoLabel.text = "You are hungy. You should get some fish"
		
	if Globals.score == 1 or Globals.score == 2:
		Globals.show_annoucement = true
		infoLabel.text = "You found an item necessary to repair the scooter"
		
	if Globals.score == 3:
		Globals.show_annoucement = true
		infoLabel.text = "You found all the items needed to fix the scooter. Return to the surface"
		
func updateOxygenBar():
	oxygenBar.max_value = Globals.oxygen


func _on_timer_timeout():
	infoLabel.text = ""
