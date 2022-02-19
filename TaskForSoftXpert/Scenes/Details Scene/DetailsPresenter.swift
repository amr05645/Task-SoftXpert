//
//  DetailsPresenter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

class DetailsPresenter {
    
    weak var view: PresenterToViewDetailsProtocol?
    
    var interactor: PresenterToInteractorDetailsProtocol?
    
    var router: RouterDetailsProtocol?
    
}

//MARK:- ViewToPresenterDetailsProtocol
extension DetailsPresenter: ViewToPresenterDetailsProtocol {
    
    func viewDidLoad() {
        interactor?.getRecipe()
    }
    
    func didTapWebite() {
        self.router?.presentWebSite(with: interactor?.getRecipeUrl() ?? "")
    }
    
    func didTapShare() {
        self.router?.presentShareController(with: interactor?.getRecipeUrl() ?? "")
    }
}

//MARK:- InteractorToPresenterDetailsProtocol
extension DetailsPresenter: InteractorToPresenterDetailsProtocol {
    func fetchDidRetrieve(details: Recipe?) {
        let details = RecipeDetails(recipe: details)
        
        let ingredients = details.ingredients?.joined(separator: "\n")
        
        view?.updateDetailsView(title: details.title ?? "", imageUrl: details.image ?? "", ingredients: ingredients ?? "")
    }
}
