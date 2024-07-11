extends Node2D

@onready var bow: Sprite2D = get_node("bow")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
const ARROW: PackedScene = preload("res://arrow.tscn")

var isAttacking: bool = false

func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and not isAttacking:
		animation.play("attack")
		isAttacking = true
		
		pass

func spawnArrow() -> void:
	var arrow = ARROW.instantiate()
	arrow.global_position = global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", arrow)
	
func animate(attackDirection: Vector2, direction: Vector2):
	if attackDirection.x > 0:
		bow.flip_v = false
	if attackDirection.x < 0:
		bow.flip_v = true
		
	look_at(direction)


func _on_animation_player_animation_finished(anim_name):
	isAttacking = false
	pass # Replace with function body.
