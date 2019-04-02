extends Node

signal open_new_editor(node_types)
signal save_editor(path)
signal load_editor(path)
signal export_editor(path, exporter)

func new_editor_dialog_open():
	$NewEditor.popup_centered()

func save_editor_dialog_open():
	$Save.popup_centered()

func load_editor_dialog_open():
	$Load.popup_centered()

func export_editor_dialog_open():
	$Export.popup_centered()

func _on_NewEditor_confirmed():
	emit_signal("open_new_editor", FilesystemHelper.open_collection_by_name($NewEditor.get_selected()))

func _on_Save_file_selected(path):
	if path.ends_with("/"):
		$NoFileSpecified.popup_centered()
	else:
		emit_signal("save_editor", path)

func _on_Export_file_selected(path):
	emit_signal("export_editor", path, "json")

func _on_Load_file_selected(path):
	emit_signal("load_editor", path)
