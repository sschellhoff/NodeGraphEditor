extends Node

func _ready():
	$VBoxContainer/MenuBar.disable_editor_buttons()

func new_editor(node_types):
	print(node_types)
	$VBoxContainer/Content.new_editor(node_types)

func load_exporter(exporter):
	var exporter_code = FilesystemHelper.get_exporter_by_name(exporter)
	$Exporter.script.source_code = exporter_code
	$Exporter.script.reload(true)

func save_current_editor(path):
	var graph_data = $VBoxContainer/Content.get_graph_data()
	FilesystemHelper.write_json_file(path, graph_data)
	$VBoxContainer/Content.set_saved(path)

func _on_Dialogs_open_new_editor(node_collection):
	new_editor(node_collection)

func _on_Dialogs_save_editor(path):
	save_current_editor(path)

func _on_Dialogs_load_editor(path):
	var graph_data = FilesystemHelper.json_from_file(path)
	$VBoxContainer/Content.new_editor_from_data(graph_data)
	$VBoxContainer/Content.set_path(path)
	$VBoxContainer/Content.set_title(FilesystemHelper.filename_from_path(path))

func _on_Dialogs_export_editor(path, exporter):
	load_exporter(exporter)
	var data_to_export = $Exporter.export($VBoxContainer/Content.get_graph_data())
	if data_to_export is String:
		FilesystemHelper.write_text_file(path, data_to_export)
	elif data_to_export is Dictionary:
		FilesystemHelper.write_json_file(path, data_to_export)
	elif data_to_export is PoolByteArray:
		FilesystemHelper.write_binary_file(path, data_to_export)
	else:
		Logger.error("export script must return a string, Dictionary or PoolByteArray!")

func _on_Dialogs_close_editor_without_save():
	$VBoxContainer/Content.free_current_editor()

func _on_Dialogs_close_all_editors_without_save():
	$VBoxContainer/Content.free_all_editors()

func _on_Dialogs_quit_without_save():
	get_tree().quit()

func _on_MenuBar_new_pressed():
	$Dialogs.new_editor_dialog_open()

func _on_MenuBar_save_pressed():
	var path = $VBoxContainer/Content.get_path()
	if path == null or path == "":
		$Dialogs.save_editor_dialog_open($VBoxContainer/Content.get_path())
	else:
		save_current_editor(path)

func _on_MenuBar_save_as_pressed():
	$Dialogs.save_editor_dialog_open($VBoxContainer/Content.get_path())

func _on_MenuBar_load_pressed():
	$Dialogs.load_editor_dialog_open()

func _on_MenuBar_export_pressed():
	$Dialogs.export_editor_dialog_open()

func _on_MenuBar_close_current_tab_pressed():
	if $VBoxContainer/Content.is_current_editor_unsaved():
		$Dialogs.close_without_saving_dialog_open()
	else:
		$VBoxContainer/Content.free_current_editor()

func _on_MenuBar_close_all_tabs_pressed():
	if $VBoxContainer/Content.is_any_editor_unsaved():
		$Dialogs.close_all_without_saving_dialog_open()
	else:
		$VBoxContainer/Content.free_all_editors()

func _on_MenuBar_quit_pressed():
	if $VBoxContainer/Content.is_any_editor_unsaved():
		$Dialogs.quit_without_saving_dialog_open()
	else:
		get_tree().quit()

func _on_Content_number_of_tabs_changed(no):
	if no == 0:
		$VBoxContainer/MenuBar.disable_editor_buttons()
	else:
		$VBoxContainer/MenuBar.enable_editor_buttons()
