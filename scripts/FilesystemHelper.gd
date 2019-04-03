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

func filename_from_path(path):
	return path.right(path.find_last("/")+1)

func path_without_filename(path):
	return path.left(path.find_last("/"))

func get_working_directory():
	return "res://"

func get_node_type_collections():
	var result = []
	var collections = get_files_in_directory("res://node_types")
	for collection in collections:
		result.append(collection.left(collection.length() - 5))
	return result

func open_collection_by_name(name):
	return json_from_file("res://node_types/" + name + ".json")

func get_exporters():
	var result = []
	var exporters = get_files_in_directory("res://exporters")
	for exporter in exporters:
		result.append(exporter.left(exporter.length() - 3))
	return result

func get_exporter_by_name(name):
	return text_from_file("res://exporters/" + name + ".gd")

func text_from_file(path):
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	file.close()
	return text;	

func json_from_file(path):
	return parse_json(text_from_file(path))

func write_text_file(path, data):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(data)
	file.close()

func write_json_file(path, data):
	write_text_file(path, JSON.print(data))

func write_binary_file(path, poolbytearray):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_buffer(poolbytearray)
	file.close()