extends Node

#Load game data
onready var BoardTiles : Array = get_node("Board").BoardTiles
onready var Potions : Array = get_node("Potions").Potions
onready var GUI : Control = get_node("GUI")
#Groups names
var SpawnedPotionsGroup : String = "Spawned Potions"

#Min Max Values for moveable check
var MinPosX : int = -80 
var MinPosY : int = -45

#Arrays of instances
var SpawnedPotions : Array = []
var SelectedPotions : Array = []
var RemovedPotions : Array = []

var Score : int = 0

func _ready() -> void:
	spawn_potions_on_board()
	SpawnedPotions = get_tree().get_nodes_in_group(SpawnedPotionsGroup)
	
	if !validate_spawn_potions_count():
		print("Missing spawned potions! Check potions scence!")
	
	$NextPotionTimer.start()
	$NewPotionTimer.start()
	
func _process(_delta) -> void:
	potions_selection()
	animate_movement()
	remove_potion_form_board()
	
func spawn_potions_on_board():
	for board_tile in BoardTiles:
		var new_potion : Node = Potions[randi() % 6].instance()
		
		new_potion.position = Vector2(board_tile["PositionX"] - 55, board_tile["PositionY"] + 10)
		new_potion.add_to_group(SpawnedPotionsGroup)
		
		$Potions.add_child(new_potion, true)

func potions_selection() -> void:
	for potion in SpawnedPotions:	
		if potion.IsSelected == true:
			change_potion_selection(potion)
			remove_unselected_potion()

func validate_spawn_potions_count() -> bool:
	var are_potions_spawned : bool = false
	
	if SpawnedPotions.size() > 0:
		are_potions_spawned = true
		
	return are_potions_spawned

func change_potion_selection(selected_potion : Node) -> void:
	if SelectedPotions.size() < 2:
		if SelectedPotions.has(selected_potion) == false:
			SelectedPotions.append(selected_potion)
	if SelectedPotions.size() == 2:
		if SelectedPotions.has(selected_potion) == false:
			SelectedPotions[0].IsSelected = false
			SelectedPotions[0].animation_handler()
			SelectedPotions[0] = SelectedPotions[1]
			SelectedPotions.remove(1)

func remove_unselected_potion() -> void:
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

func animate_movement() -> void:
	if SelectedPotions.size() == 2:		
		var x_diff : int = SelectedPotions[0].position.x - SelectedPotions[1].position.x
		var y_diff : int = SelectedPotions[0].position.y - SelectedPotions[1].position.y
		
		set_potions_moveable(x_diff, y_diff)
		
		SelectedPotions[0].move_potions(SelectedPotions[1].position)
		SelectedPotions[1].move_potions(SelectedPotions[0].position)
		
		score_update(SelectedPotions[0].ScoreModificator + SelectedPotions[1].ScoreModificator)
		
		remove_unselected_potion()

func set_potions_moveable(x_diff: int, y_diff: int) -> void:
	if is_potion_movable(x_diff, 'x') and is_potion_movable(y_diff, 'y'):
			for potion in SelectedPotions:
				potion.IsMovable = true

func set_potion_to_remove() -> void:
	var potion_to_remove: Node2D = SpawnedPotions[rand_range(0, SpawnedPotions.size())]
	
	if RemovedPotions.has(potion_to_remove) == false:
		if potion_to_remove.IsRemoveable == true or potion_to_remove.IsChosenToBeRemoved == true or potion_to_remove.IsRotten == true:
			set_potion_to_remove()
		else:
			potion_to_remove.IsChosenToBeRemoved = true
			potion_to_remove.removable_indicator_handler()
		
func get_number_of_removeable_potions() -> int:
	var number_of_removable_potions : int = 0 
	
	for potion in SpawnedPotions:
		if potion.IsChosenToBeRemoved == true:
			number_of_removable_potions = number_of_removable_potions + 1
	
	return number_of_removable_potions

func remove_potion_form_board() -> void:
	for potion in SpawnedPotions:
		if potion.IsRemoveable == true and potion.IsChosenToBeRemoved == true:
			potion.hide_removable_potion()
			RemovedPotions.append(potion)
			
			score_update(1)
			potion.stop_rot_timer()

func add_new_potion():
	var new_potion : Node = Potions[randi() % 6].instance()
	var index_for_potion = SpawnedPotions.find(RemovedPotions[0])
	
	SpawnedPotions[index_for_potion].show_new_potion(new_potion.get_new_texture_region())
	
	RemovedPotions.pop_front()
	
	new_potion.queue_free()

func score_update(modificator: int):
	Score = Score + modificator
	GUI.set_score(Score)
	
func _on_NextPotionTimer_timeout() -> void:
	$NextPotionTimer.set_wait_time(rand_range(3.0, 5.0))
	
	if get_number_of_removeable_potions() < 10:
		set_potion_to_remove()

func _on_NewPotionTimer_timeout():
	$NewPotionTimer.set_wait_time(rand_range(3.0, 10.0))
	
	if RemovedPotions.size() > 0:
		add_new_potion()
