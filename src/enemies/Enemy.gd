extends KinematicBody2D

onready var player = get_node('/root/Background/Player')
const SPEED = 100

func _physics_process(delta):
	if player:
		var player_direction = (player.position - self.position).normalized()
		move_and_slide(SPEED * player_direction)

func fire(player_direction):
	var bullet = preload("res://src/objects/EnemyBullet.tscn").instance()
	bullet.set_as_toplevel(true)
	bullet.global_position = position
	add_child(bullet)
	bullet.look_at(player_direction)

func _on_Area2D_area_entered(area):
	if area.is_in_group("player_bullet"):
		queue_free()

func _on_Timer_timeout():
	if player:
		fire(player.position)
