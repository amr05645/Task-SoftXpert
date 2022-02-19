//
//  DetailsRouter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import UIKit
import SafariServices

typealias DetailsEntryPoint = PresenterToViewDetailsProtocol & SFSafariViewControllerDelegate & UIViewController

class DetailsRouter: RouterDetailsProtocol{
    
    typealias DetailsPresenterProtocol = ViewToPresenterDetailsProtocol & InteractorToPresenterDetailsProtocol
    
    
    var entry: DetailsEntryPoint?
    
    static func start(with recipe: Recipe) -> RouterDetailsProtocol {
        
        let router = DetailsRouter()
        let view: DetailsEntryPoint = RecipeDetailsVC()
        let presenter: DetailsPresenterProtocol = DetailsPresenter()
        let interactor: PresenterToInteractorDetailsProtocol = DetailsInteractor(recipe: recipe)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func presentWebSite(with url: String) {
        
        if let url = URL(string: url) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = entry
            
            entry?.present(vc, animated: true)
        }
    }
    
    func presentShareController(with url: String) {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        entry?.present(vc, animated: true)
    }
}
