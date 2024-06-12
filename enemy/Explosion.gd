extends Node2D

@onready var camera_shake: Node = get_tree().current_scene.get_node("Player/Camera3D/Camera2D/ScreenShake")

func _ready():
	#camera_shake.start(Callable(8, 0.4).bind(15))
	camera_shake.start(8, 0.4, 15)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
