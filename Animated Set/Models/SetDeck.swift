//
//  SetDeck.swift
//  Set
//
//  Created by Aleksandar Ignatov on 21.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

class SetDeck {
  var cards: [SetCard] = []
  
  var isEmpty: Bool {
    return cards.isEmpty
  }
  
  init(randomize: Bool = true) {
    for number in SetCard.Number.allCases {
      for shape in SetCard.Shape.allCases {
        for shading in SetCard.Shading.allCases {
          for color in SetCard.Color.allCases {
            cards.append(SetCard(number: number, shape: shape, shading: shading, color: color))
          }
        }
      }
    }
    
    if randomize {
      cards.shuffle()
    }
  }
  
  func draw() -> SetCard {
    return cards.removeLast()
  }
}
