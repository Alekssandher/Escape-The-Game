extends CharacterBody2D

var gravidade = 10

var velocidade = 300
var gas = 100
func _process(delta):
	
	if !is_on_floor():
		velocity.y += gravidade
		
	
		
	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y -= 300
	
		
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.show()
		velocity.x = velocidade
		$AnimatedSprite2D.flip_h = false
		$Sprite2D.flip_h = false
		$AnimatedSprite2D.play("default")
	elif Input.is_action_pressed("left"):
		velocity.x = -velocidade
		$AnimatedSprite2D.flip_h = true
		$Sprite2D.flip_h = true
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("default")
		
	elif Input.is_action_pressed("attack"):
		$AnimatedSprite2D.hide()
		$Sprite2D.show()
		$Sprite2D/AnimationPlayer.play("shoot")
		
		
	else:
		$AnimatedSprite2D.show()
		$Sprite2D.hide()
		velocity.x = 0
		$AnimatedSprite2D.play("new_animation")
	
	if !is_on_floor() and Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("new_animation")
	if !is_on_floor() and Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("new_animation")
	
	move_and_slide()  
	

