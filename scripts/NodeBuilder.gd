extends Node

################################################################################
#                               BUILDER METHODS                                #
################################################################################

func _ready():
	pass

func get_type_names():
	return $Helper.node_types.keys()

func get_types():
	return $Helper.node_types

func register_node_type(type, inputs, outputs):
	Logger.info(type + "\t" + str(inputs) + "\t" + str(outputs))
	$Helper.node_types[type] = {"inputs": inputs, "outputs": outputs}

func create_node(type, position):
	var node = $Helper.create_empty_node(type, position)
	var type_data = $Helper.node_types[type]
	for i in type_data.inputs:
		$Helper.add_input_slot(node, i, $Helper.SLOT_TYPE.FLOAT)
	for o in type_data.outputs:
		$Helper.add_output_slot(node, o, $Helper.SLOT_TYPE.FLOAT)
	return node