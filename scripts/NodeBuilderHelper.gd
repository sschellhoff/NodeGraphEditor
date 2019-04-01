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

func register_node_type(type, inputs, outputs):
	Logger.info(type + "\t" + str(inputs) + "\t" + str(outputs))
	node_types[type] = {"inputs": inputs, "outputs": outputs}

func create_empty_node(title, position=Vector2()):
	var node = UsedGraphNode.instance()#GraphNode.new()
	node.offset = position
	node.set_title(title)
	return node

func create_node(title, inputs, outputs, position=Vector2()):
	var node = create_empty_node(title, position)
	for i in inputs:
		add_input_slot(node, i, SLOT_TYPE.FLOAT)
	for o in outputs:
		add_output_slot(node, o, SLOT_TYPE.FLOAT)
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