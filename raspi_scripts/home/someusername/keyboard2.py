#!/usr/bin/python

import sys

import os

sys.path.append(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'Py_Keyboard'))

from Py_Keyboard.HID import Keyboard

from getpass import getpass

kbd = Keyboard()

while True:
    c = getpass("command p=press w=write-and-return x=just-write: ")

    if c.startswith("p "):
        c = c[2:]
        kbd.press(c.upper())
    elif c.startswith("w "):
        c = c[2:]
        kbd.write(c + '\n')
    elif c.startswith("x "):
        c = c[2:]
        kbd.write(c)
    else:
        print("invalid command")




