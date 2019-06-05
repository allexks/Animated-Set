//
//  Themes.swift
//  Concentration
//
//  Created by Aleksandar Ignatov on 20.05.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

class Themes {
  private init() {}
  static let shared = Themes()
  
  func selectRandomTheme() -> Theme {
    return Theme.allCases.randomElement()!
  }
}

extension Themes {
  enum Theme: CaseIterable {
    case faces, japanEasy, japanMedium, japanHard, flags

    var emojiString: String {
      switch self {
      case .faces:
        return "😀😃😄😁😆😅☺️😂😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🤩🥳😏😒😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤬🤯😳🥵🥶😨😰😥😓🤗🤔🤭🤫🤥😶😐😑😬🙄😯😦😧😮😲😴🤤😪😵🤐🥴🤢🤧😷🤒🤕🤑"
      case .japanEasy:
        return "👹👺🐡🐲🎋🌊🍜🍛🍣🍱🥟🍙🍚🍘🍥🥠🥮🥢🥡🚄🚝🚅🗼🏯⛩🏣🗾🎑💴🏮🎎🎏🧧💹💮💱🀄️🇯🇵🎌🎴"
      case .japanMedium:
        return "👹👺🐡🐲🎋🌊🍜🍛🍣🍱🥟🍙🍚🍘🍥🥠🥮🥢🥡🚄🚝🚅🗼🏯⛩🏣🗾🎑💴🏮🎎🎏🧧💹💮💱🀄️🇯🇵🎌🎴🈳🈂️🈯️🈲🈴🈹🈵㊗️㊙️🉐🈷️🈺🈶🈚️🈸🉑🈁"
      case .japanHard:
        return "🈳🈂️🈯️🈲🈴🈹🈵㊗️㊙️🉐🈷️🈺🈶🈚️🈸🉑🈁"
      case .flags:
        return "🏳️‍🌈🇺🇳🇦🇫🇦🇽🇦🇱🇩🇿🇦🇸🇦🇩🇦🇶🇦🇬🇦🇷🇦🇺🇦🇼🇦🇲🇦🇹🇦🇿🇧🇸🇧🇧🇧🇩🇧🇭🇧🇾🇧🇪🇧🇿🇧🇹🇧🇲🇧🇯🇧🇴🇧🇦🇧🇼🇻🇬🇮🇴🇧🇷🇧🇳🇧🇬🇧🇫🇨🇲🇰🇭🇧🇮🇨🇦🇨🇻🇨🇫🇰🇾🇧🇶🇹🇩🇨🇱🇨🇳🇨🇴🇨🇨🇨🇽🇰🇲🇨🇬🇨🇩🇨🇮🇨🇷🇨🇰🇭🇷🇨🇺🇨🇼🇩🇰🇨🇿🇨🇾🇩🇯🇩🇲🇩🇴🇸🇻🇪🇬🇪🇨🇬🇶🇪🇷🇪🇪🇫🇰🇪🇺🇪🇹🇫🇴🇫🇯🇫🇮🇬🇫🇫🇷🇹🇫🇬🇦🇬🇲🇬🇭🇩🇪🇬🇪🇬🇮🇬🇷🇬🇱🇬🇺🇬🇵🇬🇩🇬🇹🇬🇬🇬🇳🇭🇹🇬🇾🇬🇼🇭🇳🇭🇰🇭🇺🇮🇸🇮🇳🇮🇩🇮🇪🇮🇶🇮🇷🇮🇲🇮🇱🇮🇹🇯🇵🇯🇲🇯🇪🇯🇴🇰🇿🇽🇰🇰🇮🇰🇪🇰🇼🇰🇬🇱🇦🇱🇸🇱🇧🇱🇷🇱🇾🇱🇮🇲🇴🇱🇺🇱🇹🇲🇰🇲🇬🇲🇼🇲🇱🇲🇻🇲🇾🇲🇹🇲🇭🇲🇶🇾🇹🇲🇺🇲🇷🇲🇽🇫🇲🇲🇩🇲🇪🇲🇳🇲🇨🇲🇸🇲🇦🇲🇿🇳🇷🇳🇦🇳🇵🇳🇱🇳🇨🇳🇪🇳🇮🇳🇿🇳🇬🇳🇺🇳🇫🇳🇴🇲🇵🇰🇵🇴🇲🇵🇰🇵🇼🇵🇬🇵🇦🇵🇸🇵🇾🇵🇪🇵🇭🇵🇹🇵🇱🇵🇳🇵🇷🇶🇦🇷🇪🇷🇼🇷🇺🇷🇴🇼🇸🇸🇲🇸🇹🇷🇸🇸🇳🇸🇦🇸🇨🇸🇱🇸🇬🇸🇮🇸🇰🇸🇽🇬🇸🇸🇧🇸🇴🇸🇸🇰🇷🇿🇦🇪🇸🇱🇰🇧🇱🇸🇭🇵🇲🇻🇨🇸🇩🇸🇪🇸🇿🇸🇷🇨🇭🇸🇾🇹🇼🇹🇭🇹🇿🇹🇯🇹🇬🇹🇰🇹🇳🇹🇹🇹🇴🇹🇷🇹🇲🇹🇨🇺🇬🇻🇮🇹🇻🇺🇦🇦🇪🇬🇧🏴󠁧󠁢󠁷󠁬󠁳󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁥󠁮󠁧󠁿🇺🇸🇺🇿🇻🇪🇻🇦🇻🇺🇻🇳🇼🇫🇪🇭🇿🇼🇿🇲🇾🇪"
      }
    }
    
    var appBackgroundColor: UIColor {
      switch self {
      case .faces:
        return Color.black.uiColor
      case .japanEasy, .japanMedium, .japanHard:
        return Color.white.uiColor
      case .flags:
        return Color.blue.uiColor
      }
    }
    
    var cardBackgroundColor: UIColor {
      switch self {
      case .faces:
        return Color.orange.uiColor
      case .japanEasy, .japanMedium, .japanHard:
        return Color.red.uiColor
      case .flags:
        return Color.green.uiColor
      }
    }
    
    var cardForegroundColor: UIColor {
      switch self {
      case .faces:
        return Color.white.uiColor
      case .japanEasy, .japanMedium, .japanHard:
        return Color.peachy.uiColor
      case .flags:
        return Color.yellow.uiColor
      }
    }
    
    var scoreLabelTextColor: UIColor {
      switch self {
      case .faces:
        return Color.white.uiColor
      case .japanEasy, .japanMedium, .japanHard:
        return Color.red.uiColor
      case .flags:
        return Color.black.uiColor
      }
    }
    
    var title: String {
      switch self {
      case .faces:
        return "Faces"
      case .japanEasy:
        return "Japan (Easy)"
      case .japanMedium:
        return "Japan (Medium)"
      case .japanHard:
        return "Japan (Hard)"
      case .flags:
        return "Flags"
      }
    }
    
    func getRandomEmojis(emojisCount: Int) -> String {
      guard emojisCount > 0 && emojisCount <= emojiString.count else { return "" }
      let result = emojiString.map{ String($0) }.shuffled() [..<emojisCount]
      return result.joined()
    }
  }
}

extension Themes {
  enum Color {
    case red, white, black, peachy, green, blue, yellow, orange
    
    var uiColor: UIColor {
      switch self {
      case .red:
        return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
      case .white:
        return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      case .black:
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      case .peachy:
        return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
      case .green:
        return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
      case .blue:
        return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
      case .yellow:
        return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
      case .orange:
        return #colorLiteral(red: 0.9993161559, green: 0.5778841972, blue: 0.001107421704, alpha: 1)
      }
    }
  }
}
