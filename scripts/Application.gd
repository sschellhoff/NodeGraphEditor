extends Node

func _ready():
	$VBoxContainer/MenuBar.disable_editor_buttons()
	
func new_editor(node_types):
	print(node_types)
	$VBoxContainer/Content.new_editor(node_types)

func load_exporter(exporter):
	$Exporter.script.source_code = "extends Node\nfunc export(path):\n\tprint(\"implement export here....\")\n"
	$Exporter.script.reload(true)

func _on_Dialogs_open_new_editor(node_collection):
	new_editor(node_collection)

func _on_Dialogs_save_editor(path):
	var graph_data = $VBoxContainer/Content.get_graph_data()
	FilesystemHelper.write_json_file(path, graph_data)
	$VBoxContainer/Content.set_saved(path)

func _on_Dialogs_load_editor(path):
	var graph_data = FilesystemHelper.json_from_file(path)
	$VBoxContainer/Content.new_editor_from_data(graph_data)
	$VBoxContainer/Content.set_path(path)
	$VBoxContainer/Content.set_title(FilesystemHelper.filename_from_path(path))

func _on_Dialogs_export_editor(path, exporter):
	load_exporter(exporter)
	$Exporter.export(path)

func _on_Dialogs_close_editor_without_save():
	$VBoxContainer/Content.free_current_editor()

func _on_Dialogs_close_all_editors_without_save():
	$VBoxContainer/Content.free_all_editors()

func _on_Dialogs_quit_without_save():
	get_tree().quit()

func _on_MenuBar_new_pressed():
	$Dialogs.new_editor_dialog_open()

func _on_MenuBar_save_pressed():
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
