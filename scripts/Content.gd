extends TabContainer

export (PackedScene) var NodeEditor

signal number_of_tabs_changed(no)

func new_editor(node_types):
	var editor_instance = NodeEditor.instance()
	add_child(editor_instance)
	editor_instance.register_node_types(node_types)
	editor_instance.connect("tree_exited", self, "_on_editor_closed")
	current_tab = get_tab_count() - 1
	set_title("* untitled *")
	emit_signal("number_of_tabs_changed", get_tab_count())

func new_editor_from_data(data):
	print(data)

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

func free_current_editor():
	get_current_tab_control().queue_free()

func free_editor(idx):
	get_tab_control(idx).queue_free()

func free_all_editors():
	var tab_count = get_tab_count()
	for idx in range(tab_count):
		free_editor(idx)

func _on_editor_closed():
	emit_signal("number_of_tabs_changed", get_tab_count())