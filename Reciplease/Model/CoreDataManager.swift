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

    var ingredients: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let ingredients = try? managedObjectContext.fetch(request) else { return [] }
        return ingredients
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Ingredient Entity

    func addIngredient(name: String) {
        let ingredient = Ingredient(context: managedObjectContext)
        ingredient.name = name
        coreDataStack.saveContext()
    }

    func deleteAllIngredients() {
        ingredients.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
