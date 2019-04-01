extends ConfirmationDialog

signal open_new_editor(node_types)

func _on_NewEditor_about_to_show():
	$HBoxContainer2/node_types.clear()
	var node_type_collections = FilesystemHelper.get_node_type_collections()
	for collection in node_type_collections:
		$HBoxContainer2/node_types.add_item(collection)


func _on_NewEditor_confirmed():
	emit_signal("open_new_editor", FilesystemHelper.open_collection($HBoxContainer2/node_types.get_item_text($HBoxContainer2/node_types.get_selected())))
