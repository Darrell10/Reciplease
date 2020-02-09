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

    var favorite: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoriteRecipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Recipe Entity
    
    func addFavoriteRecipe(label: String){
        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.label = label
        coreDataStack.saveContext()
    }
    
    func deleteFavoriteRecipe(_ favorite: FavoriteRecipe){
        coreDataStack.mainContext.delete(favorite)
                do {
                    try coreDataStack.mainContext.save()
                } catch {
                    print(error.localizedDescription)
                }
        
    }
    
}
