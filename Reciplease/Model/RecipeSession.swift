//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Frederick Port on 23/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
    }

final class EdamanSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}
