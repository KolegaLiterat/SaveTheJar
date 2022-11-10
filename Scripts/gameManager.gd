extends Node

#Load game data
onready var BoardTiles : Array = get_node("Board").BoardTiles
onready var Potions : Array = get_node("Potions").Potions

#Groups names
var SpawnedPotionsGroup : String = "Spawned Potions"

#Arrays of instances
var SpawnedPotions : Array = []
var SelectedPotions : Array = []

func _ready():
	spawn_potions_on_board()
	SpawnedPotions = get_tree().get_nodes_in_group(SpawnedPotionsGroup)
	
	if !validate_spawn_potions_count():
		print("Missing spawned potions! Check potions scence!")
	
func _process(_delta):
	potions_selection()
	
func spawn_potions_on_board():
	for board_tile in BoardTiles:
		var new_potion : Node = Potions[randi() % 6].instance()
		
		new_potion.position = Vector2(board_tile["PositionX"] - 55, board_tile["PositionY"] + 10)
		new_potion.add_to_group(SpawnedPotionsGroup)
		
		$Potions.add_child(new_potion, true)

func potions_selection():
	
	for potion in SpawnedPotions:
		if potion.IsSelected == true:
			change_potion_selection(potion)

func validate_spawn_potions_count() -> bool:
	var are_potions_spawned : bool = false
	
	if SpawnedPotions.size() > 0:
		are_potions_spawned = true
		
	return are_potions_spawned

func change_potion_selection(selected_potion : Node):
	if SelectedPotions.size() < 2:
		if SelectedPotions.has(selected_potion) == false:
			SelectedPotions.append(selected_potion)
	if SelectedPotions.size() == 2:
		if SelectedPotions.has(selected_potion) == false:
			SelectedPotions[0].IsSelected = false
			SelectedPotions[0].animation_handler()
			SelectedPotions[0] = SelectedPotions[1]
			SelectedPotions.remove(1)
