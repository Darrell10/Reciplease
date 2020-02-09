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

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        tableView.tableFooterView = UIView()
        //registerTableViewCells()
        print(coreDataManager?.favorite.count as Any)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: recipeCellID, bundle: nil)
        tableView.register(recipeCell, forCellReuseIdentifier: recipeCellID)
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favorite.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        favoriteCell.textLabel?.text = coreDataManager?.favorite[indexPath.row].label
        return favoriteCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipeToDelete = coreDataManager?.favorite[indexPath.row] else { return }
            coreDataManager?.deleteFavoriteRecipe(recipeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
