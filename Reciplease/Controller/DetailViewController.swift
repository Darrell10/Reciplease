//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 02/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var recipe: RecipeClass?
    
    
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var recipeIV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        print(recipe!.image)

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        titleRecipeLabel.text = recipe?.label
        recipeIV.loadIcon(recipe!.image)
        recipeIV.contentMode = .scaleAspectFill
        
    }
    
    
    @IBAction func getDirectionButton(_ sender: Any) {
        guard let urlString = recipe?.url else {return}
        guard let url = URL(string: urlString)else{return}
        UIApplication.shared.open(url)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let recipe = self.recipe else {return 0}
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            guard let ingredient = recipe?.ingredientLines[indexPath.row] else{
                return UITableViewCell()
            }
            cell.textLabel?.text = ingredient
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
