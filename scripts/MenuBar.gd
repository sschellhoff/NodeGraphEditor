extends HBoxContainer

signal new_pressed
signal close_current_tab_pressed
signal close_all_tabs_pressed
signal save_pressed
signal load_pressed
signal export_pressed
signal quit_pressed

func _ready():
	$FileButton.get_popup().add_item("new", 0, KEY_MASK_CMD|KEY_N)
	$FileButton.get_popup().add_separator()
	$FileButton.get_popup().add_item("close current tab", 0, KEY_MASK_CMD|KEY_X)
	$FileButton.get_popup().add_item("close all tabs", 0, KEY_MASK_CMD|KEY_MASK_SHIFT|KEY_X)
	$FileButton.get_popup().add_separator()
	$FileButton.get_popup().add_item("save", 0, KEY_MASK_CMD|KEY_S)
	$FileButton.get_popup().add_item("load", 0, KEY_MASK_CMD|KEY_L)
	$FileButton.get_popup().add_item("export", 0, KEY_MASK_CMD|KEY_E)
	$FileButton.get_popup().add_separator()
	$FileButton.get_popup().add_item("quit", 0, KEY_MASK_CMD|KEY_Q)
	$FileButton.get_popup().connect("index_pressed", self, "_on_file_menu_item_pressed")

func enable_editor_buttons():
	$FileButton.get_popup().set_item_disabled(2, false)
	$FileButton.get_popup().set_item_disabled(3, false)
	$FileButton.get_popup().set_item_disabled(5, false)
	$FileButton.get_popup().set_item_disabled(7, false)

func disable_editor_buttons():
	$FileButton.get_popup().set_item_disabled(2, true)
	$FileButton.get_popup().set_item_disabled(3, true)
	$FileButton.get_popup().set_item_disabled(5, true)
	$FileButton.get_popup().set_item_disabled(7, true)

func _on_file_menu_item_pressed(idx):
	var item_text = $FileButton.get_popup().get_item_text(idx)
	match item_text:
		"new":
			emit_signal("new_pressed")
		"close current tab":
			emit_signal("close_current_tab_pressed")
		"close all tabs":
			emit_signal("close_all_tabs_pressed")
		"save":
			emit_signal("save_pressed")
		"load":
			emit_signal("load_pressed")
		"export":
			emit_signal("export_pressed")
		"quit":
			emit_signal("quit_pressed")
		_:
			Logger.warning("unrecognized button: " + item_text)
