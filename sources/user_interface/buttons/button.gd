extends Button
class_name AnimatedButton


signal animation_finished


func _ready() -> void:
	pivot_offset.x = size.x / 2
	pivot_offset.y = size.y / 2


func _on_pressed() -> void:
	$AnimationPlayer.play("pressed")
