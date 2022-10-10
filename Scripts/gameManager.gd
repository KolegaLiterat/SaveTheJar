extends Node

onready var BoardTiles : Array = get_node("Board").BoardTiles
onready var Potions : Array = get_node("Potions").Potions
# Called when the node enters the scene tree for the first time.
func _ready():
	print(Potions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
