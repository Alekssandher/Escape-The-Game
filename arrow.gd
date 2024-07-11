extends Area2D

var direction: Vector2 = Vector2.ZERO
var gravidade = 1

func _ready() -> void:
	randomize()
	
	direction = global_position.direction_to(get_global_mouse_position())
	
	var angle = direction.angle()
	rotation_degrees = rad_to_deg(angle)

func _physics_process(delta):
	translate(direction * delta * 700)
	


