//
//  HomeRouter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit

typealias EntryPoint = PresenterToViewSearchProtocol & UIViewController

class SearchRouter: RouterSearchProtocol {
    
    typealias SearchPresenterProtocol = ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol
    
    
    var entry: EntryPoint?
    
    static func start() -> RouterSearchProtocol {
        
        let webService = WebServices()
        
        let router = SearchRouter()
        let view: EntryPoint = HomeVC()
        let presenter: SearchPresenterProtocol = SearchPresenter()
        let interactor: PresenterToInteractorSearchProtocol = SearchInteractor(webService: webService)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func pushToRecipeDetails(with recipe: Recipe) {
        
        let router = DetailsRouter.start(with: recipe)
        guard let detailsVC = router.entry else {return}

        entry?.navigationController?.pushViewController(detailsVC, animated: true)
    }

}

