extends "res://overlap/Hitbox.gd"

#@export (float) var knockback_modifier: float = 0.1
#@export (bool) var is_knockback: bool = true

@export var knockback_modifier = float(0.1)
@export var is_knockback = bool(true)

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	animation_player.play("pierce")

func collide(body: CharacterBody2D):
	var knockback_direction = (body.global_position - global_position).normalized()
	var knockback_strength = damage * knockback_modifier                 # force
	var knockback = knockback_direction * knockback_strength             # vector
	body.receive_damage(5)
	global_position += knockback # new position
