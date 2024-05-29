extends CanvasLayer

var max_hp: int = 100

@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var healthbar: TextureProgressBar = get_node("HealthBar")
@onready var healthbar_tween = get_node("HealthBar/Tween")
@onready var kills_counter = get_node("KillsCounter")

func _ready():
	max_hp = player.hp
	update_health(max_hp)

# function to update player´s life
func update_health(new_value: int):
	var tweened = healthbar_tween.interpolate_property(healthbar, "value", healthbar.value, new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tweened = healthbar_tween.start()

# signal connected to player
func _on_Player_hp_changed(new_hp):
	update_health(new_hp)

