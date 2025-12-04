extends Node2D

var score := 0
@export var speed := 260.0

var move_left := false
var move_right := false

var server_ip = "10.184.1.88"
var role = "pilot"
var team = "tech"

func _ready():
	$Panel/ResetButton.visible = false
	#$ScoreLabel.text = "Score: 0"
	SpaceApi.server_connect(server_ip, role, team)

func _physics_process(delta):
	var dir := 0.0
	if move_left: dir -= 1.0
	if move_right: dir += 1.0
	position.x += dir * speed * delta
	position.x = clamp(position.x, 24, get_viewport_rect().size.x - 24)

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

	
	
	


func _on_left_button_pressed() -> void:
	SpaceApi.move("left")


func _on_right_button_pressed() -> void:
	SpaceApi.move("right")


func _on_special_button_pressed() -> void:
	SpaceApi.special()


func _on_precognition_button_pressed() -> void:
	SpaceApi.precognition()
