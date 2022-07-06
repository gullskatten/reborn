extends Node

signal on_error(message)
signal on_information(info)
signal on_item_received(item)


func error(message):
	emit_signal("on_error", message)

func info(message):
	emit_signal("on_information", message)

func item_received(item):
	emit_signal("on_item_received", item)
