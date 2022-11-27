extends Control

var IsRotPotioRemoved: bool = false

func _ready() -> void:
	pass

func _process(_delta) -> void:
	if int($ScoreLabel/Points.text) >= 7:
		$Button.disabled = false
	if int($ScoreLabel/Points.text) < 7:
		$Button.disabled = true
	
func set_score(score: int) -> void:
	$ScoreLabel/Points.set_text(str(score))

func _on_Button_pressed() -> void:
	$ClickSound.play()
	IsRotPotioRemoved = true
