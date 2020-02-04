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
        let gradient = CAGradientLayer()
        gradient.frame = frame
        
    }
}

