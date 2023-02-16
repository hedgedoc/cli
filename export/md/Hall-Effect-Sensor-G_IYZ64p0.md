# Hall Effect Sensor

I have the sensor connected directly to the Raspberry Pi as follows:
The sensor's brown wire connects to pin 2 of the GPIO header for the +5V supply.
The sensor's blue wire connects to pin 6 of the GPIO header for the ground connection.
The sensor's black wire connects to pin 8 (or any input of your choice -- configure your software to match.)


The black wire/Pin 8 also needs to connect to a resistor (2200 - 4700 ohm is fine) and the other side of that resistor connects to pin 1 (3.3 V) of the Raspberry Pi GPIO connector. The black wire in the sensor provides an open-drain output, which means that it can provide a ground-level signal to pin 8 in one state, but to provide a voltage to pin 8 in the other state, you need to use the resistor (pull-up resistor) that connects to the Pi's 3.3V The Raspberry Pi inputs cannot tolerate more than 3.3 volts on an input pin.

The specifications state that it has an NPN transistor output, and that configuration would be called open-collector, which in this application, works the same as the open drain output on what is clearly a FET: The on-state (conducting) voltage drop from black to blue wire was measured at about 20 millivolts.