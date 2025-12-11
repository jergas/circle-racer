extends Node

@onready var ui_label = $CanvasLayer/Label
# We look for the Goal node dynamically to connect the signal
func _ready():
	var goal = find_child("Goal", true, false)
	if goal:
		goal.connect("goal_reached", Callable(self, "_on_goal_reached"))

func _on_goal_reached():
	ui_label.visible = true
	# Optional: Restart level after a few seconds?
	# For now just showing the notification.
