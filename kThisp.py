#!/bin/python3
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
import dbus, os

thispointer = os.path.expanduser("~/thispointer")
curDir = ""
number = 0
DBusGMainLoop(set_as_default=True)

loop = GLib.MainLoop()

def signal_handler(*args, **kwargs):
	global curDir, number
	newDir = args[0].replace("file:","")
	if newDir != "" and newDir != curDir and newDir != thispointer and not newDir.endswith("thispointer"):
		curDir = newDir
		if os.path.exists(thispointer) or os.path.exists(os.path.realpath(thispointer)): # detect existing (dangling) symbolic link
			os.remove(thispointer)

		print("User jumped to ", newDir)
		os.symlink(curDir, thispointer, target_is_directory=True)
		number += 1
	print("----------------")
	
bus = dbus.SessionBus()
sig = bus.add_signal_receiver(signal_handler, dbus_interface="org.kde.ActivityManager.SLC")
loop.run()
