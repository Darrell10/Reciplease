//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 02/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    var recipeData: RecipeRepresentable?
    private var coreDataManager: CoreDataManager?
    
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var recipeIV: UIImageView!
    @IBOutlet weak var favoriteRecipeBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        updateView()
        //checkFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkFavorite()
    }
    
    func updateView() {
        titleRecipeLabel.text = recipeData?.name
        recipeIV.image = UIImage(data: recipeData!.image)
    }
    
    // MARK: - CoreDataManager Functions
    
    private func storeFavorite(){
        coreDataManager?.addFavoriteRecipe(
            label: recipeData!.name,
            totalTime: String(recipeData!.totalTime),
            yield: String(recipeData!.yield),
            ingredients: recipeData!.ingredientLines,
            url: recipeData!.url,
            image: recipeData!.image
        )
    }
    
    private func deleteFavorite(){
        coreDataManager?.deleteFromDetailFavorite(recipeName: recipeData!.name)
    }
    
    func checkFavorite() {
        guard coreDataManager?.checkIfFavorite(recipeName: recipeData!.name ) == true else {
            favoriteRecipeBtn.image = UIImage(named: "favorite")
            return }
        favoriteRecipeBtn.image = UIImage(named: "favorite_selected")
        
    }
    
    // MARK: - Action buttons
    
    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        if favoriteRecipeBtn.image == UIImage(named: "favorite") {
            favoriteRecipeBtn.image = UIImage(named: "favorite_selected")
            storeFavorite()
        } else {
            favoriteRecipeBtn.image = UIImage(named: "favorite")
            deleteFavorite()
        }
    }
    
    @IBAction func getDirectionButton(_ sender: Any) {
        guard let urlString = recipeData?.url else {return}
        guard let url = URL(string: urlString)else{return}
        UIApplication.shared.open(url)
    }
}

// MARK: - ingredients Table view

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let recipe = self.recipeData else {return 0}
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        guard let ingredient = recipeData?.ingredientLines[indexPath.row] else{
            return UITableViewCell()
        }
        cell.textLabel?.text = ingredient
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
