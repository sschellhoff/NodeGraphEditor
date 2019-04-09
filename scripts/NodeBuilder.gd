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

func register_node_type(type, ports):
	$Helper.node_types[type] = ports
#func register_node_type(type, inputs, outputs):
#	Logger.info(type + "\t" + str(inputs) + "\t" + str(outputs))
#	$Helper.node_types[type] = {"inputs": inputs, "outputs": outputs}

func create_node(type, position):
	var node = $Helper.create_empty_node(type, position)
	var ports = $Helper.node_types[type]
	for port in ports:
		var port_name = port.name
		var port_type = port.type
		var port_slots = port.slots
		match port_slots:
			"in":
				$Helper.add_input_slot(node, port_name, port_type)
			"out":
				$Helper.add_output_slot(node, port_name, port_type)
			"inout":
				$Helper.add_input_output_slot(node, port_name, port_type)
			_:
				Logger.error("invalid port slots")
	return node