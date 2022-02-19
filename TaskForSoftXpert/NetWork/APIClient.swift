//
//  APIClient.swift
//  TaskForSoftXpert
//
//  Created by Amr on 2/19/22.
//

import Foundation
import Alamofire

struct APIClient {
    func performRequest<T: Decodable>(_ route: APIRouter, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(route).responseDecodable(decoder: JSONDecoder()){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
