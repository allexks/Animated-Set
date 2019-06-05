//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 16.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

class ConcentrationGame {
  
  // MARK: - Properties
  
  weak var delegate: ConcentrationGameDelegate?
  private(set) var cards: [ConcentrationCard] = []
  private var involvedInAMismatch: [Int: Bool] = [:]
  private(set) var score: Int = 0 {
    didSet {
      delegate?.updateScore(newScore: score)
    }
  }
  /// Score update rules
  private let scoreUpdateOnMatch = +2
  private let scoreUpdateOnMismatchForCard = -1
  
  // MARK: - Methods
  
  init(pairsCount: Int) {
    guard pairsCount > 0 else { return }
    
    for _ in 1...pairsCount {
      let newCard = ConcentrationCard()
      cards += [newCard, newCard]
    }
    
    cards.shuffle()
    
    for i in 0 ..< cards.count {
      involvedInAMismatch[i] = false
    }
  }
  
  func canPickCard(with index: Int) -> Bool {
    return cards[index].status == .faceDown
  }
  
  func pickCard(with index: Int) {
    guard canPickCard(with: index) else { return }
    
    cards[index].status = .faceUp

    let faceUpCardsIndices = getCardsIndices(for: .faceUp)
    
    if faceUpCardsIndices.count == 2 {
      let index1 = faceUpCardsIndices.first!
      let index2 = faceUpCardsIndices.last!
      let card1 = cards[index1]
      let card2 = cards[index2]
      
      if card1.id == card2.id {
        // Match!
        cards[index1].status = .matched
        cards[index2].status = .matched
        score = score + scoreUpdateOnMatch
        delegate?.registerMatch(firstIndex: index1, secondIndex: index2)
      } else {
        // Mismatch!
        var numOfPrevPickedCards = 0
        for i in faceUpCardsIndices {
          if involvedInAMismatch[i]! {
            numOfPrevPickedCards = numOfPrevPickedCards + 1
          }
          involvedInAMismatch[i] = true
          cards[i].status = .faceDown
        }
        score = score + numOfPrevPickedCards * scoreUpdateOnMismatchForCard
        delegate?.registerMismatch(firstIndex: index1, secondIndex: index2)
      }
    }
  }
  
  func getCardsIndices(for status: ConcentrationCard.Status) -> [Int] {
    return cards.enumerated().filter{ $0.element.status == status }.map{ $0.offset }
  }
}
