//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Frederick Port on 27/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    @IBOutlet weak var ingredientListLabel: UILabel!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    
    
}
