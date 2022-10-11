extends Node

#Load game data
onready var BoardTiles : Array = get_node("Board").BoardTiles
onready var Potions : Array = get_node("Potions").Potions

#Groups names
var SpawnedPotionsGroup : String = "Spawned Potions"

#Arrays of instances
var SpawnedPotions : Array = []

func _ready():
	spawn_potions_on_board()
	SpawnedPotions = get_tree().get_nodes_in_group(SpawnedPotionsGroup)

func _process(_delta):
	print(SpawnedPotions.size())
	
func spawn_potions_on_board():
	for board_tile in BoardTiles:
		var new_potion : Node = Potions[randi() % 6].instance()
		
		new_potion.position = Vector2(board_tile["PositionX"] - 55, board_tile["PositionY"] + 10)
		new_potion.add_to_group(SpawnedPotionsGroup)
		
		$Potions.add_child(new_potion, true)
