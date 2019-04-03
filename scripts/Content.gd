extends TabContainer

export (PackedScene) var NodeEditor

signal number_of_tabs_changed(no)

func new_editor(node_collection):
	var editor_instance = NodeEditor.instance()
	add_child(editor_instance)
	editor_instance.register_node_types_from_collection(node_collection)
	editor_instance.connect("tree_exited", self, "_on_editor_closed")
	editor_instance.connect("needs_resave", self, "_on_editor_needs_resave")
	current_tab = get_tab_count() - 1
	set_title("* untitled *")
	emit_signal("number_of_tabs_changed", get_tab_count())

func new_editor_from_data(data):
	new_editor(data.node_collection)
	get_current_tab_control().add_graph(data)
	get_current_tab_control().unsaved = false

func get_graph_data():
	return get_current_tab_control().get_graph_data()

func set_title(title):
	set_tab_title(current_tab, title)
	current_tab = current_tab # hack to redraw the control

func set_path(path):
	get_current_tab_control().path = path

func get_path():
	return get_current_tab_control().path

func is_path_set():
	return get_path() != null

func set_saved(path):
	get_current_tab_control().unsaved = false
	set_path(path)
	set_title(FilesystemHelper.filename_from_path(path))

func is_current_editor_unsaved():
	return get_current_tab_control().unsaved

func is_any_editor_unsaved():
	var tab_count = get_tab_count()
	for idx in range(tab_count):
		if get_tab_control(idx).unsaved:
			return true
	return false

func free_current_editor():
	get_current_tab_control().queue_free()

func free_all_editors():
	var tab_count = get_tab_count()
	for idx in range(tab_count):
		get_tab_control(idx).queue_free()

func _on_editor_closed():
	emit_signal("number_of_tabs_changed", get_tab_count())

func _on_editor_needs_resave():
	if not get_tab_title(current_tab).ends_with(" *"):
		set_title(get_tab_title(current_tab) + " *")