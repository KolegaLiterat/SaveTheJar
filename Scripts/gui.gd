extends Control

var IsRotPotioRemoved = false

func _ready():
	pass

func _process(_delta):
	if int($ScoreLabel/Points.text) >= 7:
		$Button.disabled = false
	if int($ScoreLabel/Points.text) < 7:
		$Button.disabled = true
	
func set_score(score: int):
	$ScoreLabel/Points.set_text(str(score))

func _on_Button_pressed():
	IsRotPotioRemoved = true
