//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 26/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    private let recipeCellID = "RecipeTableViewCell"
    var recipe: RecipeClass?
    var recipeList = [Hit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        registerTableViewCells()
    }
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: recipeCellID, bundle: nil)
        tableView.register(recipeCell, forCellReuseIdentifier: recipeCellID)
    }
    
        // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let successVC = segue.destination as? DetailViewController  else { return }
        successVC.recipe = self.recipe
    }

    // MARK: - Table view data source and Delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellID, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipeList[indexPath.row].recipe
        cell.recipe = recipe
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = recipeList[indexPath.row].recipe
        performSegue(withIdentifier: "segueID", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3
    }

}
