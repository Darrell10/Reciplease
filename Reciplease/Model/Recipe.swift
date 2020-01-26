//
//  RecipeDecodable.swift
//  Reciplease
//
//  Created by Frederick Port on 23/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation

// MARK: - Recipe
struct Recipe: Decodable {
    //let q: String
    //let from, to: Int
    //let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: RecipeClass
}

// MARK: - RecipeClass
struct RecipeClass: Decodable {
    let label: String
    let image: String
    let url: String
    let shareAs: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int

}


