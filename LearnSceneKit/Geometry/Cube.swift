//
//  Cube.swift
//  LearnSceneKit
//
//  Created by yang wang on 2017/11/30.
//  Copyright © 2017年 yang wang. All rights reserved.
//

import SceneKit

class Cube: SCNGeometry {
    var cubeSize: SCNVector3?
    
    convenience init(size: SCNVector3) {
        let vertexData = Cube.cubeData()
        let verticeCount = vertexData.count / (MemoryLayout<Float>.size * 8)
        let verticeSource = SCNGeometrySource.init(data: vertexData, semantic: .vertex, vectorCount: verticeCount, usesFloatComponents: true, componentsPerVector: 3, bytesPerComponent: MemoryLayout<Float>.size, dataOffset: 0, dataStride: MemoryLayout<Float>.size * 8)
        let normalSource = SCNGeometrySource.init(data: vertexData, semantic: .normal, vectorCount: verticeCount, usesFloatComponents: true, componentsPerVector: 3, bytesPerComponent: MemoryLayout<Float>.size, dataOffset: MemoryLayout<Float>.size * 3, dataStride: MemoryLayout<Float>.size * 8)
        let uvSource = SCNGeometrySource.init(data: vertexData, semantic: .texcoord, vectorCount: verticeCount, usesFloatComponents: true, componentsPerVector: 2, bytesPerComponent: MemoryLayout<Float>.size, dataOffset: MemoryLayout<Float>.size * 6, dataStride: MemoryLayout<Float>.size * 8)

        var elements: [SCNGeometryElement] = []
        for i in 0..<6 {
            var indices: [UInt32] = []
            (0..<6).forEach { indices.append(UInt32(i * 6) + UInt32($0)) }
            let element = SCNGeometryElement.init(indices: indices, primitiveType: .triangles)
            elements.append(element)
        }
        self.init(sources: [verticeSource, uvSource, normalSource], elements: elements)
        self.cubeSize = size
    }
    
    class func cubeData() -> Data {
        let _cubeData: [Float] = [
            // Z轴0.5处的平面
            -0.5,   0.5,  0.5,   0,  0,  1, 0, 0,
            -0.5,  -0.5,  0.5,  0,  0,  1, 0, 1,
            0.5,   -0.5,  0.5,  0,  0,  1, 1, 1,
            0.5,    -0.5, 0.5,   0,  0,  1, 1, 1,
            0.5,    0.5,  0.5,    0,  0,  1, 1, 0,
            -0.5,   0.5,  0.5,  0,  0,  1, 0, 0,

            // X轴-0.5处的平面
            -0.5,  0.5,   -0.5, -1,  0,  0, 0, 0,
            -0.5,  -0.5,  -0.5, -1,  0,  0, 0, 1,
            -0.5,  -0.5,    0.5, -1,  0,  0, 1, 1,
            -0.5,  -0.5,   0.5, -1,  0,  0, 1, 1,
            -0.5,  0.5,    0.5, -1,  0,  0, 1, 0,
            -0.5,  0.5,    -0.5, -1,  0,  0, 0, 0,

            // Z轴-0.5处的平面
            0.5,   -0.5,  -0.5,  0,  0,  -1, 0, 1,
            -0.5,  -0.5,  -0.5,  0,  0,  -1, 1, 1,
            -0.5,   0.5,  -0.5,   0,  0,  -1, 1, 0,
            -0.5,   0.5,  -0.5,  0,  0,  -1, 1, 0,
            0.5,    0.5,  -0.5,    0,  0,  -1, 0, 0,
            0.5,   -0.5,  -0.5,   0,  0,  -1, 0, 1,

            // X轴0.5处的平面
            0.5,  -0.5,    0.5, 1,  0,  0, 0, 1,
            0.5,  -0.5,  -0.5, 1,  0,  0, 1, 1,
            0.5,  0.5,   -0.5, 1,  0,  0, 1, 0,
            0.5,  0.5,    -0.5, 1,  0,  0, 1, 0,
            0.5,  0.5,    0.5, 1,  0,  0, 0, 0,
            0.5,  -0.5,   0.5, 1,  0,  0, 0, 1,

            // Y轴0.5处的平面
            0.5, 0.5,  -0.5, 0,  1,  0, 1, 0,
            -0.5, 0.5, -0.5, 0,  1,  0, 0, 0,
            -0.5,  0.5,  0.5, 0,  1,  0, 0, 1,
            -0.5, 0.5,  0.5, 0,  1,  0, 0, 1,
            0.5, 0.5,   0.5, 0,  1,  0, 1, 1,
            0.5,  0.5,  -0.5, 0,  1,  0, 1, 0,

            // Y轴-0.5处的平面
            -0.5, -0.5,   0.5, 0,  -1,  0, 0, 0,
            -0.5, -0.5, -0.5, 0,  -1,  0, 0, 1,
            0.5, -0.5,  -0.5, 0,  -1,  0, 1, 1,
            0.5,  -0.5,  -0.5, 0,  -1,  0, 1, 1,
            0.5, -0.5,   0.5, 0,  -1,  0, 1, 0,
            -0.5, -0.5,  0.5, 0,  -1,  0, 0, 0,
            
        ]
        return Data.init(bytes: _cubeData, count: MemoryLayout<Float>.size * _cubeData.count)
    }
}
