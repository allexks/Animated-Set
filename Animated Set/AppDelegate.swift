//
//  AppDelegate.swift
//  Animated Set
//
//  Created by Aleksandar Ignatov on 5.06.19.
//  Copyright © 2019 MentorMate. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    guard let tabViewController = window?.rootViewController as? UITabBarController,
      let splitViewController = tabViewController.viewControllers?[1] as? UISplitViewController,
      let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
      let masterViewController = leftNavController.topViewController as? ThemeChooserViewController,
      let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
      let detailViewController = rightNavController.topViewController as? ConcentrationGameViewController
      else { fatalError() }
    
    masterViewController.delegate = detailViewController
    
    detailViewController.navigationItem.leftItemsSupplementBackButton = true
    detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    
    return true
  }
}

