extends ConfirmationDialog

func _on_NewEditor_about_to_show():
	$HBoxContainer2/node_types.clear()
	var node_type_collections = FilesystemHelper.get_node_type_collections()
	for collection in node_type_collections:
		$HBoxContainer2/node_types.add_item(collection)

func get_selected():
	return $HBoxContainer2/node_types.get_item_text($HBoxContainer2/node_types.get_selected())