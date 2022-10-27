extends Area2D

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += transform.x * speed

func _on_Bullet_area_entered(area):
	if area.is_in_group('player'):
		queue_free()
