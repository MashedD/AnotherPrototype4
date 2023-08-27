extends Node


var fade_out_speed: float = 0.1
var fade_in_speed: float = 0.1
var fade_out_pattern: String = "fade"
var fade_in_pattern: String = "fade"
var fade_out_smoothness = 0.1
var fade_in_smoothness = 0.1
var fade_out_inverted: bool = false
var fade_in_inverted: bool = false
var color: Color = Color(0, 0, 0)
var timeout: float = 0.0
var clickable: bool = false
var add_to_back: bool = true

@onready var fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
@onready var fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
@onready var general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)


func _ready() -> void:
	var fade_in_first_scene_options = SceneManager.create_options(0.2, "fade")
	var first_scene_general_options = SceneManager.create_general_options(Color(0, 0, 0), 1, false)
	SceneManager.show_first_scene(fade_in_first_scene_options, first_scene_general_options)
#	SceneManager.validate_scene(scenes.main_menu)
#	SceneManager.validate_scene(scenes.options)
#	SceneManager.validate_pattern(fade_out_pattern)
#	SceneManager.validate_pattern(fade_in_pattern)
