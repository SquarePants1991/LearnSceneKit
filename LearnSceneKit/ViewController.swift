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
    var geometryNodes: [SCNNode] = [SCNNode]()
    var currentShowGeometryIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create & Config Scene
        scene = SCNScene()
        scene.background.contents = UIColor.black
        createCamera()
//        createLight()
        createGeometries()
        nextGeometry(1)

        // Config SCNView
        if let scnView = self.view as? SCNView {
            scnView.scene = scene

            scnView.allowsCameraControl = true
            scnView.showsStatistics = true
            scnView.autoenablesDefaultLighting = true
        }
        
    }

    func createCamera() {
        let node = SCNNode()
        node.camera = SCNCamera()
        node.position = SCNVector3.init(0, 0, 4.2)
        scene.rootNode.addChildNode(node)
    }

    func createLight() {
        // red light
        let redLightNode = SCNNode()
        redLightNode.light = SCNLight()
        redLightNode.light?.type = .omni
        redLightNode.light?.color = UIColor.red
        redLightNode.position = SCNVector3.init(6, 6, 3)
        scene.rootNode.addChildNode(redLightNode)

        // green light
        let greenLightNode = SCNNode()
        greenLightNode.light = SCNLight()
        greenLightNode.light?.type = .omni
        greenLightNode.light?.color = UIColor.green
        greenLightNode.position = SCNVector3.init(-6, 6, 3)
        scene.rootNode.addChildNode(greenLightNode)

        // blue light
        let blueLightNode = SCNNode()
        blueLightNode.light = SCNLight()
        blueLightNode.light?.type = .omni
        blueLightNode.light?.color = UIColor.blue
        blueLightNode.position = SCNVector3.init(0, -6, 3)
        scene.rootNode.addChildNode(blueLightNode)
    }

    @objc
    func nextGeometry(_ step: Int) {
        if (currentShowGeometryIndex >= 0 && currentShowGeometryIndex < geometryNodes.count) {
            geometryNodes[currentShowGeometryIndex].removeFromParentNode()
        }
        currentShowGeometryIndex += step
        if (currentShowGeometryIndex >= geometryNodes.count) {
            currentShowGeometryIndex = 0
        }
        if (currentShowGeometryIndex < 0) {
            currentShowGeometryIndex = geometryNodes.count - 1
        }
        let currentNode = geometryNodes[currentShowGeometryIndex]
        scene.rootNode.addChildNode(currentNode)
    }

    func createGeometries() {
        addGeometry(Plane.init(size: CGPoint.init(x: 1, y: 1)))
        addGeometry(PlaneUseIndice.init(size: CGPoint.init(x: 1, y: 1)))
        addGeometry(Cube.init(size: SCNVector3.init(1, 1, 1)))
    }

    func addGeometry(_ geometry: SCNGeometry) {
        let node = SCNNode()
        node.geometry = geometry
        geometryNodes.append(node)
    }
    
    // MARK: Buttons
    
    @IBAction func prevButtonClicked(_ sender: Any) {
        nextGeometry(-1)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        nextGeometry(1)
    }
}

