//
//  TaskForSoftXpertTests.swift
//  TaskForSoftXpertTests
//
//  Created by Amr on 2/21/22.
//

import XCTest
@testable import TaskForSoftXpert

class ModelTests: XCTestCase {
    
    func testRecipeSetGet() {
        let recipeResult = Recipe(label: "Chicken Vesuvio",
                                  image: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                                  source:
                                    "Serious Eats",
                                  url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                                  healthLabels: [
                                    "Mediterranean",
                                    "Dairy-Free",
                                    "Gluten-Free",
                                    "Wheat-Free",
                                    "Egg-Free",
                                    "Peanut-Free",
                                    "Tree-Nut-Free",
                                    "Soy-Free",
                                    "Fish-Free",
                                    "Shellfish-Free",
                                    "Pork-Free",
                                    "Red-Meat-Free",
                                    "Crustacean-Free",
                                    "Celery-Free",
                                    "Mustard-Free",
                                    "Sesame-Free",
                                    "Lupine-Free",
                                    "Mollusk-Free",
                                    "Kosher"
                                  ],
                                  ingredientLines: [
                                    "1/2 cup olive oil", "5 cloves garlic, peeled",
                                    "2 large russet potatoes, peeled and cut into chunks",
                                    "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                                    "3/4 cup white wine",
                                    "3/4 cup chicken stock",
                                    "3 tablespoons chopped parsley",
                                    "1 tablespoon dried oregano",
                                    "Salt and pepper",
                                    "Salt and pepper",
                                    "1 cup frozen peas, thawed"
                                  ])
        
        XCTAssertEqual(recipeResult.label, "Chicken Vesuvio")
        
        XCTAssertEqual(recipeResult.image, "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg")
        
        XCTAssertEqual(recipeResult.source, "Serious Eats")
        
        XCTAssertEqual(recipeResult.url, "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html")
        
        XCTAssertEqual(recipeResult.healthLabels, [
            "Mediterranean",
            "Dairy-Free",
            "Gluten-Free",
            "Wheat-Free",
            "Egg-Free",
            "Peanut-Free",
            "Tree-Nut-Free",
            "Soy-Free",
            "Fish-Free",
            "Shellfish-Free",
            "Pork-Free",
            "Red-Meat-Free",
            "Crustacean-Free",
            "Celery-Free",
            "Mustard-Free",
            "Sesame-Free",
            "Lupine-Free",
            "Mollusk-Free",
            "Kosher"
        ])
        
        XCTAssertEqual(recipeResult.ingredientLines, [
            "1/2 cup olive oil",
            "5 cloves garlic, peeled",
            "2 large russet potatoes, peeled and cut into chunks",
            "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
            "3/4 cup white wine",
            "3/4 cup chicken stock",
            "3 tablespoons chopped parsley",
            "1 tablespoon dried oregano",
            "Salt and pepper",
            "Salt and pepper",
            "1 cup frozen peas, thawed"
        ])
    }
    
}
