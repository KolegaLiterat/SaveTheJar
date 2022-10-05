extends Node2D

var BoardTilesCount : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BoardTilesCount = get_child_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func tests():
	pass
	
func validate_tiles_count() -> bool:
	is_board_created = 
