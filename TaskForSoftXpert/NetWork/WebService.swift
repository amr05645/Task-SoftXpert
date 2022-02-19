//
//  WebService.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation
import Alamofire

struct WebServices: WebServiceProtocol {
    
    private let networkProvider = APIClient()
    
    func searchRecipes(of query: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.search(query: query)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
    
    func filterRecipeResults(of query: String, and filter: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.filteredSearch(query, filter)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
    
    func getNextPage(of url: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.nextPage(url)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
}

protocol WebServiceProtocol {
    
    func searchRecipes(of query: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
    
    func filterRecipeResults(of query: String, and filter: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
    
    func getNextPage(of url: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
}
