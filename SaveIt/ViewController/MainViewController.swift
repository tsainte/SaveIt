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
        let size = tabBarItem.image?.size ?? CGSize(width: 40, height: 40)
        let textColor: UIColor = .green
        if let accountsVC = viewControllers?[0] {
            accountsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .money, textColor: textColor, size: size)
        }
        if let settingsVC = viewControllers?[1] as? SettingsViewController {
            settingsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .cog, textColor: textColor, size: size)
        }
    }
}
