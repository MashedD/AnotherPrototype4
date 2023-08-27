extends Node


func get_materials(path) -> Array[Material]:
	var array: Array[Material] = []
	var files = FileUtils.get_files(path)
	var filtered_files = ArrayUtils.regex_filter(files, ".material$")
	for file in filtered_files:
		array.append(load(file))
	return array
