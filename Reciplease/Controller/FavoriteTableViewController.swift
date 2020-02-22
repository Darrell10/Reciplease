//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 04/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    private let recipeCellID = "RecipeTableViewCell"
    private var coreDataManager: CoreDataManager?
    var recipe: RecipeFavorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        tableView.tableFooterView = UIView()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: recipeCellID, bundle: nil)
        tableView.register(recipeCell, forCellReuseIdentifier: recipeCellID)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let successVC = segue.destination as? DetailViewController  else { return }
        guard let recipeName = recipe?.label,let recipeTime = recipe?.totalTime,let recipeUrl = recipe?.url,let recipeYield = recipe?.yield, let recipeIngredient = recipe?.ingredientLines, let recipeImage = recipe?.image else {return}
        let recipeRepresentable = RecipeRepresentable(name: recipeName, totalTime: String(recipeTime), url: recipeUrl, yield: String(recipeYield), ingredientLines: recipeIngredient, image: recipeImage)
        successVC.recipeData = recipeRepresentable
    }
    
    // MARK: - Table view data source and Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favorite.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellID, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let favoriteRecipe = coreDataManager?.favorite[indexPath.row]
        cell.favoriteRecipe = favoriteRecipe
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipeToDelete = coreDataManager?.favorite[indexPath.row] else { return }
            coreDataManager?.deleteFavoriteRecipe(recipeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = coreDataManager?.favorite[indexPath.row]
        performSegue(withIdentifier: "FavoriteSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3
    }
}
