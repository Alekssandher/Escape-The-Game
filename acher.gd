extends CharacterBody2D

@export var speed: float = 256

#@onready var animation: AnimationPlayer = get_node("AnimationPlayer")

@onready var texture: Sprite2D = get_node("Texture")
@onready var hand: Node2D = get_node("hand")

func _physics_process(delta):
	move()
	#animate()
	hand.animate(getDirection(), getMousePosition())
func move():
	var direction: Vector2 = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	velocity = direction * speed
	move_and_slide()

func anim():
	if getDirection().x > 0:
		texture.flip_h = false
	if getDirection().x < 0:
		texture.flip_h = true
	
	
	#Preparação para animações
	
	#if velocity != Vector2.ZERO:
		#animation.play("walk")
		#return
	#animation.play("idle")
func getDirection():
	return global_position.direction_to(getMousePosition())
	
func getMousePosition():
	return get_global_mouse_position()
