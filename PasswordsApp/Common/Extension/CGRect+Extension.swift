//
//  CGRect+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/10/22.
//

import UIKit

extension CGRect {

    func rect(point: CGPoint, xRemainder: Bool, yRemainder: Bool) -> CGRect {
        let xDiv = divided(atDistance: point.x, from: .minXEdge)
        let x = xRemainder ? xDiv.remainder : xDiv.slice
        let yDiv = x.divided(atDistance: point.y, from: .minYEdge)
        return yRemainder ? yDiv.remainder : yDiv.slice
    }

    func area(corner: SourceViewCorner) -> CGFloat {
        let (xRemainder, yRemainder): (Bool, Bool)
        switch corner.position {
        case .topLeft:
            (xRemainder, yRemainder) = (false, false)
        case .topRight:
            (xRemainder, yRemainder) = (true, false)
        case .bottomLeft:
            (xRemainder, yRemainder) = (false, true)
        case .bottomRight:
            (xRemainder, yRemainder) = (true, true)
        }
        let frame = rect(point: corner.point, xRemainder: xRemainder, yRemainder: yRemainder)
        return frame.width * frame.height
    }

}

extension CGRect {

    func dominantCorner(in rect: CGRect) -> SourceViewCorner? {
        let corners: [SourceViewCorner] = [
            SourceViewCorner(point: CGPoint(x: rect.minX, y: rect.minY), position: .topLeft),
            SourceViewCorner(point: CGPoint(x: rect.maxX, y: rect.minY), position: .topRight),
            SourceViewCorner(point: CGPoint(x: rect.minX, y: rect.maxY), position: .bottomLeft),
            SourceViewCorner(point: CGPoint(x: rect.maxX, y: rect.maxY), position: .bottomRight),
            ]

        var maxArea: CGFloat = 0
        var maxCorner: SourceViewCorner? = nil
        for corner in corners {
            let area = self.area(corner: corner)
            if area > maxArea {
                maxArea = area
                maxCorner = corner
            }
        }
        return maxCorner
    }

}
