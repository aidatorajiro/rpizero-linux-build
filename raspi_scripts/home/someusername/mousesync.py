import struct

def calc(x):
    return struct.pack('<h', min(max(int(x), -200), 200))

while True:
    i = input()
    if i == 'exit':
        break
    x, y = i.split()
    x = calc(x)
    y = calc(y)
    with open('/dev/hidg1', 'wb') as f:
        f.write(b"\x00" + x + y + b"\x00\x00")
    print('ok')