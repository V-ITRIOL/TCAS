# TCAS Simulator
### Traffic alert and Collision Avoidance System (TCAS) simulator for badass dudes made with Processing. 

The code is a mess right now and there are almost no comments on it, if you need the code it will most likely be a pain to decipher. We are sure there are more efficient ways to code what we've done and there are probably a lot of variables and conditions that are poorly optimised, but considering we made this in 3-4 days non-stop

## Setup

We generate various parameters (specially for the aproaching aircraft) randomly. In the first lines of code we can manipulate the number of aircrafts generated tweaking this line of code:

```java
Aircraft[] crafts = new Aircraft[1];
```
By default is set to 1 as it is useful for debugging, but it can be whatever you and your computer can handle. We've also added a random range of velocities and positions to pick from when generating the aircrafts (in line 38 of TCAS.pde), like so:

```java
crafts[i] = new Aircraft(random(0, 1), random(-50, 100), random(360, 400), 0);
```
Which more generally the object takes these parameters (line 12 of Aircraft.pde):

```java
Aircraft(float pos, float vx, float vy, float vz)
```
The positions is a number which goes from 0 to 1; this parameter makes it possible to generate the aproaching aircraft(s) around the circumference of the radar 10 pixels above. We make this possible by mapping the range (0, 1) to (49, 132) which may seem like a random value but it's the degrees which correspond to the arc of the outermost circumference. Changing the range to the whole 360° will generate the aircraft around the whole circle's perimeter which, as fun as it is, wouldn't be a simulation close to reality of air traffic. 

Next the velocities are randomly generated too, but these are measured in **nautical miles per hour (nmi/h)**. The horizontal speed of an aircraft is generally around the 340 nmi/h. We've chosen to give these aircrafts somewhat of a value which aproches that one in the Y speed only (which is the movement from the top to the bottom of the screen) just for visualization purposes. As long as the magnitude of the aircraft's speed is around 340 nmi/h it will be a good representation of the movement. 

For the last parameter in our object we take in the vertical speed in **feet per second (ft/s)**. In the aeronautical industry these speeds are usually given in feet per minute but it made more sense for us to input it in ft/s. As you can see, by default we didn't input any value in the Z velocity. This is because if we are on a certain altitude (which we've assumed to be 30,000 feet above ground) we don't expect aircraft to keep ascending or descending at constant rates unless they are making a maneuver. We are able to adjust these speeds with different inputs from our keyboard, but we'll talk about that in the **Controls** section.


## Units and Conversions


## Controls

There are different implementations we added to the system in order to be able to control it with the keyboard:
Use WASD to move the aproaching aircraft faster (they are generated with a default speed in a range from )
