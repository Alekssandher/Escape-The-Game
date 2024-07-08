extends CharacterBody2D

const bullet := preload("res://shoot.tscn")
var gravidade = 10

var velocidade = 300
var gas = 100

var dash_speed = 600
var dash_duration = 0.2
var dash_cooldown = 1.0
var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0

func _process(delta):
	if !is_on_floor():
		velocity.y += gravidade

	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y -= 300

	# Dash
	if Input.is_action_just_pressed("ctrl") and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown

	if is_dashing:
		if dash_timer > 0:
			dash_timer -= delta
			if $Sprite2D.flip_h:
				velocity.x = -dash_speed
			else:
				velocity.x = dash_speed
		else:
			is_dashing = false

	# Attack
	if Input.is_action_just_pressed("attack"):
		var shootInstance = bullet.instantiate()

		# Calcular a direção do mouse
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		
		shootInstance.setDirection(direction)

		get_parent().add_child(shootInstance)
		shootInstance.position = global_position

	if !is_dashing:
		if Input.is_action_pressed("right"):
			velocity.x = velocidade
			$Sprite2D.flip_h = false

			if sign($Marker2D.position.x) == -1:
				$Marker2D.position.x *= -1
		elif Input.is_action_pressed("left"):
			velocity.x = -velocidade
			$Sprite2D.flip_h = true

			if sign($Marker2D.position.x) == 1:
				$Marker2D.position.x *= -1
		else:
			velocity.x = 0

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	move_and_slide()
