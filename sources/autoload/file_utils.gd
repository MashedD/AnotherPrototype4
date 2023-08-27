extends Node


func get_files(path):
	var files : Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			files.append(path + "/" + file_name)
		file_name = dir.get_next()
	return files
