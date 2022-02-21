//
//  HomeProtocol.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol: class {
    
    var presenter: ViewToPresenterHomeProtocol? { get set }
    
    func resetResultsView()
    func updateResultsView()
    func loadCollectionView()
    func showAlertMessage(error: String)
    func hideTableView()
    
    func showHUD()
    func hideHUD()
    
    func showFooterIndicator()
    func hideFooterIndicator()
    
    func showDropDown(with data: [String])
    func hideDropDown()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol: class {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: RouterHomeProtocol? { get set }
    var numberOfRows: Int? { get set }
    var numberOfCollectionViewItems: Int? { get set }
    
    func viewDidLoad()
    func filterItem(at index: Int) -> String?
    func search(for query: String, at filterIndex: Int)
    func resultCell(at index: Int) -> RecipeResult?
    func didDisplayLastRow()
    func didSelectRowAt(index: Int)
    func didSelectFilterItemAt(index: Int)
    func didStartTyping()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol: class {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    var webService: WebServiceProtocol? { get set }
    var isFetchingPage: Bool { get set }
    
    func loadFilterItems()
    func getFilterItem(at index: Int) -> HealthFilter
    func loadSearchResults(for query: String)
    func loadNextPage()
    func getSearchResult(at index: Int) -> Recipe?
    func filterResults(of query: String, filterIndex: Int)
    
    func saveSuggestions(data: [String])
    func getSuggestions() -> [String]?
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol: class {
    
    func didLoadFilterItems(count: Int)
    func fetchDidRetrieve(count: Int?)
    func pageDidRetrieve(count: Int?)
    func fetchDidFail(error: String)
    func noMorePages()
}


// MARK: Router Input (Presenter -> Router)
protocol RouterHomeProtocol: class {
    
    var entry: EntryPoint? { get }
    
    static func start() -> RouterHomeProtocol
    
    func pushToRecipeDetails(with recipe: Recipe)
}
