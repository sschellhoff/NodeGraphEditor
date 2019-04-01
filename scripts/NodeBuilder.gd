extends Node

################################################################################
#                               BUILDER METHODS                                #
################################################################################

func _ready():
	$Helper.register_node_type("add", ["a", "b"], ["out"])
	$Helper.register_node_type("sub", ["a", "b"], ["out"])
	$Helper.register_node_type("mult", ["a", "b"], ["out"])
	$Helper.register_node_type("div", ["a", "b"], ["out"])
	$Helper.register_node_type("one", [], ["out"])
	$Helper.register_node_type("two", [], ["out"])
	$Helper.register_node_type("three", [], ["out"])
	$Helper.register_node_type("four", [], ["out"])
	$Helper.register_node_type("five", [], ["out"])
	$Helper.register_node_type("sink", ["input"], [])

func get_types():
	return $Helper.node_types.keys()

func create_node(type, position):
	var type_data = $Helper.node_types[type]
	return $Helper.create_node(type, type_data.inputs, type_data.outputs, position)

func create_add_node(position):
	return $Helper.create_node("ADD", ["A", "B"], ["OUT"], position)

func create_sub_node(position=Vector2()):
	return $Helper.create_node("SUB", ["A", "B"], ["OUT"], position)