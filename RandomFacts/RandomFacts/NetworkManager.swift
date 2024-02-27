//
//  NetworkManager.swift
//  RandomFacts
//
//  Created by Даниил Циркунов on 01.02.2024.
//

import Foundation

final class NetworkManager {
    private let urlString = "https://catfact.ninja/fact"
    private let jsonDecoder = JSONDecoder()

    func getFact(completion: @escaping ((FactModel?, Error?) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Error get url")
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 10

        let task = URLSession.shared.dataTask(with: request) { [jsonDecoder] data, response, error in
            if let error {
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    if let data {
                        let fact = try? jsonDecoder.decode(FactModel.self, from: data)
                        completion(fact, nil)
                    }
                default:
                    let error = NSError(domain: "com.RandomFacts.error",
                                        code: httpResponse.statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: "Произошла ошибка с кодом \(httpResponse.statusCode)"])
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
