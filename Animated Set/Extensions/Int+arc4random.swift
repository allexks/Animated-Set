//
//  Int+arc4random.swift
//  Animated Set
//
//  Created by Aleksandar Ignatov on 6.06.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

extension Int {
  var arc4random: Int {
    guard self != 0 else {
      return 0
    }
    guard self > 0 else {
      return -(-self).arc4random
    }
    
    return Int(arc4random_uniform(UInt32(self)))
  }
}
