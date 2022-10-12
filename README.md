# VLC_Gui_Simulator
MATLAB Simulator for VLC : SNR (error) simulator for VLC comunications  varying power LED, distance and Wave Lenhgt

Código MATLAB: MR_VLC_Gui.m
Simulations of the concepts involved to determine the error depending on the power of the LED versus the distance from the receiving object.
For the execution of the formulas I studied several concepts related to the formulas that are executed that depend on:
a)	Technical specifications of LEDs (irradiance)
b)	Wavelength used by the LED (depends on the LED used). Although in the literature it is identified that technically it has no influence, in terms of the environment there are studies that indicate the importance of selecting wavelengths (of visible light) that are not so impacted by other external sources.
c)	Issuing area
d)	clock rate
e)	Quantum efficiency
Other important values are calculation dependent, which are physical constants that influence the emission/reception calculations used in VLC:

• (h) Planks constant = 6.626068e-34

• (c) Speed of Light = 299792458 m/s

Other important formulas in the calculation:

• Energy = h * wave length

• Photon energy = (h * c) / wave length

• Luminance = power (watt) / pi

• Luminous Intensity = Luminance / (distance^2)

• Luminous Flux = Luminance x area

For the GUI I started from scratch writing a GUI code adapted to the parameters to be simulated. In this case, I started using the commands to build the GUI:

• uifigure – Drawing the figure in the dimensions of the intended layout

• uigridlayout – Layouts for drawing the screen

• uilabel - Labels

• uibutton – action button creation

• uiconfirm – on-screen action confirmation call

• @(b1,event) – for calling functions associated with execution buttons

The rest is graphical treatment, function call, formula calculations and Plot of the obtained results.

The simulator has the presentation below. I defined the power of the LED as parameters; a Distance from the receiver; and the wave length. For the wavelength, although I put the parameter on screen, I fixed the value at this point.

Next improvements to the simulator will be:

a)	Include wavelength in the flexible simulation parameters;

b)	Include the area as a simulation parameter;

c)	Include angle of incidence in the parameters and simulation;

d)	Recording of simulation values in file (excel)
