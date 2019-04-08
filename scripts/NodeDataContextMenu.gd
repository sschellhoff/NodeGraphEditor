extends PopupMenu

var owning_node
signal node_info_changed(node)

func open(node, position):
	$LineEdit.text = node.info
	$LineEdit.caret_position = $LineEdit.text.length()
	owning_node = node
	rect_position = position
	popup()

func _on_Button_pressed() -> void:
	_save_info($LineEdit.text)

func _on_LineEdit_text_entered(new_text: String) -> void:
	_save_info(new_text)

func _save_info(new_text: String) -> void:
	owning_node.info = new_text
	emit_signal("node_info_changed", owning_node)
	hide()