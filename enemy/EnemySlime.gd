extends Entity

var path: PackedVector2Array
var target = null
@export var enemy_velocity = 2

#@onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
@onready var navigation: Node2D = get_tree().current_scene.get_node("Node2D")
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player")

func _process(_delta):
	if hp > 0:
		chase()
	else:
		enemy_velocity = 0		

func _on_EnemySlime_died():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	enemy_velocity = 0
	anim_player.play("death")
	if not $SFXDied.is_playing():
		$SFXDied.play()

func _on_EnemySlime_hp_changed(_new_hp):
	if self.hp > 0:
		anim_player.play("hit")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		Globals.enemy_killed()
		queue_free()
	elif anim_name == "hit":
		anim_player.play("move")

func chase():
	# if there is a path and a target, the enemy will chase player
	if path and target:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		
		# pop the point from array when reached
		if distance_to_next_point < enemy_velocity: 
			#path.remove(0)
			path.remove_at(0)
			if not path:
				return # if there are no points left, return
		move_direction = vector_to_next_point
		
		# Animations
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

func _on_PathTimer_timeout():
	if player:
		path = navigation.get_simple_path(global_position, player.position)
	elif not player:
		return

func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "death":
		enemy_velocity = 0
