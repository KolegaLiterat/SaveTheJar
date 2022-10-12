extends Node2D


var IsSelected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_RigidBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if IsSelected == false:
			IsSelected = true
			animation_handler()
		elif IsSelected == true:
			IsSelected = false
			animation_handler()

func animation_handler() -> void:
	if IsSelected == true:
		$RigidBody2D/AnimatedSprite.show()
		$RigidBody2D/AnimatedSprite.play()
	elif IsSelected == false:
		$RigidBody2D/AnimatedSprite.hide()
		$RigidBody2D/AnimatedSprite.stop()
