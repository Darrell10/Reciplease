//
//  RecipeService.swift
//  Reciplease
//
//  Created by Frederick Port on 23/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation

class RecipeService: MapperEncoder {
    
    // MARK: - Properties
    
    private let session: AlamoSession
    
    // MARK: - Initializer
    
    init(session: AlamoSession = EdamanSession()) {
        self.session = session
    }
    
    // MARK: - API function
    
    /// Get Recipe from Edaman API
    func getRecipe(text:[String], callback: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?") else { return }
        let params = ["q": "\(text)", "app_key": ApiConfig.edamanKey, "app_id": ApiConfig.edamanAppId]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        session.request(with: urlEncoded) { responseData in
            guard let data = responseData.data else {
                callback(.failure(NetWorkError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(NetWorkError.badUrl))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(Recipe.self, from: data) else {
                callback(.failure(NetWorkError.jsonError))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
