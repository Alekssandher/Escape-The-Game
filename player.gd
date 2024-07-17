extends CharacterBody2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@export var deathPrefab: PackedScene

@export var resetTimer := 1.0
@onready var respawnPosition := global_position

@onready var respawnTimer := $Timer as Timer

const gravidade = 600
var velocidade = 300

var dash_speed = 600
var dash_duration = 0.2
var dash_cooldown = 1.0
var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var isRunning = false
var has_jumped = false

const jump = -300

var respawnPoint = Vector2(0, 0)  # Ponto onde o jogador renascerá




func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravidade * delta
		if !has_jumped:
			animationPlayer.play("falling")
	else:
		has_jumped = false

	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump
		has_jumped = true
		animationPlayer.play("jumping")

	# Dash
	if Input.is_action_just_pressed("ctrl") and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown

	if is_dashing:
		animationPlayer.play("dash")
		if dash_timer > 0:
			dash_timer -= delta
			if sprite.flip_h:
				velocity.x = -dash_speed
			else:
				velocity.x = dash_speed
		else:
			is_dashing = false

	if !is_dashing:
		if Input.is_action_pressed("right"):
			velocity.x = velocidade
			if is_on_floor():
				animationPlayer.play("running")
			sprite.flip_h = false
			isRunning = true

		elif Input.is_action_pressed("left"):
			velocity.x = -velocidade
			if is_on_floor():
				animationPlayer.play("running")
			sprite.flip_h = true
			isRunning = true

		else:
			velocity.x = 0
			if is_on_floor():
				animationPlayer.play("idle")
			isRunning = false

	# Animação de pulo no ar
	if !is_on_floor() and !is_dashing and has_jumped:
		animationPlayer.play("jumping")
		isRunning = false

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("hasCollided"):
			collision.get_collider().hasCollided(collision, self)
			
func _on_area_2d_area_entered(area):
	print("colidiu")
	
	if area.is_in_group("objects"):
		if deathPrefab:
			#var deathObject = deathPrefab.instantiate()
			#deathObject.position = position
			#
			#get_parent().add_child(deathObject)
			
			position = respawnPosition
			
	if area.is_in_group("congrats"):
		get_tree().change_scene_to_file("res://congrats.tscn")

