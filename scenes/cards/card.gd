extends CharacterBody3D

signal pressed_card(card)

@export var index: = 0
@export var front_index: = 0

@onready var animation_player: = $AnimationPlayer
@onready var pivot: = $Pivot


func _ready() -> void:
	add_to_group("cards")


func _on_input_event(_camera: Node, event: InputEvent,
		_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
			and event.pressed \
			and not animation_player.is_playing():
		emit_signal("pressed_card", self)


func flip():
	animation_player.play("flip")


func unflip():
	animation_player.play("unflip")


func wrong_match():
	animation_player.play("wrong_match")
	await animation_player.animation_finished
	animation_player.play("unflip")


func disappear():
	animation_player.play("disappear")
	await animation_player.animation_finished
	visible = false

#func reset():
#	visible = true
#	pivot.scale = Vector3(1.0, 1.0, 1.0)
#	pivot.rotation_degrees = Vector3()
#	animation_player.play("RESET")
#
#
#func fast_hide():
#	visible = false
