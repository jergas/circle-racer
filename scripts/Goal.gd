extends Area2D

signal goal_reached

func _on_body_entered(_body):
	# Assuming the only physics body moving is the Player
	# A more robust check: if body.is_in_group("player") or body.name == "Player"
	emit_signal("goal_reached")
