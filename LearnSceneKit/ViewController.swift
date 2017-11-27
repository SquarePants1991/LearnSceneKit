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
        node.position = SCNVector3.init(0, 0, 6)
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
        //SCNPlane, SCNBox, SCNSphere, SCNPyramid, SCNCone, SCNCylinder, SCNCapsule, SCNTube, and SCNTorus
        addGeometry(SCNTorus.init(ringRadius: 0.5, pipeRadius: 0.1))
        addGeometry(SCNPlane.init(width: 1, height: 1))
        addGeometry(SCNBox.init(width: 1, height: 1, length: 1, chamferRadius: 0.3))
        addGeometry(SCNSphere.init(radius: 0.5))
        addGeometry(SCNPyramid.init(width: 1, height: 1, length: 1))
        let cone = SCNCone.init(topRadius: 0.1, bottomRadius: 0.5, height: 1)
        cone.radialSegmentCount = 3
        addGeometry(cone)
        addGeometry(SCNCylinder.init(radius: 0.5, height: 1))
        addGeometry(SCNCapsule.init(capRadius: 0.1, height: 1))
        addGeometry(SCNTube.init(innerRadius: 0.3, outerRadius: 0.5, height: 0.4))


        //SCNText, SCNShape
        let attrs: [NSAttributedStringKey: Any] = [ .font: UIFont.systemFont(ofSize: 1) ]
        let textGeometry = SCNText.init(string: NSAttributedString.init(string: "handy\nTool", attributes: attrs), extrusionDepth: 0.4)
        textGeometry.chamferRadius = 0.1
        textGeometry.flatness = 0.5
        addGeometry(textGeometry)

        let shape = SCNShape.init(path: UIBezierPath.init(rect: CGRect.init(x: -0.5, y: 0.5, width: 1, height: 1)), extrusionDepth: 0.5)
        addGeometry(shape)
    }

    func addGeometry(_ geometry: SCNGeometry) {
        let node = SCNNode()
        node.geometry = geometry
        let (minVec, maxVec) = node.boundingBox
        node.position = SCNVector3.init(-(minVec.x + maxVec.x) / 2, -(minVec.y + maxVec.y) / 2, 0)
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

