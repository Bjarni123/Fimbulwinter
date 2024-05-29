extends Node2D

var crosshair = preload("res://assets/Player/Gun/Crosshair/crosshair.png")
var enemies_count

func _ready():
	#Input.set_custom_mouse_cursor(null) # mouse cursor default
	# Change mouse cursor
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
	
	#Globals.connect("killed", self, "enemy_count")
	enemies_count = $Enemies.get_child_count()
	Globals.enemies_total = enemies_count	
	MusicTitleScreen.stop()
	$MusicLevel.play()
	var level_name = get_tree().current_scene.name
	print(level_name)
	

func _on_Player_died():
	$GameOverScreen.visible = true
