//
//  CustomButton.swift
//  Reciplease
//
//  Created by Frederick Port on 04/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup () {
        layer.cornerRadius = frame.width / 2
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
}

