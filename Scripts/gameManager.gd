extends Node

#Load game data
onready var BoardTiles : Array = get_node("Board").BoardTiles
onready var Potions : Array = get_node("Potions").Potions

#Groups names
var SpawnedPotionsGroup : String = "Spawned Potions"

#Min Max Values for moveable check
var MinPosX : int = -80 
var MinPosY : int = -45

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
	
	if SelectedPotions.size() == 2:		
		var x_diff : int = SelectedPotions[0].position.x - SelectedPotions[1].position.x
		var y_diff : int = SelectedPotions[0].position.y - SelectedPotions[1].position.y
		
		if is_potion_movable(x_diff, 'x') and is_potion_movable(y_diff, 'y'):
			for potion in SelectedPotions:
				potion.IsMovable = true
			
			var potion_0_position : Vector2 = SelectedPotions[0].position
			var potion_1_position : Vector2 = SelectedPotions[1].position
			
			SelectedPotions[0].move_potions(potion_0_position, potion_1_position)
			SelectedPotions[1].move_potions(potion_1_position, potion_0_position)
			
		remove_unselected_potion()	

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
			remove_unselected_potion()

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

func remove_unselected_potion():
	for potion in SelectedPotions:
		if potion.IsSelected == false:
			SelectedPotions.erase(potion)

func is_potion_movable(position_diff: int, position_axis: String) -> bool:
	var is_movable = false
	
	if position_axis == 'x':
		if position_diff >= MinPosX and position_diff <= MinPosX * -1:
			# x_diff needs to be between -80 and 80
			is_movable = true
	elif position_axis == 'y':
		if position_diff >= MinPosY and position_diff <= MinPosY * -1:
			# y_diff needs to be between -45 and 45
			is_movable = true
	
	return is_movable
