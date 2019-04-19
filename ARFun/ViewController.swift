//
//  ViewController.swift
//  ARFun
//
//  Created by zappycode on 6/26/17.
//  Copyright © 2017 Nick Walter. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        for node in sceneView.scene.rootNode.childNodes {
            let moveShip = SCNAction.moveBy(x: 0, y: 0.5, z: 0.5, duration: 1)
            let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1)
            let fadeIn = SCNAction.fadeOpacity(to: 1.0, duration: 1)
            let routine = SCNAction.sequence([fadeOut,fadeIn,moveShip])
            let foreverRoutine = SCNAction.repeatForever(routine)
            
            node.runAction(foreverRoutine)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
