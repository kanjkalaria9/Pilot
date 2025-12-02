extends Node2D

@export var MissileScene: PackedScene

func _on_SpawnTimer_timeout():
	var missile := MissileScene.instantiate()
	missile.position = Vector2(randi() % int(get_viewport_rect().size.x), -24)
	get_tree().current_scene.add_child(missile)

var move_left := false
var move_right := false
var speed := 260.0

func _physics_process(delta):
	var dir := 0.0
	if move_left: dir -= 1.0
	if move_right: dir += 1.0
	position.x += dir * speed * delta
	position.x = clamp(position.x, 24, get_viewport_rect().size.x - 24)
