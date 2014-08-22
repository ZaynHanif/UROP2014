import sys
import time
import cv2
import picamera
import io
import numpy as np

from PySide import QtCore
from PySide import QtGui

class FrameDisplay(QtGui.QLabel):

    def __init__(self):
        super(FrameDisplay, self).__init__()

    @QtCore.Slot()
    def updateFrame(self, pixmap):
        self.setPixmap(pixmap)


class FrameThread(QtCore.QThread):
    '''Grabs and processes camera frames and signals when ready'''

    def __init__(self, log_suffix):
        super(FrameThread, self).__init__()
        
        # CV2 doesn't work with RPi, so using picamera to take images. 
        #self.camera = cv2.VideoCapture(0)
        cameraWidth = 519
        cameraHeight = 374
        self.camera = picamera.PiCamera()
        self.camera.resolution = (cameraWidth, cameraHeight)

        self.mutex = QtCore.QMutex()
        self.abort = False
        self.condition = QtCore.QWaitCondition()

    def update_parameters(self, params):
        self.mutex.lock()
        self.params = params
        self.mutex.unlock()
        
    def takePicture(self):
        cv2.imwrite('/home/pi/takePicImage.jpg',self.img_copy)

    def run(self):
        while not self.abort:
            #ret, self.img = self.camera.read()
            #self.img = cv2.imread('/home/urop/OpenLab/MicroscopeHost/tracking_fig01.jpg')
            
            stream = io.BytesIO()
            self.camera.capture(stream, format='jpeg', use_video_port=True) #use_video_port increases frame rate
            data = np.fromstring(stream.getvalue(), dtype=np.uint8)
            self.img = cv2.imdecode(data,1)
            
            time.sleep(0.2)

            self.mutex.lock()
            self.img_copy = self.img.copy()
            self.mutex.unlock()

            height, width, channels = self.img_copy.shape
            bpl = width*channels
            RGBimg = cv2.cvtColor(self.img_copy, cv2.COLOR_BGR2RGB)
            self.frame = QtGui.QImage(RGBimg.data, width, height, bpl,
                                      QtGui.QImage.Format_RGB888)
            self.emit(QtCore.SIGNAL("renderedImage(const QImage)"), self.frame)

    def stop(self):
        self.mutex.lock()
        self.abort = True
        self.condition.wakeOne()
        self.mutex.unlock()

        self.wait()


class MicroscopeClient(QtGui.QWidget):
    '''Application for controlling the OpenLabTools Microscope'''

    newPixmap = QtCore.Signal(QtGui.QPixmap)

    def __init__(self, log_suffix):
        super(MicroscopeClient, self).__init__()

        self.init_ui()

        self.params = {}
        self.thread = FrameThread(log_suffix)

        self.set_defaults()

        #self.newPixmap.connect(self.frame_display.updateFrame)
        self.connect(self, QtCore.SIGNAL("newPixmap(const QPixmap)"),
                     self.frame_display.updateFrame)

        #Start the frame processing thread
        self.connect(self.thread, QtCore.SIGNAL("renderedImage(const QImage)"),
                     self.update_frame)
        self.thread.start()

    def init_ui(self):
        '''Define UI Elements'''

        self.setWindowTitle('OpenLabTools Microscope')

        layout = QtGui.QHBoxLayout()

        self.frame_display = FrameDisplay()

        left_column = QtGui.QVBoxLayout()
        left_column.addWidget(self.frame_display)
        left_column.addStretch(1)

        right_column = QtGui.QVBoxLayout()
        right_column.addWidget(self.init_frame_controls())

        layout.addLayout(left_column)
        layout.addLayout(right_column)
        self.setLayout(layout)

    def init_frame_controls(self):
        '''Define UI Elements for changing image processing parameters'''

        group_box = QtGui.QGroupBox('Frame Controls')

        vbox = QtGui.QVBoxLayout()

        # Taking image controls
        image_group = QtGui.QGroupBox('Basic Controls')

        image_form = QtGui.QFormLayout()

        self.takePicButton = QtGui.QPushButton("Take Picture", self)
        image_form.addRow('Take Picture', self.takePicButton)

        image_group.setLayout(image_form)
        vbox.addWidget(image_group)

        vbox.addStretch(1)
        group_box.setLayout(vbox)

        return group_box

    def set_defaults(self):
        self.takePicButton.clicked.connect(self.thread.savePicture())

    @QtCore.Slot()
    def update_parameters(self):

        #Grab parameters from UI Widgets
        
        #Signal to transfer params to processing thread
        self.thread.update_parameters(self.params)

    @QtCore.Slot()
    def update_frame(self, frame):
        '''Resend signal from frame thread to frame widget'''
        self.pixmap = QtGui.QPixmap.fromImage(frame)
        self.emit(QtCore.SIGNAL("newPixmap(const QPixmap)"), self.pixmap)
        self.update()

if __name__ == "__main__":
    app = QtGui.QApplication(sys.argv)
    widget = MicroscopeClient(sys.argv[1])
    widget.show()
    r = app.exec_()
    widget.thread.stop()
    sys.exit(r)
