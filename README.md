# TCAS Simulator
### Traffic alert and Collision Avoidance System (TCAS) simulator for badass dudes made with Processing. 

The code is a mess right now and there are almost no comments on it, if you need the code it will most likely be a pain to decipher.

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
The positions is a number which goes from 0 to 1; this parameter makes it possible to generate the aproaching aircraft(s) around the circumference of the radar 10 pixels above.


## Units and Conversions


## Controls

There are different implementations we added to the system in order to be able to control it with the keyboard:
Use WASD to move the aproaching aircraft faster (they are generated with a default speed in a range from )
