//
//  PlaneUseIndice.swift
//  LearnSceneKit
//
//  Created by yang wang on 2017/12/1.
//  Copyright © 2017年 yang wang. All rights reserved.
//

import SceneKit

class PlaneUseIndice: SCNGeometry {
    
    convenience init(size: CGPoint) {
        let vertices: [SCNVector3] = [
            SCNVector3(-0.5 * size.x, 0.5 * size.y, 0),
            SCNVector3(-0.5 * size.x, -0.5 * size.y, 0),
            SCNVector3(0.5 * size.x, -0.5 * size.y, 0),
            SCNVector3(0.5 * size.x, 0.5 * size.y, 0)
        ]
        let vertexSource = SCNGeometrySource.init(vertices: vertices)
        
        let uvs: [CGPoint] = [
            CGPoint(x: 0, y: 1),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0),
            CGPoint(x: 1, y: 1),
            ]
        let uvSource = SCNGeometrySource.init(textureCoordinates: uvs)
        
        let normals: [SCNVector3] = [
            SCNVector3(0, 0, 1),
            SCNVector3(0, 0, 1),
            SCNVector3(0, 0, 1),
            SCNVector3(0, 0, 1),
            ]
        let normalSource = SCNGeometrySource.init(normals: normals)
        
        let indices: [UInt8] = [1, 2, 0, 3]
        let element = SCNGeometryElement.init(indices: indices, primitiveType: .triangleStrip)
        self.init(sources: [vertexSource, uvSource, normalSource], elements: [element])
    }
}

