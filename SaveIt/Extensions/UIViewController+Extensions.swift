//
//  UIViewController+Extensions.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 24/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

extension UIViewController {
    func childViewController(from navigation: UIViewController) -> UIViewController? {
        return (navigation as? UINavigationController)?.viewControllers.first
    }
}
