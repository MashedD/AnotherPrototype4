@tool
extends AnimatedButton


@export var scene_name: String


func _on_animation_finished():
	SceneManager.change_scene(
		scene_name,
		SceneManagerGlobals.fade_out_options,
		SceneManagerGlobals.fade_in_options,
		SceneManagerGlobals.general_options)


func _get_configuration_warnings():
	return "scene_name is not set" if scene_name == "" else ""
