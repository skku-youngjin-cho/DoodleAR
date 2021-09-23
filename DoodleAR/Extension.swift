//
//  Extension.swift
//  DoodleAR
//
//  Created by Cho Youngjin on 2021/07/24.
//

import Foundation

public extension Float {
    static func random() -> Float {
        return Float(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}
