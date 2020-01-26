//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 26/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    var recipe: RecipeClass?
    var recipeList = [Hit]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeList.count
    }

}
