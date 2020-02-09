//
//  UIImageView+Icon.swift
//  Reciplease
//
//  Created by Frederick Port on 02/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadIcon(_ icon: String) {
       let urlString = "\(icon)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                guard d != nil else { return }
                let image = UIImage(data: d!)
                self.image = image
            }
        }.resume()
    }
}
