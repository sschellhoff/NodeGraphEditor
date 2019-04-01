extends GraphEdit

func _ready():
	build_context_menu()
	
func build_context_menu():
	$ContextMenu.clear()
	for type in $NodeBuilder.get_type_names():
		$ContextMenu.add_item(type)

func get_graph_data():
	return {"types": $NodeBuilder.get_types(), "nodes": get_nodes(), "connections": get_connection_list()}

func get_nodes():
	var nodes = []
	for child in get_children():
		if child is GraphNode:
			nodes.append(child.get_node_data())
	return nodes

func remove_node(node):
	remove_connections_from_node(node)
	node.queue_free()

func get_selected_nodes():
	var selected_nodes = []
	for child in get_children():
		if child is GraphNode and child.selected:
			selected_nodes.append(child)
	return selected_nodes

func remove_connections_from_node(node):
	var connections = get_connection_list()
	for connection in connections:
		if node.get_name() == connection.from or node.get_name() == connection.to:
			disconnect_node(connection.from, connection.from_port, connection.to, connection.to_port)

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)

func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)

func _on_GraphEdit_popup_request(position):
	$ContextMenu.rect_position = position
	$ContextMenu.popup()

func _on_ContextMenu_index_pressed(index):
	add_child($NodeBuilder.create_node($ContextMenu.get_item_text(index), $ContextMenu.rect_position))

func _on_GraphEdit_delete_nodes_request():
	var selected_nodes = get_selected_nodes()
	for node in selected_nodes:
		remove_node(node)

func _on_GraphEdit_duplicate_nodes_request():
	pass
