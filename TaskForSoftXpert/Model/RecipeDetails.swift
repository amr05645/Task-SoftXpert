//
//  RecipeDetails.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

struct RecipeDetails {
    let title: String?
    let image: String?
    let url: String?
    let ingredients: [String]?
    
    init(recipe: Recipe?) {
        self.title = recipe?.label
        self.image = recipe?.image
        self.url = recipe?.url
        self.ingredients = recipe?.ingredientLines
    }
}
