extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_RigidBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
