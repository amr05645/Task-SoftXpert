//
//  DetailsInteractor.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

class DetailsInteractor {
    
   weak var presenter: InteractorToPresenterDetailsProtocol?
    
    var recipe: Recipe?
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

//MARK:- PresenterToInteractorDetailsProtocol
extension DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
    func getRecipe() {
        presenter?.fetchDidRetrieve(details: self.recipe)
    }
    
    func getRecipeUrl() -> String? {
        return recipe?.url
    }
}
