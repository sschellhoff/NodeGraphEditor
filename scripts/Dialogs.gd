extends Node

signal open_new_editor(node_collection)
signal save_editor(path)
signal load_editor(path)
signal export_editor(path, exporter)
signal close_editor_without_save
signal close_all_editors_without_save
signal quit_without_save

func new_editor_dialog_open():
	$NewEditor.popup_centered()

func save_editor_dialog_open(path=null):
	if path != null and path != "":
		$Save.set_current_path(path)
	else:
		$Save.set_current_path(FilesystemHelper.get_working_directory())
		$Save.set_current_file("")
	$Save.popup_centered()

func load_editor_dialog_open():
	$Load.popup_centered()

func export_editor_dialog_open():
	$Export.popup_centered()

func close_without_saving_dialog_open():
	$CloseWithoutSaving.popup_centered()

func close_all_without_saving_dialog_open():
	$CloseAllWithoutSaving.popup_centered()

func quit_without_saving_dialog_open():
	$QuitWithoutSaving.popup_centered()

func _on_NewEditor_confirmed():
	emit_signal("open_new_editor", $NewEditor.get_selected())

func _on_Save_file_selected(path):
	if path.ends_with("/"):
		$NoFileSpecified.popup_centered()
	else:
		emit_signal("save_editor", path)

func _on_Export_file_selected(path):
	emit_signal("export_editor", path, "json")

func _on_Load_file_selected(path):
	emit_signal("load_editor", path)

func _on_CloseWithoutSaving_confirmed():
	emit_signal("close_editor_without_save")

func _on_CloseAllWithoutSaving_confirmed():
	emit_signal("close_all_editors_without_save")

func _on_QuitWithoutSaving_confirmed():
	emit_signal("quit_without_save")
