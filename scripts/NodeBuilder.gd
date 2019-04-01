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

func register_node_type(name, inputs, outputs):
	$Helper.register_node_type(name, inputs, outputs)

func create_node(type, position):
	var type_data = $Helper.node_types[type]
	return $Helper.create_node(type, type_data.inputs, type_data.outputs, position)