import Foundation
import SceneKit
import UIKit
import AVFoundation

open class SatelliteScene : UIViewController {
    
    // Setting up the global variables
    
    var sceneView : SCNView!
    var scene : SCNScene!
    var camera : SCNNode!
    let material = SCNMaterial()
    
    let speakerButton = UIButton()
    let speakerVolumeSlider = UISlider()
    var dataSignalPlayer : AVAudioPlayer?
    
    // Default values to prevent crashes
    let volumeLevel = 2.0
    var orbitType = 1.0
    var orbitDuration = 60.0
    
    // Setting up the scene
    
    open func setupScene() {
        
        // Initializing the scene view
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        // Loading the model with a different camera position
        scene = SCNScene(named: "NOAA1.scn")
        // Let SceneKit manage the lighting
        sceneView.autoenablesDefaultLighting = true
        // Assigning the scene to the scene view
        sceneView.scene = scene
        // Setting the background color to black
        sceneView.backgroundColor = UIColor.black
        // Making sure it is running when it's executed
        sceneView.isPlaying = true
        // Add it to the main view
        self.view.addSubview(sceneView)
        
    }
    
    // function to give the earth model a more realistic 3D effect
    open func makeEarth3D(boolean: Bool) {
        if boolean == true {
            // if set to yes, apply the normal texture to the material
            material.normal.contents = UIImage(named: "normal.jpg")
        }
    }
    
    // function to add clouds to the earth model
    open func addClouds(boolean: Bool) {
        if boolean == true {
            // if set to yes, load the cloud texture
            material.diffuse.contents = UIImage(named: "earth-clouds.jpg")
        } else {
            // if not, load the normal texture
            material.diffuse.contents = UIImage(named: "earth.jpg")
        }
    }
    
    // function to set the orbit type
    open func setOrbitType(type: String) {
        if type == "northbound" {
            // set the orbit type to northbound - roatate upward
            orbitType = 1.0
        } else if type == "southbound" {
            // set the orbit type to southbound - rotate downwards
            orbitType = -1.0
        } else {
            // if typed incorrectly, set the orbit to northbound to prevent a crash
            orbitType = 1.0
        }
    }
    
    // function to add volume controls
    open func addVolumeControls() {

        // assign a size and position to the button
        speakerButton.frame = CGRect(x: 8, y: 8, width: 40, height: 40)
        // set a default texture according to the default volume level
        speakerButton.setImage(UIImage(named: "speaker-2.png"), for: .normal)
        // once clicked, execute function to display or hide the volume slider
        speakerButton.addTarget(self, action: #selector(showVolumeSlider), for: .touchUpInside)
        
        // assign a size and position to the slider. position is on the right side of the button
        speakerVolumeSlider.frame = CGRect(x: 8 + speakerButton.frame.width + 8, y: 16, width: 100, height: 20)
        // set the volume according to the current volume
        speakerVolumeSlider.value = Float(volumeLevel)
        // specify the minimum volume = muted
        speakerVolumeSlider.minimumValue = 0.0
        // specify the maximum volume
        speakerVolumeSlider.maximumValue = 4.0
        // execute function once the value of the slider changes
        speakerVolumeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        // add the slider to main view
        sceneView.addSubview(speakerVolumeSlider)
        // make sure it is hidden until the control button is pressed
        speakerVolumeSlider.isHidden = true
        // add the button to the main view
        sceneView.addSubview(speakerButton)
        
    }
    
    // function to update the volume based on the slider value
    @objc func sliderValueChanged(sender: AnyObject) {
        
        // tell the function that the sender is a UISlider
        let slider = sender as! UISlider
        
        // set the volume level of the audio player based on the current slider value
        dataSignalPlayer!.setVolume(slider.value, fadeDuration: 0.2)
        
        // detect the current volume level
        switch slider.value {
        // between 0 and 1
        case 0.0...1.0:
            // update the button image for the lowest value
            speakerButton.setImage(UIImage(named: "speaker-1.png"), for: .normal)
        // between 1 and 2
        case 1.0...2.0:
            // update the button image for the second lowest value
            speakerButton.setImage(UIImage(named: "speaker-2.png"), for: .normal)
        // between 2 and 3
        case 2.0...3.0:
            // update the button image for the second highest value
            speakerButton.setImage(UIImage(named: "speaker-3.png"), for: .normal)
        // between 3 and 4
        case 3.0...4.0:
            // update the button image for the highest value
            speakerButton.setImage(UIImage(named: "speaker-4.png"), for: .normal)
        // in case something goes wrong
        default:
            print("default error")
        }
        
        
    }
    
    // function to hide or display the volume slider
    @objc func showVolumeSlider() {
        
        if speakerVolumeSlider.isHidden == true {
            // if the slider is hidden, display it
            speakerVolumeSlider.isHidden = false
        } else {
            // if it is not hidden, hide it
            speakerVolumeSlider.isHidden = true
        }
        
    }
    
    // function to add the satellite audio signal
    open func addSatelliteSignalSound() {
        
        // load the audio file from the resources folder
        let path = Bundle.main.path(forResource: "datasignal.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
        // try to load the file into the audio player
        dataSignalPlayer = try AVAudioPlayer(contentsOf: url)
        // make sure it runs forever
        dataSignalPlayer!.numberOfLoops = -1
        // play the audio
        dataSignalPlayer!.play()
        } catch {
            // if something goes wrong print error
            print("error playing file")
        }
        
    }
    
    // function to update the orbit duration value
    open func setOrbitDuration(seconds: Double) {
        // update the value
        orbitDuration = seconds
    }
    
    // function to add the earth to the scene
    open func addEarth() {
        
        // Initialize a sphere with a radius of 9
        let earth = SCNSphere.init(radius: 9)
        // convert the sphere into a scene node
        let earthNode = SCNNode.init(geometry: earth)
        
        // assign the material properties
        earth.firstMaterial = material
        
        // set the position of the earth
        earthNode.position = SCNVector3(x: 0, y: -9, z: -5)
        // rotate the earth based on the orbit type and duration
        let action = SCNAction.rotate(by:360 * CGFloat((Double.pi)/180.0), around: SCNVector3(x: Float(orbitType), y: -0.1, z: 0), duration: orbitDuration)
        // make the action run forever
        let repeatAction = SCNAction.repeatForever(action)
        // run the action
        earthNode.runAction(repeatAction)
        
        // finally, add the earth to the scene
        scene.rootNode.addChildNode(earthNode)
        
        
    }
    
    
    
}
