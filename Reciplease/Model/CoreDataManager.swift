//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Frederick Port on 16/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favorite: [RecipeFavorite] {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoriteRecipes
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
}

extension CoreDataManager {
    
    // MARK: - Manage Recipe Entity
    
    /// Store Recipe in CoreData
    func addFavoriteRecipe(label: String, totalTime: String, yield: String, ingredients: [String],url: String, image: Data){
        let favoriteRecipe = RecipeFavorite(context: managedObjectContext)
        favoriteRecipe.label = label
        favoriteRecipe.totalTime = totalTime
        favoriteRecipe.yield = yield
        favoriteRecipe.ingredientLines = ingredients as [String]?
        favoriteRecipe.url = url
        favoriteRecipe.image = image
        coreDataStack.saveContext()
    }
    
    /// Delete favorite in CoreData
    func deleteFavorite(recipeName: String) {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        let predicate = NSPredicate(format: "label == %@", recipeName)
        request.predicate = predicate
        if let objectContext = try? managedObjectContext.fetch(request) {
            objectContext.forEach { managedObjectContext.delete($0)}
        }
        coreDataStack.saveContext()
    }
    
    /// Check if Recipe is favorite
    func checkIfFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", recipeName)
        guard let recipeSearch = try? managedObjectContext.fetch(request) else { return false }
        if recipeSearch.isEmpty {return false}
        return true
    }
    
}
