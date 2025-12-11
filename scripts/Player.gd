extends RigidBody2D

@export var speed: float = 300.0

func _ready():
	# Initialize with a random direction
	call_deferred("change_direction")

func change_direction():
	var dir = Vector2.RIGHT.rotated(randf() * TAU)
	linear_velocity = dir * speed

func _on_body_entered(_body):
	# "The characters move by bouncing... choose a new random direction when they hit an obstacle"
	change_direction()
