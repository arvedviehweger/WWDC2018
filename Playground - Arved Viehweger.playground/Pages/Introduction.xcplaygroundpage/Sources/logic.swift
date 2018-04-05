import Foundation
import SceneKit
import UIKit
import AVFoundation

open class SatelliteScene : UIViewController {
    
    // Add global variables
    
    var sceneView : SCNView!
    var scene : SCNScene!
    var camera : SCNNode!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // Setting up the scene
    
    open func setupScene() {
        
        // Initializing the view
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        // Loading the satellite model
        scene = SCNScene(named: "NOAA.scn")
        // Let SceneKit do the loghting
        sceneView.autoenablesDefaultLighting = true
        
        // Assign the scene to the scene view
        sceneView.scene = scene
        // Make the background black
        sceneView.backgroundColor = UIColor.black
        
        // Make sure the scene is running when it's executed
        sceneView.isPlaying = true
        // Allow the user to rotate around the model
        sceneView.allowsCameraControl = true
        
        // Add the scene to the view
        self.view.addSubview(sceneView)
        
        // The text we want to convert into voice
        let textToSay = AVSpeechUtterance(string: "This is Noaa 19, one of the Polar Orbiting Environmental Satellites owned by the National Oceanic and Atmospheric Administration. It's main purpose is to deliver weather data to meteorologists around the world. It moves in a polar orbit, which means it travles from the north pole to the south pole or the other way around.")
        // Set how fast it should talk
        textToSay.rate = 0.4
        
        // Add a little delay to allow loading of the scene
        textToSay.preUtteranceDelay = 3
        
        // Now, speak the text
        speechSynthesizer.speak(textToSay)
        
    }

    
}
