//
//  DetailRecipeView.swift
//  Reciplease
//
//  Created by Frederick Port on 04/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class DetailRecipeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup () {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3
        alpha = 0.95
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.75
    }
}

