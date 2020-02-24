//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 26/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

final class RecipeTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let recipeCellID = "RecipeTableViewCell"
    var recipe: RecipeClass?
    var recipeList = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        registerTableViewCells()
    }
}

extension RecipeTableViewController {
    
    // MARK: - Methods
    
    // Load Xib Cell
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: recipeCellID, bundle: nil)
        tableView.register(recipeCell, forCellReuseIdentifier: recipeCellID)
    }
    
    // Convert image Url to Data
    private func convertImageDataFromUrl(stringImageUrl: String) -> Data{
        guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
        guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
        return data
    }
}

extension RecipeTableViewController {
    
        // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let successVC = segue.destination as? DetailViewController  else { return }
        guard let recipeName = recipe?.label,let recipeTime = recipe?.totalTime,let recipeUrl = recipe?.url,let recipeYield = recipe?.yield, let recipeIngredient = recipe?.ingredientLines, let imageUrl = recipe?.image else {return}
        let recipeRepresentable = RecipeRepresentable(name: recipeName, totalTime: String(recipeTime), url: recipeUrl, yield: String(recipeYield), ingredientLines: recipeIngredient, image: convertImageDataFromUrl(stringImageUrl: imageUrl))
        successVC.recipeData = recipeRepresentable
    }
}

extension RecipeTableViewController {
    
    // MARK: - Table view data source and Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellID, for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
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


