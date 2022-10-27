extends Area2D

export var speed = 500
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_just_pressed("fire"):
		fire()

func fire():
	var bullet = preload("res://src/objects/Bullet.tscn").instance()
	bullet.set_as_toplevel(true)
	bullet.global_position = position
	add_child(bullet)
	bullet.look_at(get_global_mouse_position())

func _on_Player_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("enemy_bullet"):
		hide()
