//
//  ViewController.swift
//  Graphical Set
//
//  Created by Aleksandar Ignatov on 27.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var gridView: UIView!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
  @IBOutlet weak var deckView: UIView!
  @IBOutlet weak var discardPileView: UIView!
  
  // MARK: - Properties
  private let startingRows = 4
  
  private let distanceBetweenCards = CGFloat(10)
  private let selectedCardOutlineColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
  private let matchedCardOutlineColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
  private let mismatchedCardOutlineColor: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
  
  private let cardFlipDuration = 0.5
  private let cardMoveDuration = 0.5
  
  private let cardBouncesTotal = 3
  private let cardBounceDuration = 0.3
  
  private var game: SetGame! {
    didSet {
      game.delegate = self
    }
  }
  
  private var deckIsEmpty = false
  private var deckTopCard: CardView! {
    didSet {
      deckTopCard.delegate = self
    }
  }
  
  private var grid: Grid!
  private var tagForCard: [SetCard : Int] = [:]
  
  private var safeAreaAsView: UIView {
    let guide = view.safeAreaLayoutGuide
    return UIView(frame: guide.layoutFrame)
  }
  
  // MARK: - View Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    deckTopCard = CardView(frame: deckView.bounds)
    deckView.addSubview(deckTopCard)
    constraintCard(deckTopCard, to: deckView)
    
    grid = Grid(layout: .dimensions(rowCount: startingRows, columnCount: 3),
                frame: gridView.bounds)
    
    game = SetGame()
    startingRows.repetitions {
      dealThree()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    grid.frame = gridView.bounds
    populateGrid()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.verticalSizeClass == .compact {
      swipeGestureRecognizer.direction = .left
    } else {
      swipeGestureRecognizer.direction = .up
    }
  }
    
  // MARK: - Actions
  @IBAction func onSwipe(_ sender: UISwipeGestureRecognizer) {
    if !deckIsEmpty {
      dealThree()
    }
  }
  
  // MARK: - Helpers
  private func updateViews() {
    animateAndRemoveMatchedCards()
    makeOutlines()
    populateGrid()
  }
  
  private func dealThree() {
    guard !deckIsEmpty else { return }
    game.dealThreeCards()
    populateGrid()
  }
  
  private func populateGrid() {
    let gridLen = game.availableCards.count / 3
    
    guard gridLen > 0 else { return }
    
    grid.layout = traitCollection.verticalSizeClass == .compact ? .dimensions(rowCount: 3, columnCount: gridLen) : .dimensions(rowCount: gridLen, columnCount: 3)
    
    for card in game.availableCards {
      if let oldTag = tagForCard[card], grid[oldTag] == nil {
        // match was found and the grid got smaller => rearrange
        let newTag = getFirstFreeGridIndex()
        let cardView = gridView.viewWithTag(oldTag)
        cardView?.tag = newTag
        tagForCard[card] = newTag
      } else if tagForCard[card] == nil {
        // new cards have been added
        tagForCard[card] = getFirstFreeGridIndex()
      }
      
      let tag = tagForCard[card]!
      let newFrame = grid[tag]!.insetBy(dx: distanceBetweenCards / 2,
                                        dy: distanceBetweenCards / 2)
      
      let cardView: CardView
      if let assocCardView = gridView.viewWithTag(tag) as? CardView {
        cardView = assocCardView
      } else {
        let newCardView = CardView(frame: deckView.convert(deckView.bounds, to: safeAreaAsView))
        newCardView.card = card
        newCardView.tag = tag
        newCardView.delegate = self
        gridView.addSubview(newCardView)
        cardView = newCardView
      }
      
      if cardView.frame != newFrame {
        moveCard(cardView, to: newFrame, completionClosure: { _ in
          cardView.isFaceUp = true
        })
      }
    }
  }
  
  private func animateAndRemoveMatchedCards() {
    var matchedCardsViews: [CardView] = []
    for card in tagForCard.keys.filter({ !game.availableCards.contains($0) }) {
      if let tag = tagForCard[card],
        let cardView = gridView.viewWithTag(tag) as? CardView {
        matchedCardsViews.append(cardView)
        cardView.delegate = nil
        cardView.removeFromSuperview()
        discardPileView.addSubview(cardView)
        cardView.frame = discardPileView.convert(cardView.frame, from: gridView)
        tagForCard[cardView.card!] = nil
      }
    }
    
    for card in matchedCardsViews {
      for movement in 0..<cardBouncesTotal {
        let randomPoint = discardPileView.convert(view.frame.randomPoint, from: view)
        let newFrame = discardPileView.bounds
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: cardBounceDuration,
                                                       delay: Double(movement) * cardBounceDuration,
                                                       options: .curveLinear,
                                                       animations: {
                                                        card.center = randomPoint
                                                       },
                                                       completion: nil)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: cardBounceDuration,
                                                       delay: Double(cardBouncesTotal) * cardBounceDuration,
                                                       options: .curveEaseOut,
                                                       animations: {
                                                         card.frame = newFrame
        }) { [weak self] _ in
         guard let self = self else { return }
         card.removeFromSuperview()
         self.discardPileView.addSubview(card)
         self.flipCard(card, faceUp: false)
         card.layer.borderColor = UIColor.clear.cgColor
         self.constraintCard(card, to: self.discardPileView)
        }
      }
    }
  }
  
  private func makeOutlines() {
    for card in game.availableCards {
      if game.selectedCards.contains(card) {
        setOutlineColorForCardView(with: card, color: selectedCardOutlineColor)
      } else {
        setOutlineColorForCardView(with: card)
      }
    }
  }
  
  private func setOutlineColorForCardView(with card: SetCard, color: UIColor = .clear) {
    if let tag = tagForCard[card],
      let cardView = gridView.viewWithTag(tag) {
      cardView.layer.borderColor = color.cgColor
    }
  }
  
  private func getFirstFreeGridIndex() -> Int {
    return Set(stride(from: 0, to: game.availableCards.count, by: 1)).symmetricDifference(tagForCard.values).min()!
  }
  
  private func moveCard(_ card: CardView, to newFrame: CGRect, completionClosure: ((Bool)->Void)? = nil) {
    UIView.transition(with: card,
                      duration: cardMoveDuration,
                      options: .curveLinear,
                      animations: {
                        card.frame = newFrame
                      },
                      completion: completionClosure)
  }
  
  private func flipCard(_ card: CardView, faceUp: Bool = true) {
    UIView.transition(with: card,
                      duration: cardFlipDuration,
                      options: .transitionFlipFromLeft,
                      animations: {
                        card.isFaceUp = faceUp
                      },
                      completion: nil)
  }
  
  private func constraintCard(_ subview: CardView, to superview: UIView) {
    let attrList: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
    for attr in attrList {
      superview.superview!.addConstraint(NSLayoutConstraint(item: subview,
                                                            attribute: attr,
                                                            relatedBy: .equal,
                                                            toItem: superview,
                                                            attribute: attr,
                                                            multiplier: 1,
                                                            constant: 0))
    }
  }
}

// MARK: - Card View Delegate

extension SetGameViewController: CardViewDelegate {
  func onTap(_ cardView: CardView) {
    if cardView == deckTopCard {
      dealThree()
    } else if let card = cardView.card {
      game.selectCard(card)
    }
  }
}

// MARK: - Set Game Delegate

extension SetGameViewController: SetGameDelegate {
  func updateSelectedCards() {
    updateViews()
  }
  
  func foundSet() {
    updateViews()
    for card in game.selectedCards {
      setOutlineColorForCardView(with: card, color: matchedCardOutlineColor)
    }
    game.selectCard(game.selectedCards.randomElement()!) // force removal
    dealThree()
  }
  
  func foundMismatch() {
    updateViews()
    for card in game.selectedCards {
      setOutlineColorForCardView(with: card, color: mismatchedCardOutlineColor)
    }
  }
  
  func deckGotEmpty() {
    deckIsEmpty = true
    deckTopCard.isHidden = true
  }
  
  func updateScore(with newScore: Int) {
    scoreLabel.text = "Score:\n\(newScore)"
  }
  
  func gameOver() {
    updateViews()
  }
}
