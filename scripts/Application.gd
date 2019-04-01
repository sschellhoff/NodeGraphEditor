extends Node

export (PackedScene) var NodeEditor

func _ready():
	load_exporter()
	create_menu()
	disable_save_export_buttons()
	
func new_editor(node_types):
	var editor_instance = NodeEditor.instance()
	$VBoxContainer/Content.add_child(editor_instance)
	editor_instance.register_node_types(node_types)
	$VBoxContainer/Content.set_tab_title($VBoxContainer/Content.get_tab_count() - 1, "untitled")
	enable_save_export_buttons()

func load_editor():
	$Dialogs/Load.popup_centered()

func save_editor():
	$Dialogs/Save.popup_centered()

func export_editor():
	$Dialogs/Export.popup_centered()

func close_current_tab():
	if $VBoxContainer/Content.get_tab_count() == 1:
		disable_save_export_buttons()
	$VBoxContainer/Content.get_current_tab_control().queue_free()

func close_all_tabs():
	var tab_count = $VBoxContainer/Content.get_tab_count()
	for idx in range(tab_count):
		$VBoxContainer/Content.get_tab_control(idx).queue_free()
	disable_save_export_buttons()

func load_exporter():
	$Exporter.script.source_code = "extends Node\nfunc export(path):\n\tprint(\"implement export here....\")\n"
	$Exporter.script.reload(true)

func is_editor_open():
	return $VBoxContainer/Content.get_tab_count() > 0

func enable_save_export_buttons():
	$VBoxContainer/MenuBar/FileButton.get_popup().set_item_disabled(5, false)
	$VBoxContainer/MenuBar/FileButton.get_popup().set_item_disabled(7, false)

func disable_save_export_buttons():
	$VBoxContainer/MenuBar/FileButton.get_popup().set_item_disabled(5, true)
	$VBoxContainer/MenuBar/FileButton.get_popup().set_item_disabled(7, true)

func _on_file_menu_item_pressed(idx):
	var item_text = $VBoxContainer/MenuBar/FileButton.get_popup().get_item_text(idx)
	match item_text:
		"new":
			$Dialogs/NewEditor.popup_centered()
		"close current tab":
			close_current_tab()
		"close all tabs":
			close_all_tabs()
		"save":
			save_editor()
		"load":
			load_editor()
		"export":
			export_editor()
		"quit":
			get_tree().quit()
		_:
			Logger.warning("unrecognized button: " + item_text)

func create_menu():
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("new", 0, KEY_MASK_CMD|KEY_N)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_separator()
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("close current tab", 0, KEY_MASK_CMD|KEY_X)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("close all tabs", 0, KEY_MASK_CMD|KEY_MASK_SHIFT|KEY_X)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_separator()
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("save", 0, KEY_MASK_CMD|KEY_S)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("load", 0, KEY_MASK_CMD|KEY_L)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("export", 0, KEY_MASK_CMD|KEY_E)
	$VBoxContainer/MenuBar/FileButton.get_popup().add_separator()
	$VBoxContainer/MenuBar/FileButton.get_popup().add_item("quit", 0, KEY_MASK_CMD|KEY_Q)
	$VBoxContainer/MenuBar/FileButton.get_popup().connect("index_pressed", self, "_on_file_menu_item_pressed")

func _on_Save_file_selected(path):
	if path.ends_with("/"):
		$Dialogs/NoFileSpecified.popup_centered()
	var graph_data = $VBoxContainer/Content.get_current_tab_control().get_graph_data()
	Logger.info(path)
	Logger.info(graph_data)
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(JSON.print(graph_data))
	file.close()

func _on_Load_file_selected(path):
	Logger.warning("implement me")

func _on_Export_file_selected(path):
	$Exporter.export(path)

func _on_NewEditor_open_new_editor(node_types):
	new_editor(node_types)
