extends Control

@onready var ingredients_container = $Ingredients
@onready var result_label = $ResultLabel

var available_ingredients = {}

func craft_item(recipe: Recipe):
	if can_craft(recipe):
		for ingredient_name in recipe.ingredients.keys():
			available_ingredients[ingredient_name] -= recipe.ingredients[ingredient_name]
		Equipment.add_item(recipe.result)
		result_label.text = "Crafted: " + recipe.result
	else:
		result_label.text = "Not enough ingredients!"
	
func can_craft(recipe: Recipe) -> bool:
	for ingredient_name in recipe.ingredients.keys():
		if available_ingredients.get(ingredient_name, 0) < recipe.ingredients[ingredient_name]:
			return false
	return true

func initialize_ingredients(ingredients: Dictionary):
	available_ingredients = ingredients
	var label = Label.new()
	for name in available_ingredients.keys():
		print(name)
		label.text = name + " "
		ingredients_container.add_child(label)
		
