extends Control

export(String, FILE) var path
var node_collection = null

func register_node_types_from_collection(node_collection):
	self.node_collection = node_collection
	var node_types = FilesystemHelper.open_collection_by_name(node_collection)
	for type in node_types:
		$GraphEdit/NodeBuilder.register_node_type(type.name, type.inputs, type.outputs)
	$GraphEdit.build_context_menu()

func add_graph(graph):
	for node in graph.nodes:
		var position = Vector2(float(node.position.x), float(node.position.y))
		var name = node.name.split("@").join("") # godot puts @ in it's instance names but you cannot name something with an @ it it by yourself
		$GraphEdit.add_node(name, position, node.type)
	for connection in graph.connections:
		var from = connection.from.split("@").join("") # godot puts @ in it's instance names but you cannot name something with an @ it it by yourself
		var to = connection.to.split("@").join("") # godot puts @ in it's instance names but you cannot name something with an @ it it by yourself
		$GraphEdit.connect_node(from, int(connection.from_port), to, int(connection.to_port))

func get_graph_data():
	return {"node_collection": node_collection, "nodes": get_nodes(), "connections": get_connections()}

func get_nodes():
	return $GraphEdit.get_nodes()

func get_connections():
	return $GraphEdit.get_connection_list()
