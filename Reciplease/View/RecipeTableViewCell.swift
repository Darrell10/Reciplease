//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Frederick Port on 27/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit
import SDWebImage

final class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Configuration cell for RecipeTableViewController
    var recipe: RecipeClass? {
        didSet {
            guard let recipe = recipe else{return}
            recipeImage.sd_setImage(with: URL(string: "\(recipe.image)"), placeholderImage: UIImage(named: "placeholder.png"))
            recipeTitleLabel.text = recipe.label
            timeLabel.text = (recipe.totalTime).convertTimeToString
            yieldLabel.text = String(Int(recipe.yield))            
        }
    }
    
    // Configuration cell for FavoriteTableViewCell
    var favoriteRecipe: RecipeFavorite? {
        didSet {
            guard let recipe = favoriteRecipe else{return}
            guard let time = Int(recipe.totalTime ?? "0")?.convertTimeToString else{return}
            let convertTime = String(time)
            if let imageData = favoriteRecipe?.image {
                recipeImage.image = UIImage(data: imageData)
            }
            recipeTitleLabel.text = recipe.label
            timeLabel.text = recipe.totalTime
            yieldLabel.text = recipe.yield
            timeLabel.text = convertTime
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    
}
