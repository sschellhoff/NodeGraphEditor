extends GraphNode

var type

func _on_GraphNode_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		self.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		self.mouse_filter = Control.MOUSE_FILTER_PASS

func get_node_data():
	return {"name": get_name(), "type": type, "position": {"x": offset.x, "y": offset.y}}