extends Control

func _ready():
	pass


func _process(delta):
	pass
	
func set_score(score: int):
	$ScoreLabel/Points.set_text(str(score))
