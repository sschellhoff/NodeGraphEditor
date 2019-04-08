extends Node

enum LOG_LEVEL {
	ALL,
	WARNING,
	ERROR,
	NOTHING
}

var Level = LOG_LEVEL.ERROR

func error(msg):
	if Level != LOG_LEVEL.NOTHING:
		print("error: ", msg)
		flush()

func warning(msg):
	if Level != LOG_LEVEL.NOTHING and Level != LOG_LEVEL.ERROR:
		print("warning: ", msg)

func info(msg):
	if Level != LOG_LEVEL.NOTHING and Level != LOG_LEVEL.ERROR and Level != LOG_LEVEL.WARNING:
		print("info: ", msg)

func flush():
	pass