extends Node2D

onready var PotionTween = get_node("Tween")
var IsSelected : bool = false
var IsMovable : bool = false
var IsRemoveable : bool = false
var IsChosenToBeRemoved : bool = false
var IsRotten : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_PotionBody_input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if IsSelected == false:
			IsSelected = true
			animation_handler()
		elif IsSelected == true:
			IsSelected = false
			animation_handler()

func animation_handler() -> void:
	if IsSelected == true:
		$PotionBody/SelectAnimation.show()
		$PotionBody/SelectAnimation.play()
	elif IsSelected == false:
		$PotionBody/SelectAnimation.hide()
		$PotionBody/SelectAnimation.stop()
		
func removable_indicator_handler() -> void:
	if IsChosenToBeRemoved == true:
		$PotionBody/PotionToRmoveIndicator.show()
	elif IsChosenToBeRemoved == false:
		$PotionBody/PotionToRmoveIndicator.hide()

func move_potions(new_position : Vector2) -> void:
	if IsMovable:
		IsSelected = false
		IsMovable = false
		
		animation_handler()
		
		PotionTween.interpolate_property(self, "position", self.position, 
										new_position, 1, 
										Tween.TRANS_LINEAR, Tween.EASE_IN)
		PotionTween.start()
