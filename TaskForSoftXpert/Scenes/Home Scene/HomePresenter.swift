//
//  HomePresenter.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

class HomePresenter {
    
    weak var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: RouterHomeProtocol?
    
    var numberOfRows: Int?
    var numberOfCollectionViewItems: Int?
    
    var query: String?
    
    func handleSearchOptions(for query: String, and filterIndex: Int) {
        view?.showHUD()
        if filterIndex == 0 {
            interactor?.loadSearchResults(for: query)
        } else {
            interactor?.filterResults(of: query, filterIndex: filterIndex)
        }
    }
    
    func checkIfValid(query: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            
            if regex.firstMatch(in: query, options: [], range: NSMakeRange(0, query.count)) != nil {
                return false
                
            } else {
                return true
            }
        }
        catch {
            print(error)
            return false
        }
    }
    
    func getSuggestions() -> [String] {
        return interactor?.getSuggestions() ?? [String]()
    }
}

//MARK:- ViewToPresenterHomeProtocol
extension HomePresenter: ViewToPresenterHomeProtocol {
    func didStartTyping() {
        let suggestions = getSuggestions()
        
        if suggestions.count > 0 {
            view?.showDropDown(with: suggestions.reversed())
        }
    }
    
    func viewDidLoad() {
        interactor?.loadFilterItems()
    }
    
    func filterItem(at index: Int) -> String? {
        let title = interactor?.getFilterItem(at: index).rawValue.capitalized.replacingOccurrences(of: "-", with: " ")
        return title
    }
    
    func search(for query: String, at filterIndex: Int) {
        view?.hideDropDown()
        self.query = query
        
        if checkIfValid(query: query) {
            handleSearchOptions(for: query, and: filterIndex)
        } else {
            view?.showAlertMessage(error: "Search text must only contain alphabet and spaces")
        }
        
        var suggestions = interactor?.getSuggestions() ?? [String]()
        if suggestions.count >= 10 {
            suggestions.removeFirst()
        }
        suggestions.append(query)
        interactor?.saveSuggestions(data: suggestions)
    }
    
    func resultCell(at index: Int) -> RecipeResult? {
        let result = interactor?.getSearchResult(at: index)
        let cellData = result.map { RecipeResult(recipe: $0)}
        return cellData
    }
    
    func didDisplayLastRow() {
        view?.showFooterIndicator()
        guard !(interactor!.isFetchingPage) else {return}
        self.interactor?.loadNextPage()
    }
    
    func didSelectRowAt(index: Int) {
        guard let recipe = interactor?.getSearchResult(at: index) else {return}
        router?.pushToRecipeDetails(with: recipe)
    }
    
    func didSelectFilterItemAt(index: Int) {
        
        guard let query = self.query else {return}
        handleSearchOptions(for: query, and: index)
    }
    
}

//MARK:- InteractorToPresenterHomeProtocol
extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func didLoadFilterItems(count: Int) {
        self.numberOfCollectionViewItems = count
        view?.loadCollectionView()
    }
    
    func fetchDidRetrieve(count: Int?) {
        view?.hideHUD()
        guard count ?? 0 > 0 else {
            view?.hideTableView()
            return
        }
        
        self.numberOfRows = count
        view?.resetResultsView()
        view?.hideFooterIndicator()
    }
    
    func pageDidRetrieve(count: Int?) {
        self.numberOfRows = count
        view?.updateResultsView()
        view?.hideFooterIndicator()
    }
    
    func fetchDidFail(error: String) {
        view?.hideHUD()
        view?.showAlertMessage(error: error)
        view?.hideFooterIndicator()
    }
    
    func noMorePages() {
        view?.hideFooterIndicator()
    }
}
