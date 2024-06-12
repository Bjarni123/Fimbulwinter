extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween. EASE_IN_OUT

#@export (float) var frequency = 15.0
#@export (int) var amplitude = 8
#@export (float) var duration = 0.2
@export var frequency = float(15)
@export var amplitude = int(8)
@export var duration = float(0.2)


@onready var camera = get_parent()

# shake effect
func start(ampl, dur, freq):
	self.amplitude = ampl
	$Duration.wait_time = dur
	$Frequency.wait_time = 1 / float(freq)
	$Duration.start()
	$Frequency.start()
	newShake()

func newShake():
	# define vector to move the camera
	var rand = Vector2()
	rand.x = randf_range(-amplitude, amplitude)
	rand.y = randf_range(-amplitude, amplitude)

	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _on_Frequency_timeout():
	newShake()

func _on_Duration_timeout():
	reset()
	$Frequency.stop()
