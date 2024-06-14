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
# tweened => _tweened
func update_health(new_value: int):
	#var tweened = healthbar_tween.interpolate_property(healthbar, "value", healthbar.value, new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	
	var tweened = healthbar_tween.set_ease(Tween.EASE_OUT)
	tweened.tween_property(healthbar_tween, "value", )



	tweened = healthbar_tween.start()

tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)

tween.bind_node($Platform)
tween.set_loops()
tween.set_ease(Tween.EASE_IN_OUT)
tween.tween_property(self, "follow", move_to, duration).from(Vector2.ZERO)
tween.tween_property(self, "follow", Vector2.ZERO, duration).from(move_to)

# signal connected to player
func _on_Player_hp_changed(new_hp):
	update_health(new_hp)

