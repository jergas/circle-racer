extends RigidBody2D

func _ready():
	# Initialize with a random direction
	call_deferred("change_direction")

func change_direction():
	var dir = Vector2.RIGHT.rotated(randf() * TAU)
	linear_velocity = dir * GameConfig.player_speed

func _on_body_entered(_body):
	# "The characters move by bouncing... choose a new random direction when they hit an obstacle"
	change_direction()

func _integrate_forces(state):
	# Enforce constant speed
	if state.linear_velocity.length() > 0:
		state.linear_velocity = state.linear_velocity.normalized() * GameConfig.player_speed
