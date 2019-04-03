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

func register_port_type(type, color):
	$Helper.port_types[type] = {"color": color, "type": $Helper.get_new_port_type_id()}

func register_node_type(type, inputs, outputs):
	Logger.info(type + "\t" + str(inputs) + "\t" + str(outputs))
	$Helper.node_types[type] = {"inputs": inputs, "outputs": outputs}

func create_node(type, position):
	var node = $Helper.create_empty_node(type, position)
	var type_data = $Helper.node_types[type]
	for i in type_data.inputs:
		$Helper.add_input_slot(node, i.name, i.type)
	for o in type_data.outputs:
		$Helper.add_output_slot(node, o.name, o.type)
	return node