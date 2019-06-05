//
//  ConcentrationGameDelegate.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 17.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import Foundation

protocol ConcentrationGameDelegate: class {
  func updateScore(newScore: Int)
  func registerMatch(firstIndex: Int, secondIndex: Int)
  func registerMismatch(firstIndex: Int, secondIndex: Int)
}
