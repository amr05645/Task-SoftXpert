//
//  HomeInteractor.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation

class HomeInteractor {
    
    weak var presenter: InteractorToPresenterHomeProtocol?
    
    var webService: WebServiceProtocol?
    
    var recipes: Recipes?
    
    var recipeResults: [RecipeResult]?
    
    var isFetchingPage: Bool = false
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func mergeOldResults(with newResult: Recipes) {
        var hits = self.recipes?.hits
        if let newHits = newResult.hits {
            hits?.append(contentsOf: newHits)
        }
        
        self.recipes = newResult
        self.recipes?.hits = hits
    }
    
}

//MARK:- InteractorToPresenterHomeProtocol
extension HomeInteractor: PresenterToInteractorHomeProtocol {
    
    func loadFilterItems() {
        presenter?.didLoadFilterItems(count: HealthFilter.items.count)
    }
    
    func getFilterItem(at index: Int) -> HealthFilter {
        return HealthFilter.items[index]
    }
    
    func loadSearchResults(for query: String) {
        webService?.searchRecipes(of: query, completion: { [weak self] (result) in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
                self?.presenter?.fetchDidRetrieve(count: recipes.hits?.count)
            case .failure(let error):
                self?.presenter?.fetchDidFail(error: error.localizedDescription)
            }
        })
    }
    
    func getSearchResult(at index: Int) -> Recipe? {
        let result = recipes?.hits?[index].recipe
        return result
    }
    
    func loadNextPage() {
        guard let nextPageUrl = recipes?.links?.next?.href else {
            presenter?.noMorePages()
            return
        }
        
        isFetchingPage = true
        webService?.getNextPage(of: nextPageUrl, completion: { [weak self] (result) in
            self?.isFetchingPage = false
            switch result {
            case .success(let recipes):
                self?.mergeOldResults(with: recipes)
                self?.presenter?.pageDidRetrieve(count: self?.recipes?.hits?.count)
            case .failure(let error):
                self?.presenter?.fetchDidFail(error: error.localizedDescription)
            }
        })
    }
    
    func filterResults(of query: String, filterIndex: Int) {
        let health = HealthFilter.items[filterIndex].rawValue
        
        webService?.filterRecipeResults(of: query, and: health, completion: { [weak self] (result) in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
                self?.presenter?.fetchDidRetrieve(count: recipes.hits?.count)
            case .failure(let error):
                self?.presenter?.fetchDidFail(error: error.localizedDescription)
            }
        })
    }
    
    func saveSuggestions(data: [String]) {
        UserDefaults.standard.setValue(data, forKey: "suggestions")
    }
    
    func getSuggestions() -> [String]? {
        let suggestions = UserDefaults.standard.array(forKey: "suggestions") as? [String]
        return suggestions
    }
}
