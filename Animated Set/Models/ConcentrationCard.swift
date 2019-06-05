//
//  ConcentrationCard.swift
//  Animated Set
//
//  Created by Aleksandar Ignatov on 5.06.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

struct ConcentrationCard {
  typealias IDType = UInt64
  private static var lastId: IDType = 0
  private static func generateNextId() -> IDType {
    lastId = lastId + 1
    return lastId
  }
  
  let id: IDType!
  var status: Status = .faceDown
  
  init() {
    id = ConcentrationCard.generateNextId()
  }
}

extension ConcentrationCard {
  enum Status {
    case faceDown
    case faceUp
    case matched
  }
}
