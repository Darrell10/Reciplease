//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Frederick Port on 27/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    
    var recipe: RecipeClass? {
        didSet {
            guard let recipe = recipe else{return}
            recipeImage.sd_setImage(with: URL(string: "\(recipe.url)"), placeholderImage: UIImage(named: "placeholder.png"))
            //recipeImage.loadIcon(recipe.image)
            recipeTitleLabel.text = recipe.label
            if recipe.totalTime >= 60 {
                timeLabel.text = String(recipe.totalTime / 60) + " h " + String(recipe.totalTime % 60) + " min"
            }else if recipe.totalTime == 0 {
                timeLabel.text = "No time added"
            } else {
                timeLabel.text = String(recipe.totalTime) + " min"
            }
            yieldLabel.text = String(Int(recipe.yield))            
        }
    }
    
    var favoriteRecipe: FavoriteRecipe? {
        didSet {
            guard let recipe = favoriteRecipe else{return}
            //guard let totalTime = recipe.totalTime else {return}
            //guard let yield = recipe.yield else {return}
            guard let label = recipe.label else {return}
            //timeLabel.text = totalTime
            recipeTitleLabel.text = label
            //yieldLabel.text = yield
        }
    }
    
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    
}
