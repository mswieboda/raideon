extends Node

func get_files_in_directory(path):
  var files = []
  var dir = DirAccess.open(path)

  dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547

  var file = dir.get_next()

  while file != "":
    files.append(file)
    file = dir.get_next()

  return files
