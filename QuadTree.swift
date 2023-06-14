//
//  QuadTree.swift
//  QuadTree
//
//  Created by Evgeny Gorborukov on 24.05.2023.
//

import Foundation
import CoreGraphics

class QuadTree {
    let boundary: CGRect
    let capacity: Int
    var points: [CGPoint] = []
    var subdivided: Bool = false
    let depth: Int

    var children: [QuadTree] = []

    init(boundary: CGRect, capacity: Int, depth: Int = 0) {
        self.boundary = boundary
        self.capacity = capacity
        self.depth = depth
    }

    func insert(_ point: CGPoint) -> Bool {
        if !boundary.contains(point) {
            return false
        }

        if points.count < capacity {
            points.append(point)
            return true
        } else {
            if !subdivided {
                subdivide()
            }

            for child in children {
                if child.insert(point) {
                    return true
                }
            }
            return false
        }
    }

    func subdivide() {
        if subdivided { return }
        subdivided = true
        
        let x = boundary.origin.x
        let y = boundary.origin.y
        let w = boundary.size.width
        let h = boundary.size.height

        let nw = CGRect(x: x, y: y, width: w/2, height: h/2)
        let ne = CGRect(x: x + w/2, y: y, width: w/2, height: h/2)
        let se = CGRect(x: x + w/2, y: y + h/2, width: w/2, height: h/2)
        let sw = CGRect(x: x, y: y + h/2, width: w/2, height: h/2)

        children.append(QuadTree(boundary: nw, capacity: capacity, depth: depth + 1))
        children.append(QuadTree(boundary: ne, capacity: capacity, depth: depth + 1))
        children.append(QuadTree(boundary: se, capacity: capacity, depth: depth + 1))
        children.append(QuadTree(boundary: sw, capacity: capacity, depth: depth + 1))
    }
}
