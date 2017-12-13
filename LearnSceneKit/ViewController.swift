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
//        addGeometry(SCNSphere.init(radius: 0.5))
        addGeometry(Cube.init(size: SCNVector3.init(1, 1, 1)))
    }

    func addGeometry(_ geometry: SCNGeometry) {
        let node = SCNNode()
        node.geometry = geometry
        var materials: [SCNMaterial] = []
        var colors: [UIColor] = [
            UIColor.init(red: 0xff / 255.0, green: 0xe5 / 255.0, blue: 0.0, alpha: 1.0),
            UIColor.init(red: 0xe9 / 255.0, green: 0.0, blue: 0x3a / 255.0, alpha: 1.0),
            UIColor.init(red: 0x07 / 255.0, green: 0x76 / 255.0, blue: 0xa0 / 255.0, alpha: 1.0),
            UIColor.init(red: 0xf4 / 255.0, green: 0x43 / 255.0, blue: 0x36 / 255.0, alpha: 1.0),
            UIColor.init(red: 0x68 / 255.0, green: 0x9f / 255.0, blue: 0x38 / 255.0, alpha: 1.0),
            UIColor.init(red: 0xef / 255.0, green: 0x6c / 255.0, blue: 0.0, alpha: 1.0),
        ]
        for i in 0..<6 {
            let material = SCNMaterial()
            material.lightingModel = .blinn
            let diffuseMap = NumberImageGenerator.createImage(number: i + 1, foregroundColor: colors[(i + 1) % colors.count], backgroundColor: colors[i % colors.count], size: CGSize.init(width: 128, height: 128))
            material.diffuse.contents = diffuseMap
            material.diffuse.minificationFilter = .nearest
            material.diffuse.magnificationFilter = .nearest
            material.shininess = 1.0
            materials.append(material)
        }
        geometry.materials = materials
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

