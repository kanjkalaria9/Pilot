extends CharacterBody2D

# Movement
var speed := 200
var move_left := false
var move_right := false
var last_move_time := 0.0
var cooldown := 4.0

# Power level (set externally)
var power := 1

# Dodge effects
var dodge_shoot_active := false
var dodge_shield_active := false
var dodge_power_active := false
var dodge_effect_timer := 0.0

# Precognition flag
var precognition := true

func _ready():
	$LeftButton.connect("pressed", Callable(self, "_on_left_button_pressed"))
	$LeftButton.connect("released", Callable(self, "_on_left_button_released"))
	$RightButton.connect("pressed", Callable(self, "_on_right_button_pressed"))
	$RightButton.connect("released", Callable(self, "_on_right_button_released"))

func _physics_process(delta):
	var direction := 0

	# Input
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		direction -= 1
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		direction += 1
	if move_left:
		direction -= 1
	if move_right:
		direction += 1

	# Cooldown logic
	cooldown = max(0.0, 4.0 - (power - 1))
	var now := Time.get_ticks_msec() / 1000.0
	if direction != 0 and now - last_move_time >= cooldown:
		last_move_time = now
		velocity.x = direction * speed
		_on_dodge_triggered()
	else:
		velocity.x = 0

	move_and_slide()

func _on_dodge_triggered():
	if dodge_shoot_active:
		_fire_laser()
	if dodge_shield_active:
		_add_shield()
	if dodge_power_active:
		_add_overcharge()
	if power >= 6 and randi() % 2 == 0:
		print("Dodged incoming attack!")

func _fire_laser():
	print("Laser fired!")

func _add_shield():
	print("Shield gained!")

func _add_overcharge():
	print("Overcharge gained!")

# Button handlers
func _on_left_button_pressed():
	move_left = true

func _on_left_button_released():
	move_left = false

func _on_right_button_pressed():
	move_right = true

func _on_right_button_released():
	move_right = false

# Precognition dodge (call this when hit is detected)
func precognition_dodge():
	if precognition:
		var left_or_right := randi() % 2
		if left_or_right == 0:
			position.x = 0
		else:
			position.x = get_viewport_rect().size.x - self.size.x
		print("Precognition dodge activated!")
