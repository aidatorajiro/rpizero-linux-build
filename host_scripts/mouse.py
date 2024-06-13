import time
from Xlib import X, display
import subprocess

from config import HOST_AND_USER

frame = 1/30; boundary = 0.005; coeff = 1.5

d = display.Display()

resx, resy = d.screen().root.get_geometry()._data["width"], d.screen().root.get_geometry()._data["height"]

x1, x2, y1, y2 = resx * boundary, resx * (1 - boundary), resy * boundary, resy * (1 - boundary)

old_x, old_y = None, None

p = subprocess.Popen(["ssh", HOST_AND_USER, "sudo", "python", "mousesync.py"], stdin=subprocess.PIPE, stdout=None, stderr=None)

while True:
    data = d.screen().root.query_pointer()._data
    if data["root_x"] < x1 or data["root_x"] > x2 or data["root_y"] < y1 or data["root_y"] > y2:
        # relocate pointer to the center
        d.screen().root.warp_pointer(resx // 2, resy // 2)
        d.sync()
        old_x, old_y = resx // 2, resy // 2
    else:
        if old_x != None and old_y != None:
            a, b = (data["root_x"] - old_x, data["root_y"] - old_y)
            if not (a == 0 and b == 0):
                print(a, b)
                p.stdin.write(f"{int(a*coeff)} {int(b*coeff)}\n".encode())
                p.stdin.flush()
        old_x, old_y = data["root_x"], data["root_y"]
    time.sleep(frame)
