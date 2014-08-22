#!usr/bin/python

# Import required modules
import sys
from PySide import QtCore
from PySide import QtGui

class ImageViewer(QtGui.QWidget):
	   
    def __init__(self):
        super(ImageViewer, self).__init__()
        self.init_ui()
        
    def init_ui(self):
        #Define UI Elements

        self.setWindowTitle('OpenLabTools Microscope')

        layout = QtGui.QHBoxLayout()

        self.imageLabel = QtGui.QLabel()
        fileName = "/home/urop/OpenLab/MicroscopeHost/tracking_fig01.jpg"
        image = QtGui.QImage(fileName)
        if image.isNull():
        	QtGui.QMessageBox.information(self, "Image Viewer", "Cannot load %s." % fileName)
        	return
        
        self.imageLabel.setPixmap(QtGui.QPixmap.fromImage(image))

        left_column = QtGui.QVBoxLayout()
        left_column.addWidget(self.imageLabel)
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
        
        group_box.setLayout(vbox)
        return group_box
        
if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	
	# We want to create a widget, then embed that in app
	widget = ImageViewer()
	widget.show()
	
	# Enter application main loop
	r = app.exec_()
	sys.exit(r)