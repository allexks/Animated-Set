//
//  ThemeChooserViewController.swift
//  Animated Set
//
//  Created by Aleksandar Ignatov on 10.06.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

protocol ThemeChooserViewControllerDelegate: class {
  func chooseTheme(_ newTheme: Themes.Theme)
}

class ThemeChooserViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  
  // MARK: - Properties
  
  weak var delegate: ThemeChooserViewControllerDelegate?
  
  private let themes = Themes.Theme.allCases
}

//extension ThemeChooserViewController: UISplitViewControllerDelegate {
//  func splitViewController(_ splitViewController: UISplitViewController,
//                           collapseSecondary secondaryViewController: UIViewController,
//                           onto primaryViewController: UIViewController
//    ) -> Bool {
//    if let concentrationController = secondaryViewController as? ConcentrationGameViewController,
//      concentrationController.theme == nil {
//      return true
//    }
//    return false
//  }
//}

// MARK: - Table View Delegate
extension ThemeChooserViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.chooseTheme(themes[indexPath.row])
    if let concentrationViewController = delegate as? ConcentrationGameViewController,
      let concentrationNavController = concentrationViewController.navigationController {
      splitViewController?.showDetailViewController(concentrationNavController, sender: nil)
    }
  }
}

extension ThemeChooserViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Theme Cell") else {
      return UITableViewCell()
    }
    cell.textLabel?.text = themes[indexPath.row].title
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return themes.count
  }
}
