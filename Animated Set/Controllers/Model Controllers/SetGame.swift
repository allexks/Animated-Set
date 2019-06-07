//
//  SetGame.swift
//  Set
//
//  Created by Aleksandar Ignatov on 21.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

class SetGame {
  // MARK: - Properties
  private let deck = SetDeck()
  private(set) var score = 0 {
    didSet {
      delegate?.updateScore(with: score)
    }
  }
  
  private let scoreRules: ScoreRules = .easy
  
  private(set) var availableCards: Set<SetCard> = []
  private(set) var discardedCards: Set<SetCard> = []
  private(set) var selectedCards: Set<SetCard> = [] {
    didSet {
      delegate?.updateSelectedCards()
    }
  }
  
  weak var delegate: SetGameDelegate?
  
  // MARK: - Methods
  
  static func isSet(_ cardsArr: Set<SetCard>) -> Bool {
    guard cardsArr.count == 3 else {
      return false
    }
    
    let numbers = Set(cardsArr.map{ $0.number })
    let shapes = Set(cardsArr.map{ $0.shape })
    let shadings = Set(cardsArr.map{ $0.shading })
    let colors = Set(cardsArr.map{ $0.color })
    
    return true || numbers.count == SetCard.Number.allCases.count
        && shapes.count == SetCard.Shape.allCases.count
        && shadings.count == SetCard.Shading.allCases.count
        && colors.count == SetCard.Color.allCases.count
  }
  
  
  func selectCard(_ card: SetCard) {
    if SetGame.isSet(selectedCards) {
      removeMatchedCards()
      if selectedCards.contains(card) {
        selectedCards = []
        return
      }
    }
    
    if selectedCards.count == 3 {
      selectedCards = []
    }
    
    if selectedCards.contains(card) {
      selectedCards.remove(card)
    } else {
      selectedCards.insert(card)
    }
    
    if SetGame.isSet(selectedCards) {
      score = score + scoreRules.updateOnMatch
      delegate?.foundSet()
    } else if selectedCards.count == 3 {
      score = score + scoreRules.updateOnMismatch
      delegate?.foundMismatch()
    }
  }
  
  func dealThreeCards() {
    guard !deck.isEmpty else { return }
    
    if SetGame.isSet(selectedCards) {
      removeMatchedCards()
      selectedCards = []
    }
    
    3.repetitions {
      self.availableCards.insert(self.deck.draw())
    }
    
    if let scoreChange = scoreRules.updateOnDealingThreeCards {
      score = score + scoreChange
    }
    
    if deck.isEmpty {
      delegate?.deckGotEmpty()
    }
  }
  
  private func removeMatchedCards() {
    assert(selectedCards.count == 3 && selectedCards.isSubset(of: availableCards))
    
    availableCards.formSymmetricDifference(selectedCards) // remove
    discardedCards.formUnion(selectedCards) // add
    
    if availableCards.count == 0 && deck.isEmpty {
      delegate?.gameOver()
    }
  }
}

// MARK: - Score Rules

extension SetGame {
  enum ScoreRules {
    case easy, medium, hard
    case custom(updateOnMatch: Int, updateOnMismatch: Int, updateOnDealingThreeCards: Int?)
    
    var updateOnMatch: Int {
      switch self {
      case .easy:
        return +20
      case .medium:
        return +10
      case .hard:
        return +5
      case .custom(let x, _, _):
        return x
      }
    }
    
    var updateOnMismatch: Int {
      switch self {
      case .easy:
        return -5
      case .medium:
        return -10
      case .hard:
        return -20
      case .custom(_, let x, _):
        return x
      }
    }
    
    var updateOnDealingThreeCards: Int? {
      switch self {
      case .easy, .medium:
        return nil
      case .hard:
        return -5
      case .custom(_, _, let x):
        return x
      }
    }
  }
}
