extends Node2D

onready var PotionsCount : int =  get_child_count()
var Potions : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Potions = preload_potion_scenes()


func preload_potion_scenes() -> Array:
	var potions : Array = []
	var template_scene_path : String = "res://Scenes/potion%s.tscn"
	
	for i in range(PotionsCount):
		var scene_path : String = template_scene_path % i
		potions.append(load(scene_path))
	
	return potions
