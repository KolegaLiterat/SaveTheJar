extends Control

func _ready():
	pass


func _process(_delta):
	if int($ScoreLabel/Points.text) >= 1:
		$Button.disabled = false
	
func set_score(score: int):
	$ScoreLabel/Points.set_text(str(score))
