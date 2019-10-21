//
//  NetworkService.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 21.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("some error")
    //                    completion(nil, error)
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else { return }
                    do {
                        let news = try JSONDecoder().decode(SearchResponse.self, from: data)
    //                    completion(news, nil)
                        completion(.success(news))
                    } catch let jsonError {
                        print("Failed to decode JSON", jsonError)
    //                    completion(nil, jsonError)
                        completion(.failure(jsonError))
                    }
                    
    //                let someString = String(data: data, encoding: .utf8)
    //                print(someString ?? "no data")
                }
            }.resume()
        }
}
