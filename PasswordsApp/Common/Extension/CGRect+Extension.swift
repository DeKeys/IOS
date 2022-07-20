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

}
