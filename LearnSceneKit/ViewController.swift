//
//  ViewController.swift
//  LearnSceneKit
//
//  Created by yang wang on 2017/11/24.
//  Copyright © 2017年 yang wang. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    var scene: SCNScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create & Config Scene
        scene = SCNScene()
        scene.background.contents = UIColor.black
        createCamera()
        createLight()
        createGeometry()

        // Config SCNView
        if let scnView = self.view as? SCNView {
            scnView.scene = scene

            scnView.allowsCameraControl = true
            scnView.showsStatistics = true
        }
    }

    func createCamera() {
        let node = SCNNode()
        node.camera = SCNCamera()
        node.position = SCNVector3.init(0, 0, 2)
        scene.rootNode.addChildNode(node)
    }

    func createLight() {
        // red light
        let redLightNode = SCNNode()
        redLightNode.light = SCNLight()
        redLightNode.light?.type = .omni
        redLightNode.light?.color = UIColor.red
        redLightNode.position = SCNVector3.init(6, 6, 0)
        scene.rootNode.addChildNode(redLightNode)

        // green light
        let greenLightNode = SCNNode()
        greenLightNode.light = SCNLight()
        greenLightNode.light?.type = .omni
        greenLightNode.light?.color = UIColor.green
        greenLightNode.position = SCNVector3.init(-6, 6, 0)
        scene.rootNode.addChildNode(greenLightNode)

        // blue light
        let blueLightNode = SCNNode()
        blueLightNode.light = SCNLight()
        blueLightNode.light?.type = .omni
        blueLightNode.light?.color = UIColor.blue
        blueLightNode.position = SCNVector3.init(0, -6, 0)
        scene.rootNode.addChildNode(blueLightNode)
    }

    func createGeometry() {
        let node = SCNNode()
        node.geometry = SCNSphere.init(radius: 0.3)
        node.position = SCNVector3.init(0, 0, 0)
        scene.rootNode.addChildNode(node)
    }
}

