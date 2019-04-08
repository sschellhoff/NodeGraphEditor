extends GraphNode

var type
var info = "" setget set_info, get_info

signal popup_request(sender, position)

func _on_GraphNode_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		self.mouse_filter = Control.MOUSE_FILTER_STOP
		emit_signal("popup_request", self, get_viewport().get_mouse_position())
	else:
		self.mouse_filter = Control.MOUSE_FILTER_PASS

func get_node_data():
	return {"name": get_name(), "type": type, "position": {"x": offset.x, "y": offset.y}, "info": info}

func set_info(new_val):
	info = new_val
	if info != "":
		set_title(str(type) + " [" + str(info) + "]")
	else:
		set_title(str(type))

func get_info():
	return info