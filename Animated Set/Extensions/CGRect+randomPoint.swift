//
//  CGRect+randomPoint.swift
//  Animated Set
//
//  Created by Aleksandar Ignatov on 6.06.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

extension CGRect {
  var randomPoint: CGPoint {
    return CGPoint(x: Int(width).arc4random,
                   y: Int(height).arc4random)
  }
}
