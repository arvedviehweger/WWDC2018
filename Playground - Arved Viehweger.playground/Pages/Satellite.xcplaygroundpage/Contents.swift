//: [Previous page](@previous)
import PlaygroundSupport
/*:
 Down here you can find the code from the previous page. It loads the satellite into view for you to see it.
 
 The satellite is placed in a ***Low Earth Orbit*** at an altitude of about 840km (about 520 miles) above the earth's surface. You are directly behind the satellite so that you can see how it looks like when it's operating in space. 🛰
 */
let Scene = SatelliteScene()
Scene.setupScene()
/*:
 ### Adding the Earth
 
 Now let's add the most important thing, the earth - without it a weather satellite doesn't make sense, right? 😉
 
 In the next two functions you can play with the earth surface. You can add a 3D effect for mountains as well as add clouds to make the earth surface more realistic. 🌎
 
 * Experiment:
 Play around with the boolean values (true and false) in the two methods down below.
 
 1. Did you see a 3D surface but no clouds?
 2. Did you see the clouds but no 3D surface?
 3. Did you just see the earth surface without 3D effects and no clouds?
 4. Or did you see both, a 3D surface and clouds?
 */
Scene.makeEarth3D(boolean: true)
Scene.addClouds(boolean: false)
/*:
 ### Making the satellite move
 
 Now we are making the satellite move around the earth 🌍. There are two different orbits, one of them is ***northbound*** (the satellite travels from the south pole to the north pole) and the other one is ***southbound*** (the satellite travles from the north pole to the south pole).
 */
/*:
 * Experiment:
 Play around with the two functions down below.
 
 1. You can set the orbit type to **northbound** or **southbound**.
 2. You can adjust the duration in seconds for the satellite to complete one orbit.
 
 - Note:
 Make sure to use ***no spaces*** and all letters should be ***lowercase***. 😉
 */
Scene.setOrbitType(type: "southbound")
Scene.setOrbitDuration(seconds: 60.0)
Scene.addEarth()
/*:
 
 ### Adding the satellite data signal
 Now let's add the data signal to the satellite 📶. It's a simple audio signal which gets directly generated from the camera onboard the satellite. Meteorologists and Radio Amateurs can use this signal to decode it back into visible images - you can find one on the bottom of this page. 😃
 
 Now we are adding two new functions. One of them adds the possibility to change the volume of the audio and the other one adds the satellite audio signal.
*/
Scene.addVolumeControls()
Scene.addSatelliteSignalSound()
/*:
 - Note:
 There is a volume button on the top left which you can click to adjust the volume. 🙂 The signal you can hear is a **real recording** from **NOAA-19** that I recorded out of my garden.
 */
PlaygroundPage.current.liveView = Scene
/*:
 ### Summary of what you've learned in this playground:
 - You have learned about functions and parameters in Swift.
 - You know what a Low Earth Orbiting Satellite is.
 - You know about northbound and southbound orbits.
 - You know what the NOAA data signal sounds like.
 
 I hope you had a lot of fun with this playground and that you've learend something new from it. I'm looking forward to seeing you at **WWDC 2018** this year. 😄
 
 And as promised, here is a *real picture* from NOAA-19 that I captured out of my garden:
 
![NOAA-19 on January 1st](sat-picture.jpg)
 
 */
