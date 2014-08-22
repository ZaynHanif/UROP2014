
# The Raspberry Pi camera module


# Using the Raspberry Pi camera module with SimpleCV

### Introduction
This tutorial is designed as a first basic introduction to using the Raspberry Pi camera module. SimpleCV is a image processing library for Python which makes it very simple to perform complicated image processing tasks including image manipulation and feature recognition.

### Hardware requirements
* Raspberry Pi with internet connection
* Raspberry Pi camera module

### Software requirements
* SimpleCV - see below for installation instructions


### Step 1 - Connect the camera module  
Connect the camera module to the CSI port on the Raspberry Pi. With the camera connected, enable the camera from the raspi-config menu. Detailed instructions on how to install the camera can be found at [http://www.raspberrypi.org/archives/3890](http://www.raspberrypi.org/archives/3890).

### Step 2 - Check that the camera is connected  
In the terminal, type the following command
`raspistill -t 5000`
This will display a preview window for 5 seconds.

### Step 3 - Install SimpleCV
First install the necessary dependency packages required by SimpleCV. This can be done in the terminal with the command 
`sudo apt-get install ipython python-opencv python-scipy python-numpy python-setuptools python-pip` 

Next download and install SimpleCV itself 
`sudo pip install https://github.com/sightmachine/SimpleCV/zipball/master` 
 
SimpleCV should now be installed on your Raspberry Pi. SimpleCV comes with its own shell application which can be accessed from the terminal by typing `simplecv`. From here you can carry out the full range of image processing operations available. However for more complex operations and for interfacing with the Raspberry Pi camera it is easier to use Python scripts.

### Step 4 - Loading an image from the camera into SimpleCV  
Everything is now in place to start using SimpleCV and the camera module. Open up a text editor and type the following: 
 
    import subprocess
    from SimpleCV import Image
    import time

    call(“raspistill -n -t 0 -w %s -h %s -o image.bmp” % 640 480, shell=True)

    img = Image(“image.bmp”)

    img.show()
    time.sleep(5)

Save the text file as ‘camera.py’, and in the command line type `python camera.py` to run.

The program opens up the camera, takes a still photo, and saves it to a file called image.bmp. SimpleCV then opens the file and displays it on screen for 5 seconds. Normally in SimpleCV an image can be loaded directly from the camera, for example:
 
    cam = Camera()
    img = cam.getImage()
  
However unfortunately there is no similar method for interacting with the Raspberry Pi, which is why this rather roundabout approach of calling the command-line instruction from within Python must be used.

### Step 5 - Image processing  
With the camera image now loaded into SimpleCV, we can perform any image processing tasks we need. For example, try adding one of the following code snippets to the end of the program and running: 
 
    img = img.edges()
    img.show()
    time.sleep(5)


    img = img.binarize()
    img.show()
    time.sleep(5) 


    img = img.findBlobs()
    for blob in blobs:
        blob.draw()  
    img.show()
    time.sleep(5) 



