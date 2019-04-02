extends TabContainer

export (PackedScene) var NodeEditor

signal number_of_tabs_changed(no)

func new_editor(node_types):
	var editor_instance = NodeEditor.instance()
	add_child(editor_instance)
	editor_instance.register_node_types(node_types)
	editor_instance.connect("tree_exited", self, "_on_editor_closed")
	set_tab_title(get_tab_count() - 1, "untitled")
	emit_signal("number_of_tabs_changed", get_tab_count())

func get_graph_data():
	return get_current_tab_control().get_graph_data()

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