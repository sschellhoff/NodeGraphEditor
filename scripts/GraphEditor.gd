extends Control

export(String, FILE) var path

func register_node_types(node_types):
	for type in node_types:
		$GraphEdit/NodeBuilder.register_node_type(type.name, type.inputs, type.outputs)
	$GraphEdit.build_context_menu()

func get_graph_data():
	return $GraphEdit.get_graph_data()

func get_nodes():
	return $GraphEdit.get_nodes()

func get_connections():
	return $GraphEdit.get_connection_list
