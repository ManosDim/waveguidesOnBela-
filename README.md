# waveguidesOnBela-
Faust code for digital waveguides on bela board.  
Physical model of a string using waveguides written on Faust and compiled for the Bela board.  
PINS CONNECTIONS:  
BELA:ANALOG_0 <=== flex sensor (frequency control)  
BELA:ANALOG_1 <=== FSR (plucking control)  
BELA:ANALOG_2 <=== untested (hearing position control)  
BELA:ANALOG_3 <=== untested (gain control)  


The same code is used in another project, in which I’m trying to use the erb integration 
to create a euro rack module of a string. So far I have created a plug-in for the VCV rack 
running on Linux (a small video featuring the module can be found [here](https://drive.google.com/file/d/1WB-9lZeb_P7frmxAV2LZdme3uWZc4HjX/view)). 
This project is a work in progress.
