extends Node2D

onready var BoardTilesCount : int =  get_child_count()
var BoardTiles : Array = []
var PotionsToRemove : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if !validate_tiles_count():
		print("Missing board! Verify BOARD object!")
	else:
		BoardTiles = get_all_board_tiles()
		
#func _process(delta):
#	pass
	
func validate_tiles_count() -> bool:
	var is_board_created : bool = true

	if BoardTilesCount == 0:
		is_board_created = false
	
	return is_board_created

func get_all_board_tiles() -> Array:
	var board_tiles : Array = []
	
	for i in range(BoardTilesCount):
		var tile = {
			"TileName"	: get_child(i).name,
			"PositionX" : get_child(i).position.x,
			"PositionY"	: get_child(i).position.y,
		}

		board_tiles.append(tile)

	return board_tiles


func _on_Endline_body_entered(body):
	PotionsToRemove.append(body.get_parent())

func _on_Endline_body_exited(body):
	PotionsToRemove.erase(body.get_parent())
