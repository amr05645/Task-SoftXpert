//
//  HomeRouter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit

typealias EntryPoint = PresenterToViewHomeProtocol & UIViewController

class HomeRouter: RouterHomeProtocol {
    
    typealias HomePresenterProtocol = ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol
    
    
    var entry: EntryPoint?
    
    static func start() -> RouterHomeProtocol {
        
        let webService = WebServices()
        
        let router = HomeRouter()
        let view: EntryPoint = HomeVC()
        let presenter: HomePresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorHomeProtocol = HomeInteractor(webService: webService)
        
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

