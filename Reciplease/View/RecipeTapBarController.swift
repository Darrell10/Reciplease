//
//  RecipeTapBarController.swift
//  Reciplease
//
//  Created by Frederick Port on 19/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .brown
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .lightGray
    }

}
