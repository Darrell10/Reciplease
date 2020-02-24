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
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}

// MARK: - RecipeRepresentable
struct RecipeRepresentable {
    let name: String
    let totalTime: String
    let url : String
    let yield: String
    let ingredientLines: [String]
    let image: Data
}



