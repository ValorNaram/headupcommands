#!/bin/python3
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
import dbus, os, time

thispointer = os.path.expanduser("~/thispointer")
thispointer_tmp = thispointer + "_tmp"
curDir = ""
number = 0
DBusGMainLoop(set_as_default=True)

loop = GLib.MainLoop()

def signal_handler(*args, **kwargs):
	global curDir, number
	
	newDir = args[0].replace("file://","")
	
	# if statement explained:
	#   newDir != "" - newDir must not be an empty string (critical part)
	#   newDir != curDir - must not be equal to prevent unnecessary operations
	#   newDir != thispointer - must not be equal with the path of thispointer to prevent strange behaviours like error throwing or uncaught but dangerous errors (critical part)
	#   newDir.endswith("thispointer") - same as previous (critical part)
	if newDir != "" and newDir != curDir and newDir != thispointer:
		curDir = os.path.realpath(newDir)
		# detect existing link         or     detect existing dangling symbolic link
		#if os.path.exists(thispointer) or not os.path.exists(os.path.realpath(thispointer)) and os.path.islink(thispointer):
		#	os.remove(thispointer) # remove existing (dangling) symbolic link

		print("Loop {}: User jumped to {}".format(str(number), newDir))
		os.symlink(curDir, thispointer_tmp, target_is_directory=True)
		os.rename(thispointer_tmp, thispointer)
	
	number += 1
	print("----------------")
	
bus = dbus.SessionBus()
sig = bus.add_signal_receiver(signal_handler, dbus_interface="org.kde.ActivityManager.SLC")
loop.run()
