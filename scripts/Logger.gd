extends Node

enum LOG_LEVEL {
	ALL,
	WARNING,
	ERROR,
	NOTHING
}

var Level = LOG_LEVEL.ALL

func error(msg):
	if Level != LOG_LEVEL.NOTHING:
		print(msg)
		flush()

func warning(msg):
	if Level != LOG_LEVEL.NOTHING and Level != LOG_LEVEL.ERROR:
		print(msg)

func info(msg):
	if Level != LOG_LEVEL.NOTHING and Level != LOG_LEVEL.ERROR and Level != LOG_LEVEL.WARNING:
		print(msg)

func flush():
	pass