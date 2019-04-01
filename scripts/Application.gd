extends Node

export (PackedScene) var NodeEditor

func _ready():
	load_exporter()
	create_menu()
	new_editor()
	
func new_editor():
	var editor_instance = NodeEditor.instance()
	$VBoxContainer/Content.add_child(editor_instance)
	$VBoxContainer/Content.set_tab_title($VBoxContainer/Content.get_tab_count() - 1, "untitled")

func load_editor():
	print("unimplemented method")

func save_editor():
	print("unimplemented method")

func export_editor():
	$Exporter.export()

func close_current_tab():
	$VBoxContainer/Content.get_current_tab_control().queue_free()

func close_all_tabs():
	var tab_count = $VBoxContainer/Content.get_tab_count()
	for idx in range(tab_count):
		$VBoxContainer/Content.get_tab_control(idx).queue_free()
	new_editor()

func _on_file_menu_item_pressed(idx):
	var item_text = $VBoxContainer/MenuBar/FileButton.get_popup().get_item_text(idx)
	match item_text:
		"new":
			new_editor()
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
			print("unrecognized button: ", item_text)

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

func load_exporter():
	$Exporter.script.source_code = "extends Node\nfunc export():\n\tprint(\"implement export here....\")\n"
	$Exporter.script.reload(true)