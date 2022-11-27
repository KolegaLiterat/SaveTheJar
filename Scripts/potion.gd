extends Node2D

#Tween for potion
onready var PotionTween = get_node("Tween")

#Potion States
var IsSelected : bool = false
var IsMovable : bool = false
var IsRemoveable : bool = false
var IsChosenToBeRemoved : bool = false
var IsRotten : bool = false

#Score modificator for movement:
var ScoreModificator: int = 0

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
		$RotPotion.start()
	elif IsChosenToBeRemoved == false:
		$PotionBody/PotionToRmoveIndicator.hide()
		$NonSpriteAnimations.stop()

func move_potions(new_position : Vector2) -> void:
	ScoreModificator = 0
	
	if IsMovable:
		if IsRotten == true:
			ScoreModificator = ScoreModificator - 1
			
		IsSelected = false
		IsMovable = false
		
		animation_handler()
		
		PotionTween.interpolate_property(self, "position", self.position, 
										new_position, 0.5, 
										Tween.TRANS_LINEAR, Tween.EASE_IN)
		PotionTween.start()
		
		yield(PotionTween, "tween_completed")
			
func hide_removable_potion() -> void:
	IsChosenToBeRemoved = false
	
	removable_indicator_handler()
	
	$NonSpriteAnimations.play("FadeOut")
	yield($NonSpriteAnimations, "animation_finished")
	
	$PotionBody/HealthyPotionSprite.hide()
	
func get_new_texture_region() -> Rect2:
	var new_texture_region : Rect2 = $PotionBody/HealthyPotionSprite.get_region_rect()
	
	return new_texture_region

func show_new_potion(new_texture_region: Rect2) -> void:
	$PotionBody/HealthyPotionSprite.set_region_rect(new_texture_region)
	
	$NonSpriteAnimations.play("FadeIn")
	
	$PotionBody/HealthyPotionSprite.modulate.a = 0
	$PotionBody/HealthyPotionSprite.show()
	
	yield($NonSpriteAnimations, "animation_finished")

func rotten_indicator_hadlder():
	if IsRotten == true:
		$PotionBody/RotPotionIndicator.show()
		$NonSpriteAnimations.play("RotPotion")
	elif IsRotten == false:
		heal_potion()
		$PotionBody/RotPotionIndicator.hide()
		$NonSpriteAnimations.stop()
		
func transformation_animation_handler() -> void:
	$PotionBody/TransformAnimation.show()
	$PotionBody/TransformAnimation.play("Transformation")
	
	yield($PotionBody/TransformAnimation, "animation_finished")
	
	$PotionBody/TransformAnimation.hide()

func heal_potion() -> void:
	$RotPotion.stop()
	$PotionBody/HealthyPotionSprite.show()
	$PotionBody/RotPotionSprite.hide()
	
func stop_rot_timer() -> void:
	$RotPotion.stop()

func rot_potion() -> void:
	IsRotten = true
	
	$PotionBody/HealthyPotionSprite.hide()
	$PotionBody/RotPotionSprite.show()
	
	if IsChosenToBeRemoved == true:
		IsChosenToBeRemoved = false
		removable_indicator_handler()
	
	rotten_indicator_hadlder()
	transformation_animation_handler()
	
func _on_RotPotion_timeout() -> void:
	rot_potion()
	
