import time
from Xlib import X, display

frame = 1/20

d = display.Display()

old_x, old_y = None, None

while True:
    data = d.screen().root.query_pointer()._data
    if old_x != None and old_y != None:
        print(data["root_x"] - old_x, data["root_y"] - old_y)
    old_x, old_y = data["root_x"], data["root_y"]
    time.sleep(frame)