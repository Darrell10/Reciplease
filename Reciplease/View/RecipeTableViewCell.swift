//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Frederick Port on 27/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    var recipe: RecipeClass? {
        didSet {
            guard let recipe = recipe else{return}
            recipeImage.loadIcon(recipe.image)
            recipeImage.gradientImageWithBounds(CGRect(x: 0, y: 0, width: 200, height: 200), colors: [UIColor.yellowColor().CGColor, UIColor.blueColor().CGColor])
            recipeTitleLabel.text = recipe.label
            var healthLabelString = String()
            for label in recipe.healthLabels{
                healthLabelString += label + "  "
            }
            healthListLabel.text = healthLabelString
            if recipe.totalTime != 0 {
                timeLabel.text = String(recipe.totalTime) + " min"
            }else{
                timeLabel.text = "No time added"
            }
            yieldLabel.text = String(Int(recipe.yield))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var healthListLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeView: UIView!
    
}
