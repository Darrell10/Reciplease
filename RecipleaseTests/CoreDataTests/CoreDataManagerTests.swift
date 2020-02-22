//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Frederick Port on 22/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

@testable import Reciplease
import XCTest

class CoreDataManagerTests: XCTestCase {
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    func testAddRecipeMethods_WhenEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.addFavoriteRecipe(label: "Recette PatePouletKrock", totalTime: "10", yield: "50", ingredients: ["Patepoulet", "Kroquette"], url: "http//lespotichats.com", image: Data())
        XCTAssertTrue(!coreDataManager.favorite.isEmpty)
        XCTAssertTrue(coreDataManager.favorite.count == 1)
        XCTAssertTrue(coreDataManager.favorite[0].label! == "Recette PatePouletKrock")
    }
    
    func testSearchRecipeMethods_WhenEntityIsCreated_ThenRecipeIsFavorite() {
        coreDataManager.addFavoriteRecipe(label: "Recette PatePouletKrock", totalTime: "10", yield: "50", ingredients: ["Patepoulet", "Kroquette"], url: "http//lespotichats.com", image: Data())
        XCTAssertTrue(coreDataManager.checkIfFavorite(recipeName: "Recette PatePouletKrock"))
    }
    
    func testDeleteRecipe_WhenEntityIsCreated_ThenRecipeIsCorrectyRemoved(){
        coreDataManager.addFavoriteRecipe(label: "Recette PatePouletKrock", totalTime: "10", yield: "50", ingredients: ["Patepoulet", "Kroquette"], url: "http//lespotichats.com", image: Data())
        coreDataManager.deleteFavorite(recipeName: "Recette PatePouletKrock")
        XCTAssertTrue(coreDataManager.favorite.isEmpty)
        
    }
    
}
