extends Area2D

const speed := 500
var velocity := Vector2.ZERO
var direction := Vector2.ZERO
var gravidade = 1

func _ready():
	pass

func _physics_process(delta):
	velocity = direction * speed * delta
	translate(velocity)
	
	velocity.y += gravidade

func setDirection(dir):
	direction = dir
