//
//  MainViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarIcons()
    }

    func configureTabBarIcons() {
        let size = CGSize(width: 40, height: 40)
        let textColor: UIColor = .green
        guard let viewControllers = viewControllers else { return }

        for viewController in viewControllers {
            if let accountsVC = childViewController(from: viewController) as? AccountsViewController {
                accountsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .money, textColor: textColor, size: size)
                accountsVC.tabBarItem.title = "Accounts"
            } else if let settingsVC = childViewController(from: viewController) as? SettingsViewController {
                settingsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .cog, textColor: textColor, size: size)
                settingsVC.tabBarItem.title = "Settings"
            }
        }
    }
}
