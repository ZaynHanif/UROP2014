
# The Microscope Fluoroscence Module 


## Microscope Attachment




## LED light source for the fluoroscence module

### Introduction
The following set of instructions will provide you with information on creating a constant current LED circuit that can be dimmed by using an Arduino.
There are two main components of the LED light source:

* Constant current circuit. This part of the light source allows the current through the LED to be constant irrespective of the voltage from the power supply used. 
* Dimming circuit. This part of the light source builds upon the constant current circuit, allowing the LED's brightness to be controlled by using an Arduino.

In creating the constant current circuit, Dan Goldwater must be thanked for his tutorial "Power LED's - simplest light with constant-current circuit", which provided the basis for the constant current dimming circuit produced to be used in the fluorscence module of the microscope. The tutorial can be found at [http://www.instructables.com/id/Power-LED-s---simplest-light-with-constant-current/](http://www.instructables.com/id/Power-LED-s---simplest-light-with-constant-current/).
This tutorial provides in depth explanation into how the circuit works and its benefits and hence it is best to visit that tutorial to gain a better understanding of the circuit.

### Circuit Diagram
![Alt Text](images/ConstantCurrentCircuitDiagram.png "Constant Current Dimming Circuit Diagram")

### Components Required
* Resistors
	- R1: 100K ohm resistor
	- R2: 1.0 ohm resistor
	- R3: 10K ohm resistor
	- R4: 10K ohm resistor
* Transistors
	- Q1: NPN BiPolar BJT (Such as 2N3904 available from [Farnell](http://uk.farnell.com/fairchild-semiconductor/2n3904/transistor-npn-40v-200ma-to-92/dp/9846743))
	- Q2: N-Channel MOSFET (Such as 147N03L available from [Farnell](http://uk.farnell.com/international-rectifier/irlb8721pbf/mosfet-n-ch-30v-62a-to220/dp/1740783?Ntt=147n03l&whydiditmatch=rel_default&matchedProduct=147n03l))
	- Q3: N-Channel MOSFET (Such as 147N03L available from [Farnell](http://uk.farnell.com/international-rectifier/irlb8721pbf/mosfet-n-ch-30v-62a-to220/dp/1740783?Ntt=147n03l&whydiditmatch=rel_default&matchedProduct=147n03l))
* LEDs
	- D1: 450nm blue LED (Such as LUMILEDS LXML-PR01-0425 available from [Farnell](http://uk.farnell.com/lumileds/lxml-pr01-0425/rebel-royal-blue-440nm-460nm/dp/2062928))


A few points about the components:

* R2 is the resistor that determines the current that flows through the circuit. The LED current is set by R2, and is approximately equal to 0.5/R2. For this circuit the LED current was set to 500mA.
* R3 was chosen arbitrarily to limit the current at the Gate pin of Q3, and R4 was chosen to match R3. 
* Q3 can be chosen as any transistor, as this component is used as a switch to control the LED brightness (more information on this will follow), and this was chosen to be the same as Q2 as there were spare N-Channel MOSFET Transistors.
* D1 needed to be a LED with a wavelength of 450nm in order to successfully excite the two fluorophores this module was being designed for as explained in the earlier sections. Any LED can be chosen as long as its wavelength satisfies the fluorophores excitation wavelength.

### Background
