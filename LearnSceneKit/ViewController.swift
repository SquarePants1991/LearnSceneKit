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
        createLight()
        createGeometries()
        nextGeometry(1)

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
        node.position = SCNVector3.init(0, 0, 4.2)
        scene.rootNode.addChildNode(node)
    }

    func createLight() {
        let whiteLightNode = SCNNode()
        whiteLightNode.light = SCNLight()
        whiteLightNode.light?.type = .omni
        whiteLightNode.light?.color = UIColor.white
        whiteLightNode.position = SCNVector3.init(0, 6, 3)
        scene.rootNode.addChildNode(whiteLightNode)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        scene.rootNode.addChildNode(ambientLightNode)
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
        addGeometry(SCNSphere.init(radius: 0.5))
    }

    func addGeometry(_ geometry: SCNGeometry) {
        let node = SCNNode()
        node.geometry = geometry
        let material = SCNMaterial()
        material.lightingModel = .blinn
        material.diffuse.contents = UIImage.init(named: "earth.jpg") //UIColor.red
        material.ambient.contents = UIColor.init(white: 0.1, alpha: 1)
        material.locksAmbientWithDiffuse = false
        material.specular.contents = UIImage.init(named: "earth_specular.png") //UIColor.white

        material.shininess = 1.0
        material.reflective.contents = [
            UIImage.init(named: "cube-1.jpg"),
            UIImage.init(named: "cube-2.jpg"),
            UIImage.init(named: "cube-3.jpg"),
            UIImage.init(named: "cube-4.jpg"),
            UIImage.init(named: "cube-5.jpg"),
            UIImage.init(named: "cube-6.jpg"),
        ]
        material.fresnelExponent = 1.7

        material.normal.contents = UIImage.init(named: "earth_NRM.png")
        geometry.materials = [material]
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

