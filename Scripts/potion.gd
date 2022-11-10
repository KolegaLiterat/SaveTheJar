extends Node2D


var IsSelected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_Body_input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if IsSelected == false:
			IsSelected = true
			animation_handler()
		elif IsSelected == true:
			IsSelected = false
			animation_handler()

func animation_handler() -> void:
	if IsSelected == true:
		$Body/AnimatedSprite.show()
		$Body/AnimatedSprite.play()
	elif IsSelected == false:
		$Body/AnimatedSprite.hide()
		$Body/AnimatedSprite.stop()

func move_potions() -> void:
	var tween = get_node("Tween")
	print("test")
	tween.interpolate_property(self, "position", Vector2(100, 100), Vector2(200, 200), 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
