extends Node

func get_files_in_directory(path):
	var files = []
	var directory = Directory.new()
	if directory.open(path) != OK:
		Logger.error("path \"%s\" does not exist!")
		return []
	directory.list_dir_begin()
	var filename = directory.get_next()
	while filename != "":
		if not directory.current_is_dir():
			files.append(filename)
		filename = directory.get_next()
	directory.list_dir_end()
	return files

func get_node_type_collections():
	var result = []
	var collections = get_files_in_directory("res://node_types")
	for collection in collections:
		result.append(collection.left(collection.length() - 5))
	return result

func open_collection_by_name(name):
	return json_from_file("res://node_types/" + name + ".json")

func json_from_file(path):
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var result = parse_json(text)
	file.close()
	return result;