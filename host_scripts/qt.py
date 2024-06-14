import sys

from PyQt5.QtCore import QSize, Qt, QEvent
from PyQt5.QtGui import QMouseEvent
from PyQt5.QtWidgets import QApplication, QMainWindow, QGraphicsView, QGraphicsScene

class StateManager():
    def __init__(self):
        self.pressed_keys = set()
        self.pressed_buttons = set()
        self.current_pos = None
        self.current_pos_old = None

        self.key_callback = None
        self.pos_callback = None
        self.button_callback = None
    
    def change_pos(self, p):
        if self.current_pos != p:
            self.current_pos_old = self.current_pos
            self.current_pos = p
            self.pos_callback((self.current_pos_old, self.current_pos))

    def add_key(self, k):
        if not k in self.pressed_keys:
            self.pressed_keys.add(k)
            self.key_callback(self.pressed_keys)
    
    def remove_key(self, k):
        if k in self.pressed_keys:
            self.pressed_keys.remove(k)
            self.key_callback(self.pressed_keys)

    def add_button(self, b):
        if not b in self.pressed_buttons:
            self.pressed_buttons.add(b)
            self.button_callback(self.pressed_buttons)
    
    def remove_button(self, b):
        if b in self.pressed_buttons:
            self.pressed_buttons.remove(b)
            self.button_callback(self.pressed_buttons)
    
    def set_key_callback(self, cb):
        self.key_callback = cb

    def set_pos_callback(self, cb):
        self.pos_callback = cb

    def set_button_callback(self, cb):
        self.button_callback = cb

sm = StateManager()

def pos_func(x):
    (oldpos, newpos) = x
    print(x)
    pass

sm.set_pos_callback(pos_func)

def key_func(keys):
    print(keys)
    pass

sm.set_key_callback(key_func)

def btn_func(btns):
    print(btns)
    pass

sm.set_button_callback(btn_func)

# Subclass QMainWindow to customize your application's main window
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("My App")
        self.view = QGraphicsView()
        self.view.setFixedSize(QSize(200,200))
        self.scene = QGraphicsScene()
        self.view.setScene(self.scene)

        self.setCentralWidget(self.view)
        # self.setMouseTracking(True)
        self.setFixedSize(QSize(200,200))
    
    def eventFilter(self, source, event):
        if event.type() == QEvent.MouseMove:
            sm.change_pos((event.pos().x(), event.pos().y()))
            return True
        elif event.type() == QEvent.MouseButtonPress:
            sm.add_button(event.button())
            return True
        elif event.type() == QEvent.MouseButtonRelease:
            sm.remove_button(event.button())
            return True
        elif event.type() == QEvent.KeyPress:
            sm.add_key(event.key())
            return True
        elif event.type() == QEvent.KeyRelease:
            sm.remove_key(event.key())
            return True
        return QMainWindow.eventFilter(self, source, event)

app = QApplication(sys.argv)

window = MainWindow()
window.show()
app.installEventFilter(window)

app.exec()

