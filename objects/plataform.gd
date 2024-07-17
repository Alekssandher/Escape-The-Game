extends AnimatableBody2D

@onready var anim := $AnimationPlayer as AnimationPlayer
@onready var respawnTimer := $Timer as Timer
@onready var respawnPosition := global_position

@export var resetTimer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isTriggered := false

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

func hasCollided(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !isTriggered:
		isTriggered = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_animation_player_animation_finished(anim_name):
	set_physics_process(true)
	respawnTimer.start(resetTimer)


func _on_timer_timeout():
	set_physics_process(false)
	global_position = respawnPosition
	#if isTriggered: 
		#var spawnTween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		#spawnTween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))
	isTriggered = false
