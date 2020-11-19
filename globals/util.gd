extends Node

func get_files_in_directory(path):
	var files = []
	var dir = Directory.new()

	dir.open(path)
	dir.list_dir_begin(true, true)

	var file = dir.get_next()

	while file != "":
		files.append(file)
		file = dir.get_next()

	return files
