//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 02/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipeData: RecipeRepresentable?
    private var coreDataManager: CoreDataManager?
    var isInFavorite: Bool = false
    
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var recipeIV: UIImageView!
    @IBOutlet weak var favoriteRecipeBtn: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientLine: UITableView! { didSet { ingredientLine.tableFooterView = UIView() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkFavorite()
    }
}

extension DetailViewController {
    
    // MARK: - Methods
    
    /// Update DetailView
    private func updateView() {
        titleRecipeLabel.text = recipeData?.name
        guard let time = Int(recipeData?.totalTime ?? "0")?.convertTimeToString else{return}
        let convertTime = String(time)
        timeLabel.text = "Prepare time: \(convertTime)"
        recipeIV.image = UIImage(data: recipeData!.image)
    }
    
    /// Store favorite recipe
    private func storeFavorite(){
        coreDataManager?.addFavoriteRecipe(label: recipeData!.name,totalTime: String(recipeData!.totalTime),yield: String(recipeData!.yield),ingredients: recipeData!.ingredientLines,url: recipeData!.url,image: recipeData!.image)
    }
    
    /// Delete favorite Recipe
    private func deleteFavorite(){
        guard let recipeLabel = recipeData?.name else { return }
        coreDataManager?.deleteFavorite(recipeName: recipeLabel)
    }
    
    /// check if recipe is favorite
    private func checkFavorite() {
        guard let recipeLabel = recipeData?.name else { return }
        guard coreDataManager?.checkIfFavorite(recipeName: recipeLabel) == true else {
            favoriteRecipeBtn.image = UIImage(named: "favorite")
            isInFavorite = false
            return }
        favoriteRecipeBtn.image = UIImage(named: "favorite_selected")
        isInFavorite = true
    }
    
    /// return to favorite list if recipe was favorite
    private func returnToFavorite() {
        if isInFavorite == true {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailViewController {
    
    // MARK: - Action buttons

    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        guard let recipeLabel = recipeData?.name else { return }
        guard coreDataManager?.checkIfFavorite(recipeName: recipeLabel) == false else {
            favoriteRecipeBtn.image = UIImage(named: "favorite")
            deleteFavorite()
            returnToFavorite()
            return
        }
        favoriteRecipeBtn.image = UIImage(named: "favorite_selected")
        storeFavorite()
    }

    @IBAction func getDirectionButton(_ sender: Any) {
        guard let urlString = recipeData?.url else {return}
        guard let url = URL(string: urlString)else{return}
        UIApplication.shared.open(url)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - ingredients Table view
    
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
