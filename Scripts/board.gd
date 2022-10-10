extends Node2D

onready var BoardTilesCount : int =  get_child_count()

# Called when the node enters the scene tree for the first time.
func _ready():
	tests()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func tests():
	if !validate_tiles_count():
		print("Missing board! Verify BOARD object!")
	
func validate_tiles_count() -> bool:
	var is_board_created : bool = true

	if BoardTilesCount == 0:
		is_board_created = false
	
	return is_board_created
		
