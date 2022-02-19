//
//  RecipeResult.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

struct RecipeResult {
    let title: String?
    let image: String?
    let source: String?
    let healthLabels: [String]?
    
    init(recipe: Recipe?) {
        self.title = recipe?.label
        self.image = recipe?.image
        self.source = recipe?.source
        self.healthLabels = recipe?.healthLabels
    }
}
