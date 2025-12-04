extends Node2D

var score := 0

func _ready():
	$ResetButton.visible = false
	$ScoreLabel.text = "Score: 0"

func _on_BoostButton_pressed():
	score += 1
	_update_score()

func _on_ShieldButton_pressed():
	score += 1
	_update_score()

func _update_score():
	$ScoreLabel.text = "Score: %d" % score
	if score >= 10:
		$ScoreLabel.text = "You Win!"
		$BoostButton.disabled = true
		$ShieldButton.disabled = true
		$ResetButton.visible = true

func _on_ResetButton_pressed():
	score = 0
	$ScoreLabel.text = "Score: 0"
	$BoostButton.disabled = false
	$ShieldButton.disabled = false
	$ResetButton.visible = false
