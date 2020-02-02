//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 26/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    let recipeCellID = "RecipeTableViewCell"

    var recipe: RecipeClass?
    var recipeList = [Hit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeTableViewCell")
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellID, for: indexPath) as! RecipeTableViewCell
        let recipe = recipeList[indexPath.row].recipe
        cell.titleRecipeLabel.text = recipe.label
        cell.ingredientListLabel.text = recipe.ingredientLines[0]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.recipe = recipeList[indexPath.row].recipe
        performSegue(withIdentifier: "segueID", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueID" {
            guard let SuccessVC = segue.destination as? DetailViewController  else { return }
            SuccessVC.recipe = self.recipe
            }
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
