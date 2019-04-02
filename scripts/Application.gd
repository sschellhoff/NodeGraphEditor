extends Node

export (PackedScene) var NodeEditor

func _ready():
	$VBoxContainer/MenuBar.disable_save_export_buttons()
	
func new_editor(node_types):
	var editor_instance = NodeEditor.instance()
	$VBoxContainer/Content.add_child(editor_instance)
	editor_instance.register_node_types(node_types)
	$VBoxContainer/Content.set_tab_title($VBoxContainer/Content.get_tab_count() - 1, "untitled")
	$VBoxContainer/MenuBar.enable_save_export_buttons()

func load_exporter(exporter):
	$Exporter.script.source_code = "extends Node\nfunc export(path):\n\tprint(\"implement export here....\")\n"
	$Exporter.script.reload(true)

func is_editor_open():
	return $VBoxContainer/Content.get_tab_count() > 0

func _on_Dialogs_open_new_editor(node_types):
	new_editor(node_types)

func _on_Dialogs_save_editor(path):
	var graph_data = $VBoxContainer/Content.get_current_tab_control().get_graph_data()
	Logger.info(path)
	Logger.info(graph_data)
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(JSON.print(graph_data))
	file.close()

func _on_Dialogs_load_editor(path):
	Logger.warning("implement me")

func _on_Dialogs_export_editor(path, exporter):
	load_exporter(exporter)
	$Exporter.export(path)

func _on_MenuBar_new_pressed():
	$Dialogs.new_editor_dialog_open()

func _on_MenuBar_save_pressed():
	$Dialogs.save_editor_dialog_open()

func _on_MenuBar_load_pressed():
	$Dialogs.load_editor_dialog_open()

func _on_MenuBar_export_pressed():
	$Dialogs.export_editor_dialog_open()

func _on_MenuBar_close_current_tab_pressed():
	if $VBoxContainer/Content.get_tab_count() == 1:
		$VBoxContainer/MenuBar.disable_save_export_buttons()
	$VBoxContainer/Content.get_current_tab_control().queue_free()

func _on_MenuBar_close_all_tabs_pressed():
	var tab_count = $VBoxContainer/Content.get_tab_count()
	for idx in range(tab_count):
		$VBoxContainer/Content.get_tab_control(idx).queue_free()
	$VBoxContainer/MenuBar.disable_save_export_buttons()

func _on_MenuBar_quit_pressed():
	get_tree().quit()
