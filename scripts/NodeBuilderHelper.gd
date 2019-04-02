extends Node

export (PackedScene) var UsedGraphNode

var node_types = {}

################################################################################
#                               CONSTANTS                                      #
################################################################################

enum SLOT_TYPE {
	FLOAT
}

const SLOT_COLORS = {
	SLOT_TYPE.FLOAT: Color(0.5, 0.5, 0.0)
}

const COLOR_FLOAT = Color(0.5, 0.5, 0.1)

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
	node.set_slot(idx, is_input, slot_type, SLOT_COLORS[slot_type], not is_input, slot_type, SLOT_COLORS[slot_type])

func add_input_slot(node, name, slot_type):
	add_slot(node, name, slot_type, true)

func add_output_slot(node, name, slot_type):
	add_slot(node, name, slot_type, false)