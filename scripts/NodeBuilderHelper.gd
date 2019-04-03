extends Node

export (PackedScene) var UsedGraphNode

var node_types = {}
var number_of_port_types = 0 setget set_number_of_port_types
var port_types = {}

################################################################################
#                               HELPER METHODS                                 #
################################################################################

func create_empty_node(title, position=Vector2()):
	var node = UsedGraphNode.instance()
	node.offset = position
	node.set_title(title)
	node.type = title
	return node

func create_label(text):
	var label = Label.new()
	label.set_text(text)
	return label

func add_slot(node, name, slot_type, is_input):
	var idx = node.get_child_count()
	node.add_child(create_label(name))
	var color = port_types[slot_type]["color"]
	var type = port_types[slot_type]["type"]
	node.set_slot(idx, is_input, type, color, not is_input, type, color)

func add_input_slot(node, name, slot_type):
	add_slot(node, name, slot_type, true)

func add_output_slot(node, name, slot_type):
	add_slot(node, name, slot_type, false)

func get_new_port_type_id():
	number_of_port_types += 1
	return number_of_port_types - 1

func set_number_of_port_types(new_value):
	if new_value < number_of_port_types:
		Logger.warning("you shouldn't decrease the number of port types!")
	else:
		number_of_port_types = new_value