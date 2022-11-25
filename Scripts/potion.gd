extends Node2D

onready var PotionTween = get_node("Tween")

#Potion States
var IsSelected : bool = false
var IsMovable : bool = false
var IsRemoveable : bool = false
var IsChosenToBeRemoved : bool = false
var IsRotten : bool = false

func _ready() -> void:
	pass

func _process(_delta) -> void:
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
		$NonSpriteAnimations.play("RemovablePotion")
	elif IsChosenToBeRemoved == false:
		$PotionBody/PotionToRmoveIndicator.hide()
		$NonSpriteAnimations.stop()

func move_potions(new_position : Vector2) -> void:
	if IsMovable:
		IsSelected = false
		IsMovable = false
		
		animation_handler()
		
		PotionTween.interpolate_property(self, "position", self.position, 
										new_position, 1, 
										Tween.TRANS_LINEAR, Tween.EASE_IN)
		PotionTween.start()

func hide_removable_potion():
	IsChosenToBeRemoved = false
	$PotionBody/HealthyPotionSprite.hide()
	
	removable_indicator_handler()

func get_new_texture_region() -> Rect2:
	var new_texture_region : Rect2 = $PotionBody/HealthyPotionSprite.get_region_rect()
	
	return new_texture_region

func show_new_potion(new_texture_region: Rect2) -> void:
	$PotionBody/HealthyPotionSprite.set_region_rect(new_texture_region)
	$PotionBody/HealthyPotionSprite.show()
	
